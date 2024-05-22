import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:news_app_ui/config/theme/ui_constants.dart';
import 'package:news_app_ui/data/model/new_model.dart';

import 'package:news_app_ui/screen/details/details_page.dart';
import 'package:news_app_ui/screen/main_tab_bar/main_tab_controller.dart';
import 'package:news_app_ui/utils/base_page.dart';
import 'package:news_app_ui/utils/constants/app_colors.dart';
import 'package:news_app_ui/utils/empty_widget.dart';
import 'package:news_app_ui/utils/primary/primary_list_view.dart';
import 'package:news_app_ui/widgets/spacer/spacer_custom.dart';

import '../../gen/assets.gen.dart';
import 'widgets/card_view_widget.dart';
import 'widgets/home_header_widget.dart';
import 'widgets/round_icon_button_widget.dart';
import 'widgets/top_slider_widget.dart';

class HomePage extends BasePage<MainTabController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 45, 24, 0),
        child: Column(
          children: [
            const HomeHeaderWidget(),
            const CustomHeightSpacer(
              size: 0.04,
            ),
            const TopSliderWidget(),
            const CustomHeightSpacer(
              size: 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Discover Hotest\nNews',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                    color: Color(0xff1a434e),
                  ),
                ),
                RoundIconButtonWidget(
                  iconName: Assets.icons.icSetting5.path,
                  iconColor: AppColors.primaryColor,
                  iconWidth: 20,
                  iconHeight: 20,
                  borderColor: AppColors.borderColor,
                  onTap: () {},
                ),
              ],
            ),
            const CustomHeightSpacer(
              size: 0.02,
            ),
            // const HorizontalCategoryList(
            //   items: myCategory,
            // ),
            Expanded(
              child: Obx(() {
                final list = controller.items.value;
                if (controller.loading.value) {
                  return const LoadingWidget();
                }
                if (list.isEmpty) {
                  return const SizedBox(
                      height: 600,
                      child: EmptyWidget(
                        text: 'Chưa có tin tức nào',
                      ));
                }

                return SizedBox(
                  height: 600,
                  child: LoadMoreWidget<NewsModel>(
                      controller: controller,
                      scrollView: (items) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final data = items[index];
                            Uint8List bytes = base64Decode((data.thumbnail ?? "")
                                .replaceAll("data:image/jpeg;base64,", "")
                                .replaceAll("data:image/png;base64,", ""));
                            return CardViewWidget2(
                              image: bytes,
                              name: data.title ?? '',
                              author: '',
                              onTap: () {
                                controller.newModel.value = data;
                                Get.to(const DetailsPage());
                              },
                            );
                          },
                          separatorBuilder: (context, index) => UIConst.height8,
                          itemCount: items.length,
                        );
                      }),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Container();
  }

  @override
  bool get showback => false;

  @override
  String? get titlePage => '';
}
