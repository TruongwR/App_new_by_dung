import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:news_app_ui/data/providers/auth_provider.dart';
import 'package:news_app_ui/data/providers/base_controller/base_controller.dart';
import 'package:news_app_ui/screen/manager_profile/views/mange_profile_view.dart';
import 'package:news_app_ui/utils/auth_service.dart';

class AddProfileHealthController extends BaseController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController mailController = TextEditingController();

  FocusNode phoneFocusNode = FocusNode();
  FocusNode cmtFocusNode = FocusNode();

  final AuthService auth = Get.find<AuthService>();
  final provinceAutoFocus = FocusNode().obs;
  final tinhFocus = FocusNode();

  final height = (0.0).obs;
  final heightKeyBoard = (0.0).obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<DateTime> selectedLMDate = DateTime.now().obs;
  Rx<String> selectedGender = ''.obs;
  Rx<String> selectedRelationship = ''.obs;

  final AuthProvider authProvider = AuthProvider();
  final List<String> listGender = ['Nam', 'Nữ'];

  @override
  void onInit() {
    phoneController.text = auth.auth.user?.phone ?? '';
    nameController.text = auth.auth.user?.name ?? '';
    genderController.text =
        listGender.elementAt(int.parse(auth.auth.user?.gender ?? '1'));
    selectedDate.value = auth.auth.user?.birthDate?? DateTime.now();
    mailController.text = auth.auth.user?.email ?? '';
    super.onInit();
  }

  String convertPhoneNumber(String phoneNumber) {
    int slashIndex = phoneNumber.indexOf('/');

    if (slashIndex == -1 || slashIndex == 0) {
      return phoneNumber;
    }
    String convertedPhoneNumber = phoneNumber.substring(slashIndex + 1);
    return '0$convertedPhoneNumber';
  }

  void saveProfile({required BuildContext context}) async {
    log('formKey5.currentState  ${formKey5.currentState}-- ${!(formKey5.currentState!.validate())} ');
    if (!validatePhoneNumber()) {
      return;
    }

    if (formKey5.currentState == null || !(formKey5.currentState!.validate())) {
      return;
    }

    final repond = await authProvider.udpateProfile(
        id: auth.auth.user?.id,
        phone: phoneController.text,
        name: nameController.text,
        email: mailController.text,
        password: '',
        address: '',
        date: selectedDate.string,
        sex: genderController.value.toString() == 'nam' ? 0 : 1
     );

    Get.back();
  }

  void deleteOldProfile({required int index}) async {}

  void saveOldProfile(
      {required int index, required BuildContext context}) async {
    log('formKey5.currentState  ${formKey5.currentState}-- ${!(formKey5.currentState!.validate())} ');
    if (!validatePhoneNumber()) {
      return;
    }
    // if (!validateCMTBool()) {
    //   return;
    // }

    if (formKey5.currentState == null || !(formKey5.currentState!.validate())) {
      return;
    }

    Get.back();
  }

  bool validatePhoneNumber() {
    if (phoneController.text.isEmpty) {
      phoneFocusNode.requestFocus();

      return false;
    }

    return true;
  }

  String? validatorUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Họ và Tên là bắt buộc';
    }
    return null;
  }

  String? validatorPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Số điện thoại là bắt buộc';
    }
    if (value.length < 9 || value.length > 10) {
      return 'Vui lòng nhập từ 10 - 11  số';
    }
    return null;
  }
}
