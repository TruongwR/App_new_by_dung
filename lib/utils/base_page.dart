import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:news_app_ui/data/providers/base_controller/base_controller.dart';
import 'package:news_app_ui/utils/app_bar.dart';

abstract class BasePage<T extends BaseController> extends GetView<T> {
  const BasePage({
    Key? key,
  }) : super(key: key);
  String? get titlePage;
  Color? backgroundColor(BuildContext context) {
    return null;
  }

  bool get showback;
  Widget body(BuildContext context);
  List<Widget>? actions(BuildContext context) {
    return null;
  }

  final GestureTapCallback? onBack = null;
  Widget? bottomNavigationBar(BuildContext context) {
    return null;
  }

  Widget? floatingActionButton(BuildContext context) {
    return null;
  }

  List<Widget>? persistentFooterButtons(BuildContext context) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
          backgroundColor: backgroundColor(context),
          appBar: (titlePage == null)
              ? null
              : AppBarLight(
                showback:showback ,
                  title: titlePage!,
                  action: actions(context),
                ),
          body: body(context),
          bottomNavigationBar: bottomNavigationBar(context),
          floatingActionButton: floatingActionButton(context),
          persistentFooterButtons: persistentFooterButtons(context),
        ),
      ),
    );
  }
}
