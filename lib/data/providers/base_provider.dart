import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:news_app_ui/data/model/pagination.dart';

import 'package:news_app_ui/utils/auth_service.dart';
import 'package:news_app_ui/utils/constants.dart';
import 'package:news_app_ui/utils/constants/environment.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class BaseProvider {
  final dio = Dio();
  final authService = AuthService.to;
  String kBaseUrl = environment.url;

  BaseProvider() {
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 1000));
  }

  Map<String, String> _tokenHeader() {
    String token = authService.getAuthModel()?.accessToken ?? '';
    if (token.isNotEmpty) {
      return {'Content-Type': 'application/json', 'Accept': 'application/json', 'Authorization': 'Bearer $token'};
    }
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    };
  }

  /// 'GET', 'POST', 'PUT', 'PATCH', 'DELETE'
  Future<dynamic> _fetchRequest({
    required String path,
    required String method,
    dynamic data,
    ValidateStatus? validateStatus,
    bool? followRedirects,
  }) async {
    try {
      log('REQUEST [$method] ====> $path');
      final RequestOptions options = RequestOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        baseUrl: kBaseUrl,
        path: path,
        method: method,
        data: data,
        headers: _tokenHeader(),
        validateStatus: validateStatus,
        followRedirects: followRedirects,
      );
      final response = await dio.fetch(options);
      return _handleResponse(path, response);
    } catch (ex) {
      return _handleError(ex, path);
    }
  }

  Future<dynamic> getRequest(
    String api, {
    ValidateStatus? validateStatus,
    bool? followRedirects,
  }) async {
    return await _fetchRequest(
      path: api,
      method: 'GET',
      validateStatus: validateStatus,
      followRedirects: followRedirects,
    );
  }

  Future<dynamic> postRequest(String api, body) async {
    return await _fetchRequest(path: api, method: 'POST', data: body);
  }

  Future<dynamic> putRequest(String api, body) async {
    return await _fetchRequest(path: api, method: 'PUT', data: body);
  }

  Future<Response<dynamic>> getWithoutHandle(
    String api, {
    dynamic queryParameters,
    dynamic body,
    ValidateStatus? validateStatus,
    bool? followRedirects,
  }) async {
    return dio
        .get('$kBaseUrl$api', data: body, queryParameters: queryParameters, options: Options(headers: _tokenHeader()))
        .catchError(
      (Object e) {
        if (e is DioException && e.response != null) {
          return e.response!;
        }
        return Response(statusCode: -1, requestOptions: RequestOptions());
      },
    );
  }

  Future<Response<dynamic>> postWithoutHandle(
    String url, {
    dynamic queryParameters,
    dynamic body,
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) {
    return dio
        .post('$kBaseUrl$url', data: body, queryParameters: queryParameters, options: Options(headers: _tokenHeader()))
        .catchError(
      (Object e) {
        if (e is DioException && e.response != null) {
          return e.response!;
        }
        return Response(statusCode: -1, requestOptions: RequestOptions());
      },
    );
  }

  Future<dynamic> patchRequest(String api, body) async {
    return await _fetchRequest(path: api, method: 'PATCH', data: body);
  }

  Future<dynamic> deleteRequest(String api, body) async {
    return await _fetchRequest(path: api, method: 'DELETE');
  }

  Future<PaginationData<T>> getRequestPagination<T>({
    required String api,
    required T Function(dynamic) parse,
    dynamic queryParameters,
    dynamic data,
  }) async {
    try {
      log('REQUEST [GET] ====> $api');
      final RequestOptions options = RequestOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        queryParameters: queryParameters,
        baseUrl: kBaseUrl,
        path: api,
        method: 'GET',
        data: data,
        headers: _tokenHeader(),
      );

      final response = await dio.fetch(options);

      return _handleResponsePagination(api, response, parse);
    } catch (ex) {
      throw _handleError(ex, api);
    }
  }

  PaginationData<T> _handleResponsePagination<T>(
    String api,
    Response response,
    T Function(dynamic) parse,
  ) {
    int? statusCode = response.statusCode;
    if (statusCode != null && statusCode ~/ 100 == 2) {
      log('RESPONSE [$statusCode] ====> $api');
      dynamic result = response.data;
      final data = result['content'];
      dynamic paginationJson = result;
      final list = data as List<dynamic>;
      final model = list.map((e) => parse(e)).toList();
      final pagination = Pagination.fromJson(paginationJson);
      return PaginationData(list: model, pagination: pagination);
    } else {
      final message = response.data['message'];
      throw message;
    }
  }

  dynamic _handleResponse(String api, Response response) {
    int? statusCode = response.statusCode;
    if (statusCode != null && statusCode ~/ 100 == 2) {
      log(response.data.runtimeType.toString());
      if (response.data == "1") {
        return true;
      } else if (response.data == "0") {
        return false;
      } else {
        return response.data;
      }
    } else {
      throw response;
    }
  }

  dynamic decodeResponse({dynamic response}) {
    List<int> byteData = base64.decode(response);

    String utf8String = utf8.decode(byteData);

    Map<String, dynamic> jsonData = json.decode(utf8String);
    return jsonData;
  }
  // dynamic _handleResponse(String api, Response response) {
  //   int? statusCode = response.statusCode;
  //   if (statusCode != null && statusCode ~/ 100 == 2) {
  //     dynamic result = response.data;
  //     // final status = result['status'];
  //     final code = result['code'];
  //     final data = result['data'];

  //     logd('RESPONSE [$code] ====> $api');
  //     if (code ~/ 100 == 2) {
  //       // logJSON('Response', data);
  //       return data;
  //     } else {
  //       loge(result);
  //       final message = result['message'];
  //       throw message;
  //     }
  //   } else {
  //     throw response;
  //   }
  // }

  Future _handleError(dynamic ex, String page) {
    if (ex is DioException) {
      final data = ex.response;
      log('API: $page ====> $data');
      return Future.error(
        data ??
            Response(
              statusCode: -1,
              requestOptions: RequestOptions(),
              statusMessage: ex.toString(),
            ),
      );
    }
    return Future.error(ex);
  }

  handleError(dynamic res) {
    if (res == null || res.statusCode == null) {
      throw "No internet connection, please check connection again!";
    }
    if (res.statusCode == 401) {
      authService.logOut();
      throw "Your session has expired. please log in again";
    }
    if (res is Response) {
      throw getError(res.data);
    }
    throw getError(res.body);
  }

  getError(dynamic data) {
    log("data: $data");
    if (data == null) {
      return "Empty response";
    }
    if (data['detail'] is String) {
      return data['detail'];
    }
    if (data is Map) {
      var value = data.values.first;
      if (value is List) {
        return value.first;
      }
      return value;
    }
    return data;
  }

  /// DEPRECATE

  @Deprecated('Use getRequest instead!!!')
  Future<Response<dynamic>> get(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
  }) {
    return dio
        .get(
      '$kBaseUrl$url',
      options: Options(headers: _tokenHeader()),
    )
        .catchError(
      (Object e) {
        log(e.toString());
        return Response(requestOptions: RequestOptions());
      },
    );
  }

  @Deprecated('Use postRequest instead!!!')
  Future<Response<dynamic>> post(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) {
    return dio
        .post(
      '$kBaseUrl$url',
      data: body,
      options: Options(headers: _tokenHeader()),
    )
        .catchError((Object e) {
      if (e is DioException && e.response != null) {
        return e.response!;
      }
      return Response(statusCode: -1, requestOptions: RequestOptions());
    });
  }

  @Deprecated('Use patchRequest instead!!!')
  Future<Response<dynamic>> patch(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) {
    return dio
        .patch(
      '$kBaseUrl$url',
      data: body,
      options: Options(headers: _tokenHeader()),
    )
        .catchError((Object e) {
      if (e is DioException && e.response != null) {
        return e.response!;
      }
      return Response(statusCode: -1, requestOptions: RequestOptions());
    });
  }

  @Deprecated('Use deleteRequest instead!!!')
  Future<Response<dynamic>> delete(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
  }) {
    return dio
        .delete(
      '$kBaseUrl$url',
      options: Options(headers: _tokenHeader()),
    )
        .catchError((Object e) {
      if (e is DioException && e.response != null) {
        return e.response!;
      }
      return Response(statusCode: -1, requestOptions: RequestOptions());
    });
  }
}

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    log(err.toString());
    super.onError(err, handler);
  }
}

extension ResponseEx<T> on Response<T> {
  dynamic get body => data;

  String? get statusText => statusMessage;
}
