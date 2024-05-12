


import 'package:flutter/material.dart';

import 'package:news_app_ui/config/theme/color_palette.dart';
import 'package:news_app_ui/config/theme/text_style.dart';

final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: kPrimaryColor,
  textStyle: kButton1,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(0)),
  ),
);

final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
  foregroundColor: kPrimaryColor, textStyle: kButton1,
  side: const BorderSide(color: kPrimaryColor, width: 1),
  padding: const EdgeInsets.fromLTRB(12, 9.5, 12, 9.5),
  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
);
