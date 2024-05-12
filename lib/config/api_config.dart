import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:news_app_ui/data/model/pair.dart';
import 'package:news_app_ui/utils/auth_service.dart';
import 'package:news_app_ui/utils/constants.dart';
import 'package:news_app_ui/utils/constants/environment.dart';

final dio = Dio();

class ApiConfig {
  bool _newToken = false;

  bool _blockRequest = false;
  final List<Pair<DioException, ErrorInterceptorHandler>> _queueRequest = [];

  static ApiConfig init() {
    return ApiConfig._();
  }

  ApiConfig._() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) async {
          if (e.response?.statusCode == 401) {
            if (_newToken) {
              final newToken = AuthService.to.auth.accessToken!;
              return _retryRequest(e, handler, newToken);
            }
            _queueRequest.add(Pair(first: e, second: handler));
            if (_blockRequest) {
              return;
            }
            _blockRequest = true;
            String newToken = await _refreshToken(e.requestOptions.path);
            if (newToken.isEmpty) {
              // Reject 1 request bất kỳ để logout, các request khác bỏ qua tránh việc show nhiều dialog
              DioException e = _queueRequest.first.first;
              ErrorInterceptorHandler handler = _queueRequest.first.second;
              handler.reject(e);
            } else {
              for (var element in _queueRequest) {
                DioException e = element.first;
                ErrorInterceptorHandler handler = element.second;
                _retryRequest(e, handler, newToken);
              }
            }
            _queueRequest.clear();
            _blockRequest = false;
          } else {
            return handler.next(e);
          }
        },
      ),
    );
  }

  void _retryRequest(DioException e, ErrorInterceptorHandler handler, String newToken) async {
    final requestOptions = e.requestOptions;
    requestOptions.headers['Authorization'] = 'Bearer $newToken';
    final response = await dio.fetch(requestOptions);
    handler.resolve(response);
  }

  Future<String> _refreshToken(String path) async {
    try {
      log('======================== REFRESH TOKEN $path ========================');
      final authService = AuthService.to;

      final response = await dio.get('${environment.url}/refresh-token');
      final data = response.data;
      final code = data['code'];
      if (code == 200) {
        final access = data;

        authService.getAuthModel()!.accessToken = access;
        authService.saveNewAccessAndRefreshToken(access);
        log('========== RefreshToken Success $access');
        _newToken = true;
        Future.delayed(const Duration(seconds: 60)).then((value) {
          log('Reset newToken');
          _newToken = false;
        });
        return access;
      } else {
        log('_refreshToken code $code');
        throw 'Cannot refresh Token $data';
      }
    } catch (ex) {
      return '';
    }
  }
}
