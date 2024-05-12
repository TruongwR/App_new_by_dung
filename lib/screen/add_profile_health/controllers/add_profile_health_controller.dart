import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:news_app_ui/data/providers/auth_provider.dart';
import 'package:news_app_ui/data/providers/base_controller/base_controller.dart';
import 'package:news_app_ui/screen/add_profile_health/views/add_profile_health_view.dart';
import 'package:news_app_ui/utils/auth_service.dart';

class AddProfileHealthController extends BaseController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cmtController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController tinhController = TextEditingController();
  TextEditingController huyenController = TextEditingController();
  TextEditingController xaController = TextEditingController();
  TextEditingController dcController = TextEditingController();

  TextEditingController guardianController = TextEditingController();
  TextEditingController phoneGuardiuanController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
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
  final List<String> listRelationship = [
    'Anh',
    'Bà',
    'Bác',
    'Bố',
    'Cháu',
    'Chị',
    'Chồng',
    'Chú',
    'Cô',
    'Con',
    'Dì',
    'Em',
    'Mẹ',
    'Ông',
    'Vợ'
  ];
  RxList<String> listRelationshipObx = RxList([]);


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
    if (!validateCMTBool()) {
      return;
    }

    if (formKey5.currentState == null || !(formKey5.currentState!.validate())) {
      return;
    }

    Get.back();
  }

  void deleteOldProfile({required int index}) async {}

  void saveOldProfile({required int index, required BuildContext context}) async {
    log('formKey5.currentState  ${formKey5.currentState}-- ${!(formKey5.currentState!.validate())} ');
    if (!validatePhoneNumber()) {
      return;
    }
    if (!validateCMTBool()) {
      return;
    }

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

  bool validateCMTBool() {
    if (cmtController.text.isEmpty) {
      cmtFocusNode.requestFocus();

      return false;
    }

    return true;
  }





  String? validateHuyen(String? value) {
    if (value == null) {
      return 'Please enter your Distric';
    }
    return null;
  }

  String? validateTinh(String? value) {
    if (value == null) {
      return 'Please enter your Province';
    }
    return null;
  }

  String? validateCMT(String? value) {
    if (value == null) {
      return 'Please enter your CMT/CCCD';
    }
    return null;
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

  void fillterRelationship({String? relationship}) {
    if (relationship == null) {
      listRelationshipObx.value = listRelationship;
    } else {
      listRelationshipObx.value =
          listRelationship.where((item) => item.toLowerCase().contains(relationship.toLowerCase())).toList();
    }
  }



}
