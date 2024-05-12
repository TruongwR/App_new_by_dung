import 'package:flutter/material.dart';
import 'package:news_app_ui/config/theme/theme.dart';

class ColorsConst {
  ColorsConst._();

  static AppThemeColor themeColor(BuildContext context) {
    return Theme.of(context).extension<AppThemeColor>()!;
  }

  static const primary = Color(0xFF58BD7D);
  static const primary2 = Color(0xFF8881C9);
  static const primary3 = Color(0xFFFF6838);
  static const primary4 = Color(0xFF58BD7D);

  static const secondary = Color(0xFF4BC9F0);
  static const secondary2 = Color(0xFFFBFFFE);
  static const secondary3 = Color(0xFFFFD166);
  static const secondary4 = Color(0xFFCDB4DB);

  // light
  static const neutral1Light = Color(0xFF141416);
  static const neutral2Light = Color(0xFF23262F);
  static const neutral3Light = Color(0xFF353945);
  static const neutral4Light = Color(0xFF777E90);
  static const neutral5Light = Color(0xFFB1B5C3);
  static const neutral6Light = Color(0xFFE6E8EC);
  static const neutral7Light = Color(0xFFF4F5F6);
  static const neutral8Light = Color(0xFFFCFCFD);

  // --- shade light
  static const kShape750Light = Color(0xFFF8F8F9);
  static const kShape650Light = Color(0xFFF1F2F4);
  static const kShape550Light = Color(0xFFD6D8E0);

  // dark
  static const neutral1Dark = Color(0xFFFCFCFD);
  static const neutral2Dark = Color(0xFFFCFCFD);
  static const neutral3Dark = Color(0xFF353945);
  static const neutral4Dark = Color(0xFF777E90);
  static const neutral5Dark = Color(0xFFB1B5C3);
  static const neutral6Dark = Color(0xFF353945);
  static const neutral7Dark = Color(0xFF23262F);
  static const neutral8Dark = Color(0xFF141416);

  // --- shade dart
  static const kShape750Dark = Color(0xFF18191D);
  static const kShape650Dark = Color(0xFF17181B);
  static const kShape550Dark = Color(0xFF2A2D38);

  /// Custom
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color red = Color(0xffD42029);
  static const Color gray66 = Color(0xFF666666);
  static const Color gray97 = Color(0xFF979797);
  static const Color grayD9 = Color(0xFFD9D9D9);
  static const Color grayF0 = Color(0xFFF0F0F0);
}

extension TextStyleEx on TextStyle {
  TextStyle _copyWith(BuildContext context, Color Function(AppThemeColor) getColor) {
    final appColor = Theme.of(context).extension<AppThemeColor>()!;
    return copyWith(color: getColor(appColor));
  }

  TextStyle primary1(BuildContext context) {
    return _copyWith(context, (themeColor) => themeColor.primary);
  }

  TextStyle primary2(BuildContext context) {
    return _copyWith(context, (themeColor) => themeColor.primary2);
  }

  TextStyle primary3(BuildContext context) {
    return _copyWith(context, (themeColor) => themeColor.primary3);
  }

  TextStyle primary4(BuildContext context) {
    return _copyWith(context, (themeColor) => themeColor.primary4);
  }

  TextStyle secondary(BuildContext context) {
    return _copyWith(context, (themeColor) => themeColor.secondary);
  }

  TextStyle secondary2(BuildContext context) {
    return _copyWith(context, (themeColor) => themeColor.secondary2);
  }

  TextStyle secondary3(BuildContext context) {
    return _copyWith(context, (themeColor) => themeColor.secondary3);
  }

  TextStyle secondary4(BuildContext context) {
    return _copyWith(context, (themeColor) => themeColor.secondary4);
  }

  TextStyle neutral1(BuildContext context) {
    return _copyWith(context, (themeColor) => themeColor.neutral1);
  }

  TextStyle neutral2(BuildContext context) {
    return _copyWith(context, (themeColor) => themeColor.neutral2);
  }

  TextStyle neutral3(BuildContext context) {
    return _copyWith(context, (themeColor) => themeColor.neutral3);
  }

  TextStyle neutral4(BuildContext context) {
    return _copyWith(context, (themeColor) => themeColor.neutral4);
  }

  TextStyle neutral5(BuildContext context) {
    return _copyWith(context, (themeColor) => themeColor.neutral5);
  }

  TextStyle neutral6(BuildContext context) {
    return _copyWith(context, (themeColor) => themeColor.neutral6);
  }

  TextStyle neutral7(BuildContext context) {
    return _copyWith(context, (themeColor) => themeColor.neutral7);
  }

  TextStyle neutral8(BuildContext context) {
    return _copyWith(context, (themeColor) => themeColor.neutral8);
  }

  TextStyle kShape750(BuildContext context) {
    return _copyWith(context, (themeColor) => themeColor.kShape750);
  }

  TextStyle kShape650(BuildContext context) {
    return _copyWith(context, (themeColor) => themeColor.kShape650);
  }

  TextStyle kShape550(BuildContext context) {
    return _copyWith(context, (themeColor) => themeColor.kShape550);
  }
}

class Styles {
  Styles._();

  /// Font 10
  static TextStyle get caption3Nomal {
    return const TextStyle(fontSize: 10, fontWeight: FontWeight.w400, height: 16 / 10);
  }

  static TextStyle get caption3 {
    return const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, height: 16 / 10);
  }

  /// Font 12
  static TextStyle get caption2 {
    return const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 20 / 12);
  }

  static TextStyle get caption2Medium {
    return const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, height: 20 / 12);
  }

  static TextStyle get caption2Bold {
    return const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, height: 20 / 12);
  }

  static TextStyle get hairline2 {
    return const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, height: 16 / 12);
  }

  /// Font 14
  static TextStyle get caption {
    return const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 24 / 14);
  }

  static TextStyle get captionBold {
    return const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 24 / 14);
  }

  static TextStyle get button2 {
    return const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, height: 16 / 14);
  }

  /// Font 16
  static TextStyle get body2 {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 24 / 16,
    );
  }

  static TextStyle get body2Bold {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 24 / 16,
    );
  }

  static TextStyle get hairline1 {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      height: 20 / 16,
    );
  }

  static TextStyle get button1 {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      height: 16 / 16,
    );
  }

  /// Font 24
  static TextStyle get body1 {
    return const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      height: 32 / 24,
    );
  }

  static TextStyle get body1Bold {
    return const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 32 / 24,
    );
  }

  /// Font 32
  static TextStyle get headline4 {
    return const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      height: 40 / 32,
    );
  }

  /// Font 40
  static TextStyle get headline3 {
    return const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      height: 48 / 40,
    );
  }

  /// Font 48
  static TextStyle get headline2 {
    return const TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w700,
      height: 56 / 48,
    );
  }

  /// Font 64
  static TextStyle get headline1 {
    return const TextStyle(
      fontSize: 64,
      fontWeight: FontWeight.w700,
      height: 64 / 64,
    );
  }

  /// Font 96
  static TextStyle get hero {
    return const TextStyle(
      fontSize: 96,
      fontWeight: FontWeight.w700,
      height: 96 / 96,
    );
  }
}
