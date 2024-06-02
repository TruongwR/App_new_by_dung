import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:news_app_ui/screen/main_tab_bar/page/details/widgets/details_header_widget.dart';
import 'package:news_app_ui/screen/main_tab_bar/controller/main_tab_controller.dart';
import 'package:news_app_ui/utils/constants/app_colors.dart';

class DetailsPage extends GetView<MainTabController> {
  const DetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Obx(() {
        final newModel = controller.newModel.value;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailsHeaderWidget(onTap: () {
                Get.back();
              }),
              Html(
                data: '''${newModel.contentHtml}''',
              )
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
              //   child: Text(
              //     'An exhibition exploring 350 years of relations between the Japanese and British royal families has opened at the Queen’s Gallery near Buckingham Palace, the London home of the British monarchy.',
              //     style: TextStyle(
              //       fontSize: 14,
              //       fontWeight: FontWeight.w400,
              //       height: 1.8,
              //       color: Color(0xff95a6aa),
              //     ),
              //   ),
              // ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 24.0),
              //   child: Text(
              //     'UK-Japan royal relationship',
              //     style: TextStyle(
              //       fontSize: 16,
              //       fontWeight: FontWeight.w700,
              //       height: 1.3,
              //       color: Color(0xff1a434e),
              //     ),
              //   ),
              // ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
              //   child: Text(
              //     'The exhibition features some 150 items from the royal family’s permanent collection, many of which were gifted to British royals by Japanese emperors and shoguns and are on public display for the first time.\n\nCurator Rachel Peat said the “stunning” works have “profoundly shaped British taste and helped forge a lasting relationship between the two nations.”',
              //     style: TextStyle(
              //       fontSize: 14,
              //       fontWeight: FontWeight.w400,
              //       height: 1.8,
              //       color: Color(0xff95a6aa),
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      }),
    );
  }
}
