
import 'package:flutter/material.dart';

import 'package:ndialog/ndialog.dart';
import 'package:news_app_ui/config/theme/color_palette.dart';

class LoadingDialog {
  ProgressDialog? progressDialog;
  BuildContext? ctx;

  LoadingDialog(BuildContext ctx, {msg = "Please Wait", title = "Loading...", dismissable = true}) {
    this.ctx = ctx;
    progressDialog = ProgressDialog(ctx,
        message: Text(msg),
        title: Text(title),
        dismissable: dismissable,
        defaultLoadingWidget: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(kPrimaryColor),
        ),
        dialogStyle: DialogStyle(titleDivider: false));
  }

  show() {
    progressDialog?.show();
  }

  showError(dynamic err) async {
    progressDialog?.dismiss();
    progressDialog = ProgressDialog(progressDialog!.context,
        message: progressDialog?.message,
        title: progressDialog?.title,
        dismissable: true,
        defaultLoadingWidget: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(kPrimaryColor),
        ),
        dialogStyle: DialogStyle(titleDivider: true));

    progressDialog?.setTitle(const Text("Error"));
    progressDialog?.setMessage(Text("$err"));
    progressDialog?.setLoadingWidget(const Icon(
      Icons.error,
      color: Colors.red,
    ));
    progressDialog?.show();
    await Future.delayed(const Duration(seconds: 5));
    progressDialog?.dismiss();
  }

  dismiss() {
    progressDialog?.dismiss();
  }
}
