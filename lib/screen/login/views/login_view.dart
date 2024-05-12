import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:news_app_ui/config/theme/ui_constants.dart';
import 'package:news_app_ui/utils/app_style.dart';
import 'package:news_app_ui/utils/date_form_flied.dart';

import 'package:news_app_ui/utils/primary/primary_button.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final height = (Get.height) / 4;
    return Scaffold(
      backgroundColor: ColorsConst.themeColor(context).kShape750,
      body: Stack(
        children: [
          Container(
            color: Colors.orange.withOpacity(0.3),
          ),
          Obx(() => SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    UIConst.height(controller.showSignup.value == false ? height : height / 2),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: AnimatedSwitcher(
                        duration: const Duration(seconds: 1),
                        child: controller.showSignup.value == false
                            ? Form(
                                key: controller.formKey2,
                                child: ListView(
                                  padding: const EdgeInsets.all(16),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    UIConst.height16,
                                    Row(
                                      children: [
                                        Text(
                                          "Đăng Nhập",
                                          style: Styles.body1Bold.neutral2(context),
                                        ),
                                        const Spacer(),
                                        TextButton(
                                            onPressed: () => controller.showSignup.value = true,
                                            child: Text(
                                              'Đăng ký',
                                              style: Styles.button1.primary1(context),
                                            ))
                                      ],
                                    ),
                                    UIConst.height16,
                                    TextFormField(
                                      controller: controller.phoneController,
                                      style: Styles.captionBold.neutral2(context),
                                      decoration: InputDecoration(
                                        labelText: 'Số điện thoại',
                                        labelStyle: Styles.caption3.neutral4(context),
                                      ),
                                      validator: (value) => controller.validatorPhone(value),
                                    ),
                                    UIConst.height16,
                                    TextFormField(
                                      controller: controller.passwordController,
                                      style: Styles.captionBold.neutral2(context),
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        labelText: 'Mật khẩu',
                                        labelStyle: Styles.caption3.neutral4(context),
                                      ),
                                      validator: (value) => controller.validatorPassword(value),
                                    ),
                                    UIConst.height16,
                                    TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Quên mật khẩu',
                                          style: Styles.button2.neutral4(context),
                                        )),
                                    UIConst.height16,
                                    PrimaryButton(
                                      title: "Đăng Nhập",
                                      onPressed: () {
                                        controller.login();
                                      },
                                    ),
                                    UIConst.height16,
                                  ],
                                ),
                              )
                            : Form(
                                key: controller.formKey,
                                child: ListView(
                                  padding: const EdgeInsets.all(16),
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Text(
                                          "Đăng ký",
                                          style: Styles.body1Bold.neutral2(context),
                                        ),
                                        const Spacer(),
                                        TextButton(
                                            onPressed: () {
                                              controller.showSignup.value = false;
                                              controller.selectedGender.value = 1;
                                            },
                                            child: Text(
                                              'Đăng Nhập',
                                              style: Styles.button1.primary1(context),
                                            ))
                                      ],
                                    ),
                                    // UIConst.height8,
                                    // IntlPhoneField(
                                    //   controller: controller.phoneController,
                                    //   focusNode: controller.phoneFocusNode,
                                    //   initialCountryCode: Get.deviceLocale?.countryCode,
                                    //   decoration: const InputDecoration(
                                    //     hintText: 'Nhập Số điện thoại của bạn',
                                    //     isDense: true,
                                    //     contentPadding: EdgeInsets.only(top: 14),
                                    //   ),
                                    //   onSaved: (phone) {
                                    //     controller.phoneNumber = phone;
                                    //   },
                                    //   onCountryChanged: (value) {
                                    //     controller.phoneNumber?.countryCode = value.dialCode;
                                    //   },
                                    //   onChanged: (phone) {
                                    //     controller.phoneNumber = phone;
                                    //   },
                                    //   disableLengthCheck: true,
                                    //   validator: (p0) => controller.validatorPhone(controller.phoneController.text),
                                    // ),
                                    UIConst.height8,
                                    TextFormField(
                                      controller: controller.phoneController,
                                      style: Styles.captionBold.neutral2(context),
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        labelText: 'Phone Number',
                                        labelStyle: Styles.caption3.neutral4(context),
                                      ),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please enter your phone number';
                                        }
                                        return null;
                                      },
                                    ),

                                    UIConst.height8,
                                    TextFormField(
                                      controller: controller.nameController,
                                      style: Styles.captionBold.neutral2(context),
                                      decoration: InputDecoration(
                                        labelText: 'Họ Và Tên',
                                        labelStyle: Styles.caption3.neutral4(context),
                                      ),
                                      validator: (value) => controller.validatorUsername(value),
                                    ),
                                    UIConst.height8,
                                    TextFormField(
                                      controller: controller.emailController,
                                      style: Styles.captionBold.neutral2(context),
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        labelStyle: Styles.caption3.neutral4(context),
                                      ),
                                    ),
                                    UIConst.height8,
                                    Obx(() => TextFormField(
                                          controller: controller.passwordController,
                                          style: Styles.captionBold.neutral2(context),
                                          obscureText: controller.isObscureDK1.value,
                                          decoration: InputDecoration(
                                              labelText: 'Mật khẩu',
                                              labelStyle: Styles.caption3.neutral4(context),
                                              suffixIcon: IconButton(
                                                  onPressed: () =>
                                                      controller.isObscureDK1.value = !controller.isObscureDK1.value,
                                                  icon: Icon(
                                                    controller.isObscureDK1.value
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                  ))),
                                          validator: (value) => controller.validatorPassword(value),
                                        )),
                                    UIConst.height8,
                                    Obx(() => TextFormField(
                                          controller: controller.confimPasswordController,
                                          style: Styles.captionBold.neutral2(context),
                                          obscureText: controller.isObscureDK2.value,
                                          decoration: InputDecoration(
                                              labelText: 'Nhập lại mật khẩu',
                                              labelStyle: Styles.caption3.neutral4(context),
                                              suffixIcon: IconButton(
                                                  onPressed: () =>
                                                      controller.isObscureDK2.value = !controller.isObscureDK2.value,
                                                  icon: Icon(
                                                    controller.isObscureDK2.value
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                  ))),
                                          validator: (value) => controller.validatorPassword(value),
                                        )),
                                    UIConst.height8,
                                    TextFormField(
                                      controller: controller.addressController,
                                      style: Styles.captionBold.neutral2(context),
                                      decoration: InputDecoration(
                                        labelText: 'Địa Chỉ',
                                        labelStyle: Styles.caption3.neutral4(context),
                                      ),
                                      validator: (value) => controller.validatorAddress(value),
                                    ),
                                    UIConst.height8,
                                    const SizedBox(height: 16),
                                    Obx(() => DateTimePickerFormField(
                                          format: DateFormat("yyyy-MM-dd"),
                                          initialDate: controller.selectedDate.value,
                                          editable: false,
                                          decoration: InputDecoration(
                                            labelText: 'Ngày Sinh',
                                            hintText: 'Select Date of Birth',
                                            labelStyle: Styles.caption3.neutral4(context),
                                            icon: const Icon(Icons.calendar_today),
                                          ),
                                          onChanged: (value) {
                                            controller.selectedDate.value = value;
                                          },
                                        )),
                                    UIConst.height8,
                                    Row(
                                      children: [
                                        itemChose(
                                          context: context,
                                          valueSelect: 1,
                                          icon: Icon(Icons.male,
                                              size: 24, color: ColorsConst.themeColor(context).neutral2),
                                        ),
                                        itemChose(
                                          context: context,
                                          valueSelect: 2,
                                          icon: Icon(Icons.female,
                                              size: 24, color: ColorsConst.themeColor(context).neutral2),
                                        ),
                                        // IconPrimaryButton(
                                        //   title: 'Quét CCCD',
                                        //   onPress: () {
                                        //     Get.toNamed(Routes.QR_COPY);
                                        //   },
                                        //   icon: const Icon(Icons.camera_alt),
                                        // )

                                        // itemChose(
                                        //   context: context,
                                        //   valueSelect: 2,
                                        //   icon: SVGLoader.image('ic_gender',
                                        //       size: 24, color: ColorsConst.themeColor(context).neutral2),
                                        // ),
                                      ],
                                    ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   crossAxisAlignment: CrossAxisAlignment.center,
                                    //   children: [
                                    //     Obx(() => Visibility(
                                    //         visible: controller.selectedGender.value == 1,
                                    //         child: Text(
                                    //           'Vui lòng chọn giới tính',
                                    //           style: Styles.caption2.primary3(context),
                                    //         ))),
                                    //   ],
                                    // ),

                                    UIConst.height8,
                                    PrimaryButton(
                                      title: 'Đăng ký',
                                      onPressed: () {
                                        controller.register(context: context);
                                      },
                                    )
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget itemChose({required BuildContext context, required int valueSelect, required Widget icon}) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() => Transform.scale(
                scale: 0.8,
                child: Checkbox(
                  value: controller.selectedGender.value == valueSelect,
                  onChanged: (value) {
                    if (controller.selectedGender.value != valueSelect) {
                      controller.selectedGender.value = valueSelect;
                    }
                  },
                  checkColor: Colors.white,
                  activeColor: ColorsConst.themeColor(context).primary,
                ),
              )),
          icon
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.8)
      ..quadraticBezierTo(size.width / 3, size.height * 0.6, size.width / 2, size.height * 0.4) // Uốn từ 80% xuống 54%
      ..quadraticBezierTo(2 * size.width / 3, size.height * 0.2, size.width, size.height * 0.2) // Uốn từ 54% xuống 20%
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
