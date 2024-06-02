import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:news_app_ui/screen/main_tab_bar/controller/main_tab_controller.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../widgets/spacer/spacer_custom.dart';
import '../../../../home/widgets/round_icon_button_widget.dart';

class DetailsHeaderWidget extends GetView<MainTabController> {
  const DetailsHeaderWidget({super.key, this.onTap});
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final newModel = controller.newModel.value;
    Uint8List bytes = base64Decode(
        (newModel.thumbnail ?? "").replaceAll("data:image/jpeg;base64,", "").replaceAll("data:image/png;base64,", ""));
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffbdbdbd),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: MemoryImage(bytes),
        ),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 45, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RoundIconButtonWidget(
                  iconName: Assets.icons.icBack.path,
                  iconColor: AppColors.backGroundColor,
                  iconWidth: 20,
                  iconHeight: 20,
                  borderColor: AppColors.borderColor,
                  onTap: onTap,
                ),
                const Spacer(),
              ],
            ),
            const CustomHeightSpacer(
              size: 0.2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            controller.newModel.value.title ?? '',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              height: 1.3,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                        const Text(
                          'By Admin',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ],
                    ),
                  ),
                  RoundIconButtonWidget(
                    iconName: Assets.icons.icArchiveAdd.path,
                    iconColor: AppColors.backGroundColor,
                    iconWidth: 20,
                    iconHeight: 20,
                    borderColor: AppColors.borderColor,
                    onTap: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
