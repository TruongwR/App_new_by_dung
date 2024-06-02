import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:news_app_ui/data/providers/auth_provider.dart';
import 'package:news_app_ui/data/providers/base_controller/base_controller.dart';
import 'package:news_app_ui/routes/app_pages.dart';

import 'package:news_app_ui/utils/empty_widget.dart';
import 'package:news_app_ui/utils/notify.dart';

class LoginController extends BaseController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confimPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final loading = false.obs;
  final RxBool isObscureDN = true.obs;
  final RxBool isObscureDK1 = true.obs;
  final RxBool isObscureDK2 = true.obs;
  final phoneFocusNode = FocusNode();
  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  PhoneNumber? phoneNumber;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<int> selectedGender = 1.obs;
  final RxBool showSignup = false.obs;
  final AuthProvider authProvider = AuthProvider();



  void login() async {
    // if (!validatePhoneNumber()) {
    //   return;
    // }
    // if (formKey2.currentState == null || !formKey2.currentState!.validate()) {
    //   return;
    // }

    final respon = await authProvider.login(phone: phoneController.text, password: passwordController.text);

    if (respon?.user?.id != null) {
      authService.saveAuthJson(respon?.accessToken ?? '');
      authService.setAuthModel(respon!);
      authService.saveRole(respon.user?.role.name ?? '');
      // Get.offAndToNamed(Routes.HOME);
      if (respon.user?.role.id == 3) {
        Get.offAndToNamed(Routes.HOME);
      }
    }
  }

  String removeLeadingZeros(String input) {
    RegExp regex = RegExp(r'^0+(?=\d*[1-9])');
    return input.replaceAll(regex, '');
  }

  bool validatePhoneNumber() {
    if (phoneNumber?.number == null || phoneNumber!.number.isEmpty) {
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
    if (value.length < 10 || value.length > 11) {
      return 'Vui lòng nhập từ 10 - 11  số';
    }
    return null;
  }

  String? validatorAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Địa chỉ là bắt buộc';
    }
    return null;
  }

  String? validatorPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mật khẩu là bắt buộc';
    }

    if (value.length < 6 || value.length > 20) {
      return 'Vui lòng nhập từ 6 - 20 ký tự và số';
    }

    return null;
  }

  void register({required BuildContext context}) async {
    // if (!validatePhoneNumber()) {
    //   return;
    // }
    // if (formKey.currentState == null || !formKey.currentState!.validate()) {
    //   return;
    // }
    // if (confimPasswordController.text != passwordController.text) {
    //   Notify.error("Vui lòng kiểm tra lại 2 mật khẩu");
    //   return;
    // }
    final date = DateFormat('dd/MM/yyyy').format(selectedDate.value);

    showDialog(
      context: Get.context!,
      builder: (context) {
        return const LoadingWidget();
      },
    );
    final respon = await authProvider.register(
        phone: phoneController.text,
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        address: addressController.text,
        date: date,
        sex: selectedGender.value);
    Navigator.pop(context);
    if (respon == true) {
      showSignup.value = false;
      Notify.success("Đăng ký thành công");
    }
  }
}
