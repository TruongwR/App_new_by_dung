import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_app_ui/data/model/auth_model.dart';

import '../routes/app_pages.dart';


class AuthService extends GetxService {
  Auth? _auth;
  final _getStorage = GetStorage();
  final _authKey = 'auth';
  final _roleKey = 'type_role';
  final _authModel = 'auth_model';
  static AuthService get to => Get.find<AuthService>();

  Future<AuthService> init() async {

    final data = readAutherModel();
    if (data != null) {
      _auth = Auth.fromJsonOld(data!);
    }
    return this;
  }

  Auth get auth {
    return _auth!;
  }

  dynamic getAccessToken() {
    final data = _getStorage.read(_authKey);
    if (data == null) {
      return null;
    } else {
      return data;
    }
  }

  String? getRole() {
    final data = _getStorage.read(_roleKey);
    if (data == null) {
      return null;
    } else {
      return data;
    }
  }

  dynamic readAutherModel() {
    return _getStorage.read(_authModel);
  }

  void saveAuthJson(String data) {
    _getStorage.write(_authKey, data);
  }

  void saveRole(String data) {
    _getStorage.write(_roleKey, data);
  }

  void saveNewAccessAndRefreshToken(String accessToken) {
    final authJson = _getStorage.read(_authKey);

    saveAuthJson(authJson);
  }

  void removeToken() {
    GetStorage().remove('auth');
  }

  void removeRole() {
    GetStorage().remove(_roleKey);
  }

  void removeAuther() {
    GetStorage().remove('auth_model');
  }

  void setAuthModel(Auth auth) async {
    _auth = auth;
    final auhtModel = auth.toJson();

    GetStorage().write(_authModel, auhtModel);
  }

  Auth? getAuthModel() {
    return _auth;
  }

  bool hasLogin() => _auth?.accessToken != null;

  void logOut() {
    removeAuther();
    removeToken();
    removeRole();
    Get.offAllNamed(Routes.LOGIN);
  }
}
