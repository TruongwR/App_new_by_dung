import 'package:flutter/material.dart';

import 'package:news_app_ui/config/theme/color_palette.dart';
import 'package:news_app_ui/config/theme/components.dart';
import 'package:news_app_ui/config/theme/text_style.dart';
import 'package:news_app_ui/utils/app_style.dart';

ThemeData lightTheme = ThemeData(
  extensions: <ThemeExtension<dynamic>>[
    AppThemeColor.light(),
  ],
  useMaterial3: false,
  brightness: Brightness.light,
  dividerColor: kNeutral6,
  scaffoldBackgroundColor: kNeutral8,
  primaryColor: kPrimaryColor,
  dividerTheme: const DividerThemeData(color: kNeutral6),
  appBarTheme: const AppBarTheme(backgroundColor: kNeutral8, elevation: 0.0, titleTextStyle: kBody2Bold),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: Styles.captionBold.copyWith(color: ColorsConst.neutral4Light),
    labelStyle: Styles.captionBold.copyWith(color: ColorsConst.neutral4Light),
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 2, color: ColorsConst.neutral5Light),
      borderRadius: BorderRadius.circular(12.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 2, color: ColorsConst.neutral6Light),
      borderRadius: BorderRadius.circular(12.0),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: ColorsConst.neutral5Light,
  ),
  textTheme: const TextTheme(
    displayLarge: kH1,
    displayMedium: kH2,
    displaySmall: kH3,
    headlineMedium: kH4,
    titleLarge: kH6,
    bodyMedium: kBody2,
    bodySmall: kCaption2,
    labelLarge: kButton1,
    bodyLarge: kBody1,
    labelSmall: kCaption,
  ),
  buttonTheme: const ButtonThemeData(buttonColor: kPrimaryColor),
  elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle),
  outlinedButtonTheme: OutlinedButtonThemeData(style: outlinedButtonStyle),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
    onSecondary: kNeutral2,
    background: kNeutral8,
    surface: kNeutral7,
    tertiary: kNeutral5,
    error: Colors.red,
    outline: kNeutral6,
    onBackground: kNeutral4,
    onError: Colors.white,
    onPrimary: kNeutral8,
    onSurface: kNeutral3,
    secondaryContainer: kShape750,
  ),
);

ThemeData darkTheme = ThemeData(
  extensions: <ThemeExtension<dynamic>>[
    AppThemeColor.dark(),
  ],
  useMaterial3: false,
  dividerColor: kNeutral6Dark,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: kNeutral8Dark,
  primaryColor: kPrimaryColor,
  dividerTheme: const DividerThemeData(color: kNeutral6),
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
    onSecondary: Color(0xffe5e6eb),
    background: kNeutral8Dark,
    surface: kNeutral7Dark,
    tertiary: kNeutral5Dark,
    error: kPrimaryColor2,
    outline: kNeutral6Dark,
    onBackground: kNeutral4Dark,
    onError: Color(0xffe5e6eb),
    onPrimary: kNeutral8Dark,
    onSurface: kNeutral3Dark,
    secondaryContainer: kShape750Dark,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: kNeutral8Dark,
    elevation: 0.0,
    titleTextStyle: kBody2Bold,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: Styles.captionBold.copyWith(color: ColorsConst.neutral4Dark),
    labelStyle: Styles.captionBold.copyWith(color: ColorsConst.neutral4Dark),
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 2, color: ColorsConst.neutral4Dark),
      borderRadius: BorderRadius.circular(12.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 2, color: ColorsConst.neutral6Dark),
      borderRadius: BorderRadius.circular(12.0),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: ColorsConst.neutral5Dark,
  ),
  textTheme: TextTheme(
    displayLarge: kH1.copyWith(color: kNeutral2Dark),
    displayMedium: kH2.copyWith(color: kNeutral2Dark),
    displaySmall: kH3.copyWith(color: kNeutral2Dark),
    headlineMedium: kH4.copyWith(color: kNeutral2Dark),
    titleLarge: kH6.copyWith(color: kNeutral2Dark),
    bodyMedium: kBody2.copyWith(color: kNeutral2Dark),
    bodySmall: kCaption2.copyWith(color: kNeutral4Dark),
    labelLarge: kButton1.copyWith(color: kNeutral2Dark),
    bodyLarge: kBody1.copyWith(color: kNeutral2Dark),
    labelSmall: kCaption.copyWith(
      color: kNeutral4Dark,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: kPrimaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
      side: BorderSide(color: kPrimaryColor),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle),
  outlinedButtonTheme: OutlinedButtonThemeData(style: outlinedButtonStyle),
);

@immutable
class AppThemeColor extends ThemeExtension<AppThemeColor> {
  final Color primary;
  final Color primary2;
  final Color primary3;
  final Color primary4;
  final Color secondary;
  final Color secondary2;
  final Color secondary3;
  final Color secondary4;

  final Color neutral1;
  final Color neutral2;
  final Color neutral3;
  final Color neutral4;
  final Color neutral5;
  final Color neutral6;
  final Color neutral7;
  final Color neutral8;

  final Color kShape750;
  final Color kShape650;
  final Color kShape550;
  final Color yellow;

  const AppThemeColor({
    required this.primary,
    required this.primary2,
    required this.primary3,
    required this.primary4,
    required this.secondary,
    required this.secondary2,
    required this.secondary3,
    required this.secondary4,
    required this.neutral1,
    required this.neutral2,
    required this.neutral3,
    required this.neutral4,
    required this.neutral5,
    required this.neutral6,
    required this.neutral7,
    required this.neutral8,
    required this.kShape750,
    required this.kShape650,
    required this.kShape550,
    required this.yellow,
  });

