import 'package:flutter/material.dart';
import 'package:news_app_ui/utils/app_style.dart';

class PrimaryButton extends ElevatedButton {
  PrimaryButton({super.key, required String title, required super.onPressed, Color? backgroundColor, TextStyle? style})
      : super(
          child: Text(
            title,
            style: style ??
                Styles.button1.copyWith(
                  color: ColorsConst.white,
                ),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.only(top: 2),
            shadowColor: Colors.transparent,
            elevation: 0,
            backgroundColor: backgroundColor ?? ColorsConst.primary,
            minimumSize: const Size.fromHeight(48),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
          ),
        );
}

class PrimaryOutlineButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const PrimaryOutlineButton({
    required this.title,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        side: BorderSide(
          width: 2,
          color: ColorsConst.themeColor(context).neutral6,
        ),
        padding: const EdgeInsets.only(top: 2),
        shadowColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
      ),
      child: Text(
        title,
        style: Styles.button2.neutral2(context),
      ),
    );
  }
}
