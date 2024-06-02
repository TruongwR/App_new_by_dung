import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../utils/constants/app_colors.dart';
import 'round_icon_button_widget.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning',
              style: TextStyle(

                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.4,
                color: Color(0xff94a5aa),
              ),
            ),
            // Text(
            //   'Jordan Klik',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(

            //     fontSize: 24,
            //     fontWeight: FontWeight.w700,
            //     height: 1.3,
            //     color: Color(0xff1a434e),
            //   ),
            // )
          ],
        ),
        RoundIconButtonWidget(
          iconName: Assets.icons.icNotification.path,
          iconColor: AppColors.primaryColor,
          iconWidth: 20,
          iconHeight: 20,
          borderColor: AppColors.borderColor,
          onTap: () {

            // Get.to(
            //   SamplePage(
            //     title: 'Notification Page',
            //   ),);

          },
        ),
      ],
    );
  }
}
