import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_ui/utils/constants/app_colors.dart';
import 'package:news_app_ui/widgets/spacer/spacer_custom.dart';

import '../../dummy_data/dummy_data.dart';
import '../details/details_page.dart';
import '../home/widgets/card_view_widget.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/search_header_widget.dart';
import 'widgets/trending_topic_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const CustomHeightSpacer(
                size: 0.03,
              ),
              const TrendingTopicWidget(
                name: 'Politics',
              ),
              const CustomHeightSpacer(
                size: 0.02,
              ),
              const TrendingTopicWidget(
                name: 'Politics',
              ),
              const CustomHeightSpacer(
                size: 0.02,
              ),
              const TrendingTopicWidget(
                name: 'Investment',
              ),
              const CustomHeightSpacer(
                size: 0.02,
              ),
              const TrendingTopicWidget(
                name: 'Business',
              ),
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: myDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return CardViewWidget(
                    image: myDataList[index].image,
                    name: myDataList[index].name,
                    author: myDataList[index].author,
                    onTap: () {
                      Get.to(DetailsPage());
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
