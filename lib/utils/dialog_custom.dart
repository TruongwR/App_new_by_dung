import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:news_app_ui/utils/app_style.dart';
import 'package:news_app_ui/utils/box.dart';
import 'package:news_app_ui/utils/primary/primary_button.dart';

Future openDialogOnlyText({
  required BuildContext context,
  String? title,
  required String message,
}) {
  return openDialog<dynamic>(
    context: context,
    title: title ?? 'Notify',
    children: [
      Text(message, style: Styles.caption.neutral2(context)),
      Box.h(8),
    ],
    buttonOk: null,
    buttonCancel: 'Closed',
  );
}

Future<T?> openDialog<T extends Object?>({
  final double? widthFact,
  required BuildContext context,
  String? title,
  bool showClose = false,
  required List<Widget> children,
  String? buttonOk = 'Ok',
  String? buttonCancel,
  VoidCallback? okClick,
  VoidCallback? cancelClick,
}) async {
  return Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) {
        animation = Tween(begin: 0.0, end: 1.0).animate(animation);
        return FadeTransition(
          opacity: animation,
          child: DialogCustom(
            widthFact: widthFact,
            title: title,
            showClose: showClose,
            buttonOk: buttonOk,
            buttonCancel: buttonCancel,
            okClick: okClick,
            cancelClick: cancelClick,
            children: children,
          ),
        );
      },
      fullscreenDialog: true,
      opaque: false,
    ),
  );
}

class DialogCustom extends StatelessWidget {
  final String? title;
  final bool showClose;
  final List<Widget> children;
  final String? buttonOk;
  final String? buttonCancel;
  final VoidCallback? okClick;
  final VoidCallback? cancelClick;
  final Widget? child;
  final double? widthFact;

  const DialogCustom({
    super.key,
    this.title,
    this.showClose = false,
    required this.children,
    this.buttonOk = 'Đồng ý',
    this.buttonCancel,
    this.okClick,
    this.cancelClick,
    this.child,
    this.widthFact,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Colors.black.withOpacity(0.4),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _header(context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Column(
                  children: children,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: FractionallySizedBox(widthFactor: 1, child: _footer(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    if (title == null && !showClose) {
      return const SizedBox.shrink();
    }
    return ListTile(
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.white, width: 0),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      leading: const SizedBox.shrink(),
      title: title != null
          ? Text(
              title!,
              style: Styles.body2Bold.neutral2(context),
              textAlign: TextAlign.center,
            )
          : null,
      trailing: showClose
          ? InkWell(
              child: const Icon(Icons.close),
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          : const SizedBox.shrink(),
    );
  }

  Widget get _buttonOK {
    if (widthFact == null) {
      return PrimaryButton(
        title: buttonOk!,
        onPressed: okClick ??
            () {
              Get.back();
            },
      );
    }
    return FractionallySizedBox(
      widthFactor: widthFact,
      child: PrimaryButton(
        title: buttonOk!,
        onPressed: okClick ??
            () {
              Get.back();
            },
      ),
    );
  }

  Widget get _buttonCancel {
    return PrimaryOutlineButton(
      title: buttonCancel!,
      onPressed: cancelClick ??
          () {
            Get.back();
          },
    );
  }

  Widget _footer(BuildContext context) {
    if (buttonOk != null && buttonCancel != null) {
      return Row(
        children: [Expanded(child: _buttonCancel), Box.w(12), Expanded(child: _buttonOK)],
      );
    }
    if (buttonOk != null) {
      return _buttonOK;
    }
    if (buttonCancel != null) {
      return _buttonCancel;
    }
    return const SizedBox.shrink();
  }
}

Future openDialogError({
  String? title,
  required String content,
}) {
  log('openDialogError $content');
  final context = Get.context;
  return openDialogOnlyText(context: context!, title: title ?? 'Error', message: content);
}
