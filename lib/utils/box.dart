import 'package:flutter/material.dart';


class Box {
  static SizedBox w(double size) => SizedBox(width: size);
  static SizedBox h(double size) => SizedBox(height: size);
  static SizedBox s(double size) => SizedBox(
        height: size,
        width: size,
      );
}