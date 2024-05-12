import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_ui/utils/app_style.dart';


class KButton extends StatelessWidget {
  const KButton(
      {Key? key,
      required this.title,
      this.width = double.infinity,
      this.height = 48,
      this.onPressed,
      this.color,
      this.titleColor,
      this.borderRaidus,
      this.icon,
      this.borderSide,
      this.elevation,
      this.fontsize})
      : super(key: key);
  final double width;
  final double height;
  final String title;
  final Color? color;
  final Color? titleColor;
  final double? fontsize;
  final double? borderRaidus;
  final Widget? icon;
  final BorderSide? borderSide;
  final double? elevation;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
        backgroundColor: color ?? Get.theme.primaryColor,
        elevation: elevation ?? 0,
        shape: RoundedRectangleBorder(
            side: borderSide ?? BorderSide.none, borderRadius: BorderRadius.circular(borderRaidus ?? (height / 2))));
    final text = Text(
      title,
      style: TextStyle(fontSize: fontsize, color: titleColor ?? Colors.white),
    );

    return SizedBox(
      width: width,
      height: height,
      child: icon != null
          ? ElevatedButton.icon(
              onPressed: onPressed,
              icon: icon!,
              label: text,
              style: style,
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: style,
              child: text,
            ),
    );
  }
}

class KButtonStaking extends StatelessWidget {
  const KButtonStaking({
    Key? key,
    required this.title,
    this.width = double.infinity,
    this.height = 48,
    this.onPressed,
    this.color,
    this.borderRaidus,
    this.textStyle,
    this.borderSide,
    this.elevation,
  }) : super(key: key);
  final double width;
  final double height;
  final String title;
  final Color? color;

  final TextStyle? textStyle;
  final double? borderRaidus;

  final BorderSide? borderSide;
  final double? elevation;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final style = ElevatedButton.styleFrom(
        backgroundColor: color ?? Get.theme.primaryColor,
        elevation: elevation ?? 0,
        shape: RoundedRectangleBorder(
            side: borderSide ?? BorderSide.none, borderRadius: BorderRadius.circular(borderRaidus ?? (height / 2))));
    final text = Text(
      title,
      style: textStyle ?? Styles.captionBold.neutral4(context),
    );

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: text,
      ),
    );
  }
}

class KBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  const KBackButton({Key? key, this.onTap, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon:const Icon(Icons.keyboard_backspace_rounded, color: ColorsConst.white),
      onPressed: onTap ?? Get.back,
    );
  }
}

class KBackButtonLigh extends StatelessWidget {
  const KBackButtonLigh({
    required this.lable,
    this.width,
    this.height,
    this.color,
    this.textStyle,
    this.colorButon,
    this.onTap,
    Key? key,
  }) : super(key: key);
  final String lable;
  final double? width;
  final double? height;
  final Color? color;
  final Color? colorButon;
  final TextStyle? textStyle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        constraints: const BoxConstraints(minHeight: 40, minWidth: 100),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            color: colorButon,
            borderRadius: BorderRadius.circular(45),
            border: Border.all(color: color ?? ColorsConst.themeColor(context).neutral6, width: 2)),
        child: Text(lable, style: textStyle ?? Styles.button2.neutral2(context)),
      ),
    );
  }
}
