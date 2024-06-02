import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_ui/screen/main_tab_bar/main_tab_controller.dart';

import '../../../gen/assets.gen.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../widgets/spacer/spacer_custom.dart';

class SearchBarWidget extends GetView<MainTabController> {
  const SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xfffafafa),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Assets.icons.icUnselectedSearchNormal.path,
              width: 24,
              height: 24,
              color: AppColors.primaryColor,
            ),
            const CustomWidthSpacer(
              size: 0.03,
            ),
            Expanded(
              child: TextFormField(
                controller: controller.search,
                onChanged: (value){
                  if(value!=null){
                    controller.onRefresh();
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Search article, topic, writer',
                  hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.8,
                  color: Color(0xff95a6aa),
                ),
                  
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}