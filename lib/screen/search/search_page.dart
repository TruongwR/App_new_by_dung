import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_ui/config/theme/ui_constants.dart';
import 'package:news_app_ui/data/model/new_model.dart';
import 'package:news_app_ui/screen/main_tab_bar/main_tab_controller.dart';
import 'package:news_app_ui/utils/constants/app_colors.dart';
import 'package:news_app_ui/utils/empty_widget.dart';
import 'package:news_app_ui/utils/primary/primary_list_view.dart';
import 'package:news_app_ui/widgets/spacer/spacer_custom.dart';

import '../../dummy_data/dummy_data.dart';
import '../../utils/base_page.dart';
import '../details/details_page.dart';
import '../home/widgets/card_view_widget.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/search_header_widget.dart';
import 'widgets/trending_topic_widget.dart';

class SearchPage extends  BasePage<MainTabController>{
  @override
  Widget body(BuildContext context) {
  return  Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 45, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchHeaderWidget(),
              const CustomHeightSpacer(
                size: 0.04,
              ),
              const SearchBarWidget(),
              const CustomHeightSpacer(
                size: 0.04,
              ), 
              const Text(
                'Trending topic today',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                  color: Color(0xff1a434e),
                ),
              ),
                Obx(() {
                  final list = controller.items.value;
                  if (controller.loading.value) {
                    return const LoadingWidget();
                  }
                  if (list.isEmpty) {
                    return const SizedBox(
                        height: 600,
                        child: EmptyWidget(
                          text: 'Không tìm thấy tin tức nào',
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
                })

            ],
          ),
        ),
      ),
    );
  }

  @override
  
  bool get showback => false;

  @override

  String? get titlePage => '';
}
