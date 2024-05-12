// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ImageLoader {
  ImageLoader._();

  static Image image(
    String path, {
    Key? key,
    BoxFit fit = BoxFit.contain,
    double? width,
    double? height,
    double? size,
    Color? color,
  }) {
    return Image(
      key: key,
      image: AssetImage('assets/images/$path.png'),
      fit: fit,
      width: size ?? width,
      height: size ?? height,
      color: color,
    );
  }

  static Image gif(
    String fileName, {
    Key? key,
    BoxFit fit = BoxFit.contain,
    double? size,
    Color? color,
  }) {
    return Image.asset(
      'assets/gif/$fileName.gif',
      width: size,
      height: size,
    );
  }

  static Widget url(
    String? url, {
    BoxFit? fit,
    double? width,
    double? height,
    double? size,
    Color? color,
    Widget? iconError,
  }) {
    if (url == null || url.isEmpty) {
      return iconError ?? const Icon(Icons.error_outline);
    }
    // if (!url.contains('http') && environment == Environment.dev) {
    //   if (url.startsWith('/')) {
    //     url = url.replaceFirst('/', '');
    //   }
    //   url = 'https://api.ligh.pro/$url';
    // }
    return CachedNetworkImage(
      imageUrl: url,
      width: size ?? width,
      height: size ?? height,
      fit: fit,
      placeholder: (c, s) {
        return const Center(child: CupertinoActivityIndicator());
      },
      errorWidget: (c, url, error) {
        log('ImageLoader error: $url ====> $error');
        return const Icon(Icons.error);
      },
      color: color,
    );
  }
}

class SVGLoader {
  SVGLoader._();

  static SvgPicture image(
    String path, {
    BoxFit fit = BoxFit.contain,
    double? size,
    Color? color,
  }) {
    return SvgPicture.asset(
      'assets/icons/$path.svg',
      fit: fit,
      width: size,
      height: size,
      color: color,
    );
  }
}
