import 'package:flutter/material.dart';
import 'package:news_app_ui/config/theme/ui_constants.dart';
import 'package:news_app_ui/utils/app_style.dart';


class IconPrimaryButton extends StatelessWidget {
  const IconPrimaryButton({super.key, this.onPress, required this.title, this.icon});
  final Function()? onPress;
  final String title;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsConst.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          icon ??
              Icon(
                Icons.calendar_month_outlined,
                color: ColorsConst.themeColor(context).neutral8,
                size: 18,
              ),
          UIConst.width8,
          Text(
            title,
            style: Styles.caption2Medium.neutral8(context),
          ), // Văn bản
        ],
      ),
    );
  }
}
