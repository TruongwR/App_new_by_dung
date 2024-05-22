import 'package:get/get.dart';

import '../controllers/manage_profile_controller.dart';

class AddProfileHealthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddProfileHealthController>(
      () => AddProfileHealthController(),
    );
  }
}