  factory AppThemeColor.light() {
    return const AppThemeColor(
      primary: ColorsConst.primary,
      primary2: ColorsConst.primary2,
      primary3: ColorsConst.primary3,
      primary4: ColorsConst.primary4,
      secondary: ColorsConst.primary,
      secondary2: ColorsConst.primary2,
      secondary3: ColorsConst.primary3,
      secondary4: ColorsConst.primary4,
      neutral1: ColorsConst.neutral1Light,
      neutral2: ColorsConst.neutral2Light,
      neutral3: ColorsConst.neutral3Light,
      neutral4: ColorsConst.neutral4Light,
      neutral5: ColorsConst.neutral5Light,
      neutral6: ColorsConst.neutral6Light,
      neutral7: ColorsConst.neutral7Light,
      neutral8: ColorsConst.neutral8Light,
      kShape750: ColorsConst.kShape750Light,
      kShape650: ColorsConst.kShape650Light,
      kShape550: ColorsConst.kShape550Light,
      yellow: Color(0x4DFFD166),
    );
  }

  factory AppThemeColor.dark() {
    return const AppThemeColor(
      primary: ColorsConst.primary,
      primary2: ColorsConst.primary2,
      primary3: ColorsConst.primary3,
      primary4: ColorsConst.primary4,
      secondary: ColorsConst.primary,
      secondary2: ColorsConst.primary2,
      secondary3: ColorsConst.primary3,
      secondary4: ColorsConst.primary4,
      neutral1: ColorsConst.neutral1Dark,
      neutral2: ColorsConst.neutral2Dark,
      neutral3: ColorsConst.neutral3Dark,
      neutral4: ColorsConst.neutral4Dark,
      neutral5: ColorsConst.neutral5Dark,
      neutral6: ColorsConst.neutral6Dark,
      neutral7: ColorsConst.neutral7Dark,
      neutral8: ColorsConst.neutral8Dark,
      kShape750: ColorsConst.kShape750Dark,
      kShape650: ColorsConst.kShape650Dark,
      kShape550: ColorsConst.kShape550Dark,
      yellow: Color(0x4DFFD166),
    );
  }

  @override
  AppThemeColor lerp(AppThemeColor? other, double t) {
    if (other is! AppThemeColor) {
      return this;
    }
    return AppThemeColor(
      primary: _lert(primary, other.primary, t),
      primary2: _lert(primary2, other.primary2, t),
      primary3: _lert(primary3, other.primary3, t),
      primary4: _lert(primary4, other.primary4, t),
      secondary: _lert(secondary, other.primary3, t),
      secondary2: _lert(secondary2, other.secondary2, t),
      secondary3: _lert(secondary3, other.secondary3, t),
      secondary4: _lert(secondary4, other.secondary4, t),
      neutral1: _lert(neutral1, other.neutral1, t),
      neutral2: _lert(neutral2, other.neutral2, t),
      neutral3: _lert(neutral3, other.neutral3, t),
      neutral4: _lert(neutral4, other.neutral4, t),
      neutral5: _lert(neutral5, other.neutral5, t),
      neutral6: _lert(neutral6, other.neutral6, t),
      neutral7: _lert(neutral7, other.neutral7, t),
      neutral8: _lert(neutral8, other.neutral8, t),
      kShape750: _lert(kShape750, other.kShape750, t),
      kShape650: _lert(kShape650, other.kShape650, t),
      kShape550: _lert(kShape550, other.kShape550, t),
      yellow: _lert(yellow, other.yellow, t),
    );
  }

  Color _lert(Color color, Color second, double t) {
    return Color.lerp(color, second, t)!;
  }

  @override
  ThemeExtension<AppThemeColor> copyWith({
    Color? primary,
    Color? primary2,
    Color? primary3,
    Color? primary4,
    Color? secondary,
    Color? secondary2,
    Color? secondary3,
    Color? secondary4,
    Color? neutral1,
    Color? neutral2,
    Color? neutral3,
    Color? neutral4,
    Color? neutral5,
    Color? neutral6,
    Color? neutral7,
    Color? neutral8,
    Color? kShape750,
    Color? kShape650,
    Color? kShape550,
    Color? yellow,
  }) {
    return AppThemeColor(
      primary: primary ?? this.primary,
      primary2: primary2 ?? this.primary2,
      primary3: primary3 ?? this.primary3,
      primary4: primary4 ?? this.primary4,
      secondary: secondary ?? this.secondary,
      secondary2: secondary2 ?? this.secondary2,
      secondary3: secondary3 ?? this.secondary3,
      secondary4: secondary4 ?? this.secondary4,
      neutral1: neutral1 ?? this.neutral1,
      neutral2: neutral2 ?? this.neutral2,
      neutral3: neutral3 ?? this.neutral3,
      neutral4: neutral4 ?? this.neutral4,
      neutral5: neutral5 ?? this.neutral5,
      neutral6: neutral6 ?? this.neutral6,
      neutral7: neutral7 ?? this.neutral7,
      neutral8: neutral8 ?? this.neutral8,
      kShape750: kShape750 ?? this.kShape750,
      kShape650: kShape650 ?? this.kShape650,
      kShape550: kShape550 ?? this.kShape550,
      yellow: yellow ?? this.yellow,
    );
  }
}
