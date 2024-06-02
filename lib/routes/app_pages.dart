import 'package:get/get.dart';
import 'package:news_app_ui/screen/add_profile_health/bindings/manage_profile_binding.dart';
import 'package:news_app_ui/screen/add_profile_health/views/mange_profile_view.dart';
import 'package:news_app_ui/screen/home/home_page.dart';
import 'package:news_app_ui/screen/home/widgets/home_binding.dart';
import 'package:news_app_ui/screen/login/bindings/login_binding.dart';
import 'package:news_app_ui/screen/login/views/login_view.dart';
import 'package:news_app_ui/screen/main_tab_bar/main_tab_bar.dart';
import 'package:news_app_ui/screen/main_tab_bar/binding/main_tab_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const MainTabBar(),
      binding: MainTabBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PROFILE_HEALTH,
      page: () => const AddProfileHealthView(),
      binding: AddProfileHealthBinding(),
    ),
    GetPage(
      name: _Paths.HOMEBOUND,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
