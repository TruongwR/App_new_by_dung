import 'package:news_app_ui/data/model/auth_model.dart';
import 'package:news_app_ui/data/model/new_model.dart';

import 'package:news_app_ui/data/model/pagination.dart';
import 'package:news_app_ui/data/providers/base_provider.dart';

import 'package:news_app_ui/utils/notify.dart';

class AuthProvider extends BaseProvider {
  Future<Auth?> login({required String phone, required String password}) async {
    final data = {"phone": phone, "password": password};
    final respon = await postWithoutHandle('/login', queryParameters: data);
    if (respon.statusCode != null && respon.statusCode! ~/ 100 == 2) {
      final auth = Auth.fromJson(respon.data);
      authService.setAuthModel(auth);
      return auth;
    } else {
      Notify.error(respon.data['message']);
      return null;
    }
  }

  Future<bool?> register({
    required String phone,
    required String name,
    required String email,
    required String password,
    required String address,
    required String date,
    required int sex,
  }) async {
    final data = {
      "phone": phone,
      "name": name,
      "email": email,
      "password": password,
      "address": address,
      "birthDate": date,
      "gender": "$sex",
      "role": {"id": "3"}
    };

    await postRequest('/register/user', data);

    return true;
  }

  Future<bool> logout() async {
    // await getRequest('/api/logout');
    authService.logOut();
    return true;
  }

  Future<PaginationData<NewsModel>?> fetchNew({required int page, required int limit, required bool newest}) async {
    final dataBody = {"newest": newest};
    return await getRequestPagination(
        api: '/news/home?page=$page&size=$limit',
        parse: (json) => NewsModel.fromJson(json),
        queryParameters: dataBody);
  }
}
