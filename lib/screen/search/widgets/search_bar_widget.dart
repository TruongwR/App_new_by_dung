import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../widgets/spacer/spacer_custom.dart';

class SearchBarWidget extends StatelessWidget {
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
            const Text(
              'Search article, topic, writer',
              style: TextStyle(

                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.8,
                color: Color(0xff95a6aa),
              ),
            ),
          ],
        ),
      ),
    );
  }
}