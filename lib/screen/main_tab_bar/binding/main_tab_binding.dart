import 'package:get/get.dart';
import 'package:news_app_ui/screen/home/home_controller.dart';
import 'package:news_app_ui/screen/main_tab_bar/controller/main_tab_controller.dart';

class MainTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainTabController>(
      () => MainTabController(),
    );
     Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
