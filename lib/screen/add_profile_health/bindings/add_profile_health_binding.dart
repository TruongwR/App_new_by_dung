import 'package:get/get.dart';

import '../controllers/add_profile_health_controller.dart';

class AddProfileHealthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddProfileHealthController>(
      () => AddProfileHealthController(),
    );
  }
}
