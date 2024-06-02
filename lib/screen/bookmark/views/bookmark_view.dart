import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:news_app_ui/config/theme/ui_constants.dart';
import 'package:news_app_ui/data/model/new_model.dart';
import 'package:news_app_ui/screen/home/widgets/card_view_widget.dart';
import 'package:news_app_ui/screen/main_tab_bar/page/details/details_page.dart';
import 'package:news_app_ui/utils/empty_widget.dart';
import 'package:news_app_ui/utils/primary/primary_list_view.dart';

import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookMark'),
        elevation: 5,
        centerTitle: true,
      ),
      body: Column(
        children: [
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
    );
  }
}
