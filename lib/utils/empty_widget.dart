import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app_ui/config/theme/ui_constants.dart';
import 'package:news_app_ui/utils/app_style.dart';
import 'package:news_app_ui/utils/img_loader.dart';

class EmptyWidget extends StatelessWidget {
  final Function? tryAgain;
  final String? text;

  const EmptyWidget({super.key, this.tryAgain, this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text ?? 'No Data',
            style: Styles.captionBold.neutral4(context),
          ),
          SVGLoader.image("ic_empty"),
          UIConst.height(16),
        ],
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Container(
            height: 100,
            width: 100,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorsConst.themeColor(context).neutral3,
            ),
            child: LoadingAnimationWidget.flickr(
              leftDotColor: ColorsConst.primary,
              rightDotColor: ColorsConst.primary3,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
