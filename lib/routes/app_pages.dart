import 'package:get/get.dart';

import '../screen/bookmark/bindings/bookmark_binding.dart';
import '../screen/bookmark/views/bookmark_view.dart';
import '../screen/home/home_page.dart';
import '../screen/home/widgets/home_binding.dart';
import '../screen/login/bindings/login_binding.dart';
import '../screen/login/views/login_view.dart';
import '../screen/main_tab_bar/binding/main_tab_binding.dart';
import '../screen/main_tab_bar/main_tab_bar.dart';
import '../screen/manager_profile/bindings/manage_profile_binding.dart';
import '../screen/manager_profile/views/mange_profile_view.dart';

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
    GetPage(
      name: _Paths.BOOKMARK,
      page: () => const BookmarkView(),
      binding: BookmarkBinding(),
    ),
  ];
}
