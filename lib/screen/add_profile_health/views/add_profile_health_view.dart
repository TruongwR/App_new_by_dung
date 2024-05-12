import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:news_app_ui/config/theme/ui_constants.dart';
import 'package:news_app_ui/utils/app_style.dart';
import 'package:news_app_ui/utils/base_page.dart';
import 'package:news_app_ui/utils/bottom_sheet.dart';
import 'package:news_app_ui/utils/date_form_flied.dart';
import 'package:news_app_ui/utils/primary/primary_button.dart';

import '../controllers/add_profile_health_controller.dart';

final GlobalKey<FormState> formKey5 = GlobalKey<FormState>();

class AddProfileHealthView extends BasePage<AddProfileHealthController> {
  const AddProfileHealthView({super.key});

  @override
  Widget body(BuildContext context) {
    final listGender = controller.listGender;
    final paddingRight = Get.width / 2 - 60;
    return Form(
      key: formKey5,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: CachedNetworkImageProvider(
                    'https://scontent.fhan2-5.fna.fbcdn.net/v/t39.30808-6/422891064_425323043160991_3164370156338084928_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=5f2048&_nc_ohc=b84WcYuR1S8Ab4fe_WU&_nc_ht=scontent.fhan2-5.fna&oh=00_AfDJ0cQ1mlL4lPP8VvvvZ5VbUKtQ4sgNiq_8rdsUMvWWuA&oe=6629D3C9'),
              ),
              Positioned(
                bottom: 0,
                right: paddingRight,
                child: const CircleAvatar(
                  radius: 12,
                  child: Icon(
                    Icons.photo_camera_outlined,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              )
            ],
          ),
          TextFormField(
            controller: controller.nameController,
            style: Styles.captionBold.neutral2(context),
            decoration: InputDecoration(
              labelText: 'Họ và tên',
              labelStyle: Styles.caption2.neutral3(context),
            ),
            validator: (value) => controller.validatorUsername(value),
          ),
          UIConst.height16,
          Row(
            children: [
              Expanded(
                child: Obx(() => DateTimePickerFormField(
                      format: DateFormat("yyyy-MM-dd"),
                      initialDate: controller.selectedDate.value,
                      editable: false,
                      decoration: InputDecoration(
                        labelText: 'Ngày sinh',
                        hintText: 'Chọn ngày sinh',
                        labelStyle: Styles.caption2.neutral3(context),
                        icon: const Icon(Icons.calendar_today),
                      ),
                      onChanged: (value) {
                        controller.selectedDate.value = value;
                      },
                    )),
              ),
              UIConst.width16,
              Expanded(
                child: TextFormField(
                  controller: controller.genderController,
                  style: Styles.captionBold.neutral2(context),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Giới tính',
                    labelStyle: Styles.caption2.neutral3(context),
                  ),
                  readOnly: true,
                  onTap: () {
                    openBottomSheet(
                      context: context,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          ...ListTile.divideTiles(
                              color: ColorsConst.themeColor(context).neutral4,
                              tiles: List.generate(
                                  listGender.length,
                                  (index) => ListTile(
                                        onTap: () {
                                          controller.selectedGender.value = listGender[index];
                                          controller.genderController.text = listGender[index];
                                          Get.back();
                                        },
                                        title: Center(
                                          child: Text(
                                            listGender[index],
                                            style: listGender[index] == controller.selectedGender.value
                                                ? Styles.captionBold.primary3(context)
                                                : Styles.captionBold.neutral2(context),
                                          ),
                                        ),
                                      ))),
                          const Divider(
                            thickness: 8,
                            height: 0,
                          ),
                          ListTile(
                            title: Center(
                              child: Text(
                                'Cancel',
                                style: Styles.captionBold.neutral2(context),
                              ),
                            ),
                            onTap: () {
                              Get.back();
                            },
                          )
                        ],
                      ),
                    );
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter Genger';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          UIConst.height16,
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.phoneController,
                  focusNode: controller.phoneFocusNode,
                  style: Styles.captionBold.neutral2(context),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Số điện thoại',
                    labelStyle: Styles.caption2.neutral3(context),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
              ),
              UIConst.width16,
              Expanded(
                child: TextFormField(
                  focusNode: controller.cmtFocusNode,
                  controller: controller.cmtController,
                  style: Styles.captionBold.neutral2(context),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'CMT/CCCD',
                    labelStyle: Styles.caption2.neutral3(context),
                  ),
                  validator: (value) => controller.validateCMT(value),
                ),
              ),
            ],
          ),
          UIConst.height16,
          TextFormField(
            controller: controller.dcController,
            style: Styles.captionBold.neutral2(context),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Địa chỉ',
              labelStyle: Styles.caption2.neutral3(context),
            ),
            validator: (value) {
              if (value == null) {
                return 'Vui lòng nhập địa chỉ';
              }
              return null;
            },
          ),
          UIConst.height16,
          TextFormField(
            controller: controller.guardianController,
            style: Styles.captionBold.neutral2(context),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Người giám hộ',
              labelStyle: Styles.caption2.neutral3(context),
            ),
            validator: (value) {
              if (value == null) {
                return 'Vui lòng nhập người giám hộ';
              }
              return null;
            },
          ),
          UIConst.height16,
          TextFormField(
            controller: controller.phoneGuardiuanController,
            style: Styles.captionBold.neutral2(context),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'SĐT Người giám hộ',
              labelStyle: Styles.caption2.neutral3(context),
            ),
            validator: (value) {
              if (value == null) {
                return 'Please enter your CMT/CCCD';
              }
              return null;
            },
          ),
          UIConst.height16,
          Text(
            'Vui lòng nhập thông tin người giám hộ đối với trẻ dưới 6 tuổi',
            style: Styles.caption2.primary3(context),
          ),
          UIConst.height24,
          PrimaryButton(
            title: 'Lưu',
            onPressed: () {
              controller.saveProfile(context: context);
            },
          )
        ],
      ),
    );
  }

  @override
  String? get titlePage => 'Hồ sơ';

  @override
  bool get showback => false;
  @override
  List<Widget>? actions(BuildContext context) {
    return [];
  }
}
