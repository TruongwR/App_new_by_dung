


// ignore_for_file: invalid_use_of_protected_member, unused_field, unused_element

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:news_app_ui/config/theme/ui_constants.dart';
import 'package:news_app_ui/data/providers/base_controller/base_controller.dart';


import 'package:news_app_ui/utils/empty_widget.dart';

typedef ScrollBuilder<T> = ScrollView Function(List<T> items);

class LoadMoreWidget<T> extends StatelessWidget {
  final ScrollBuilder<T> scrollView;
  final PaginationController<T> controller;
  final Widget? emptyWidget;
  final Widget? loading;
  final Widget? endOfPage;

  const LoadMoreWidget({
    Key? key,
    required this.controller,
    required this.scrollView,
    this.emptyWidget,
    this.loading,
    this.endOfPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, side) {
      return Obx(() {
        final items = controller.items.value;
        if (items.isEmpty && controller.firstTime) {
          return loading ?? UIConst.loading;
        }
        return EasyRefresh(
          firstRefreshWidget: const CupertinoActivityIndicator(),
          header: LoadMoreHeader(),
          footer: CustomFooter(
              extent: 50.0,
              triggerDistance: 50.0,
              enableInfiniteLoad: true,
              enableHapticFeedback: true,
              footerBuilder: (BuildContext context, LoadMode loadState, double pulledExtent, double loadTriggerPullDistance, double loadIndicatorExtent,
                  AxisDirection axisDirection, bool float, Duration? completeDuration, bool enableInfiniteLoad, bool success, bool noMore) {
                return Center(
                  child: Obx(() {
                    return controller.endOfPage.value ? endOfPage ?? const Text('End of page') : loading ?? const CupertinoActivityIndicator();
                  }),
                );
              }),
          controller: controller.refreshController,
          onRefresh: () => controller.onRefresh(),
          onLoad: () => controller.onLoad(),
          child: items.isEmpty
              ? SizedBox(
                  height: side.maxHeight,
                  child: emptyWidget ?? const EmptyWidget(),
                )
              : scrollView(items),
        );
      });
    });
  }
}

class LoadMoreHeader extends Header {
  /// Key
  final Key? key;

  /// 方位
  final AlignmentGeometry? alignment;

  /// 背景颜色
  final Color bgColor;

  /// 字体颜色
  final Color textColor;

  /// 更多信息文字颜色
  final Color infoColor;

  LoadMoreHeader({
    double extent = 60.0,
    double triggerDistance = 70.0,
    bool float = false,
    bool enableInfiniteRefresh = false,
    bool enableHapticFeedback = true,
    bool overScroll = true,
    this.key,
    this.alignment,
    this.bgColor = Colors.transparent,
    this.textColor = Colors.black,
    this.infoColor = Colors.teal,
  }) : super(
          extent: extent,
          triggerDistance: triggerDistance,
          float: float,
          // completeDuration: const Duration(seconds: 5),
          enableInfiniteRefresh: enableInfiniteRefresh,
          enableHapticFeedback: enableHapticFeedback,
          overScroll: overScroll,
        );

  @override
  Widget contentBuilder(BuildContext context, RefreshMode refreshState, double pulledExtent, double refreshTriggerPullDistance, double refreshIndicatorExtent,
      AxisDirection axisDirection, bool float, Duration? completeDuration, bool enableInfiniteRefresh, bool success, bool noMore) {
    return _LoadMoreHeaderWidget(
      key: key,
      classicalHeader: this,
      refreshState: refreshState,
      pulledExtent: pulledExtent,
      refreshTriggerPullDistance: refreshTriggerPullDistance,
      refreshIndicatorExtent: refreshIndicatorExtent,
      axisDirection: axisDirection,
      float: float,
      completeDuration: completeDuration,
      enableInfiniteRefresh: enableInfiniteRefresh,
      success: success,
      noMore: noMore,
    );
  }
}

class _LoadMoreHeaderWidget extends StatefulWidget {
  final LoadMoreHeader classicalHeader;
  final RefreshMode refreshState;
  final double pulledExtent;
  final double refreshTriggerPullDistance;
  final double refreshIndicatorExtent;
  final AxisDirection axisDirection;
  final bool float;
  final Duration? completeDuration;
  final bool enableInfiniteRefresh;
  final bool success;
  final bool noMore;

  const _LoadMoreHeaderWidget(
      {Key? key,
      required this.refreshState,
      required this.classicalHeader,
      required this.pulledExtent,
      required this.refreshTriggerPullDistance,
      required this.refreshIndicatorExtent,
      required this.axisDirection,
      required this.float,
      required this.completeDuration,
      required this.enableInfiniteRefresh,
      required this.success,
      required this.noMore})
      : super(key: key);

  @override
  _LoadMoreHeaderWidgetState createState() => _LoadMoreHeaderWidgetState();
}

class _LoadMoreHeaderWidgetState extends State<_LoadMoreHeaderWidget> with TickerProviderStateMixin<_LoadMoreHeaderWidget> {
  // 是否到达触发刷新距离
  bool _overTriggerDistance = false;

  bool get overTriggerDistance => _overTriggerDistance;

  set overTriggerDistance(bool over) {
    // logd(over);
    if (_overTriggerDistance != over) {
      _overTriggerDistance ? _readyController.forward() : _restoreController.forward();
      _overTriggerDistance = over;
    }
  }

  // 是否刷新完成
  bool _refreshFinish = false;

  set refreshFinish(bool finish) {
    if (_refreshFinish != finish) {
      if (finish && widget.float) {
        Future.delayed(widget.completeDuration! - const Duration(milliseconds: 400), () {
          if (mounted) {
            _floatBackController.forward();
          }
        });
        Future.delayed(widget.completeDuration!, () {
          _floatBackDistance = null;
          _refreshFinish = false;
        });
      }
      _refreshFinish = finish;
    }
  }

  // 动画
  late AnimationController _readyController;
  late Animation<double> _readyAnimation;
  late AnimationController _restoreController;
  late Animation<double> _restoreAnimation;
  late AnimationController _floatBackController;
  late Animation<double> _floatBackAnimation;

  // Icon旋转度
  double _iconRotationValue = 1.0;

  // 浮动时,收起距离
  double? _floatBackDistance;

  @override
  void initState() {
    super.initState();
    // 准备动画
    _readyController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _readyAnimation = Tween(begin: 0.5, end: 1.0).animate(_readyController)
      ..addListener(() {
        setState(() {
          if (_readyAnimation.status != AnimationStatus.dismissed) {
            _iconRotationValue = _readyAnimation.value;
          }
        });
      });
    _readyAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _readyController.reset();
      }
    });
    // 恢复动画
    _restoreController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _restoreAnimation = Tween(begin: 1.0, end: 0.5).animate(_restoreController)
      ..addListener(() {
        setState(() {
          if (_restoreAnimation.status != AnimationStatus.dismissed) {
            _iconRotationValue = _restoreAnimation.value;
          }
        });
      });
    _restoreAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _restoreController.reset();
      }
    });
    // float收起动画
    _floatBackController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _floatBackAnimation = Tween(begin: widget.refreshIndicatorExtent, end: 0.0).animate(_floatBackController)
      ..addListener(() {
        setState(() {
          if (_floatBackAnimation.status != AnimationStatus.dismissed) {
            _floatBackDistance = _floatBackAnimation.value;
          }
        });
      });
    _floatBackAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _floatBackController.reset();
      }
    });
  }

  @override
  void dispose() {
    _readyController.dispose();
    _restoreController.dispose();
    _floatBackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 是否反向
    bool isReverse = widget.axisDirection == AxisDirection.up || widget.axisDirection == AxisDirection.left;
    // 是否到达触发刷新距离
    overTriggerDistance = widget.refreshState != RefreshMode.inactive && widget.pulledExtent >= widget.refreshTriggerPullDistance;
    if (widget.refreshState == RefreshMode.refreshed) {
      refreshFinish = true;
    }
    return Stack(
      children: <Widget>[
        Positioned(
          top: isReverse
              ? _floatBackDistance == null
                  ? 0.0
                  : (widget.refreshIndicatorExtent - _floatBackDistance!)
              : null,
          bottom: !isReverse
              ? _floatBackDistance == null
                  ? 0.0
                  : (widget.refreshIndicatorExtent - _floatBackDistance!)
              : null,
          left: 0.0,
          right: 0.0,
          child: Container(
            alignment: widget.classicalHeader.alignment ?? (isReverse ? Alignment.topCenter : Alignment.bottomCenter),
            width: double.infinity,
            height: _floatBackDistance == null
                ? (widget.refreshIndicatorExtent > widget.pulledExtent ? widget.refreshIndicatorExtent : widget.pulledExtent)
                : widget.refreshIndicatorExtent,
            color: widget.classicalHeader.bgColor,
            child: SizedBox(
              height: widget.refreshIndicatorExtent,
              width: double.infinity,
              child: const CupertinoActivityIndicator(radius: 15),
            ),
          ),
        ),
      ],
    );
  }
}

/// FOOTER

class _LoadMoreFooter extends Footer {
  /// Key
  final Key? key;

  final AlignmentGeometry? alignment;

  _LoadMoreFooter({
    double extent = 1.0,
    double triggerDistance = 2.0,
    bool float = false,
    bool enableInfiniteLoad = true,
    bool enableHapticFeedback = true,
    bool overScroll = false,
    bool safeArea = true,
    EdgeInsets? padding,
    this.key,
    this.alignment,
  }) : super(
          extent: extent,
          triggerDistance: triggerDistance,
          float: float,
          completeDuration: null,
          enableInfiniteLoad: enableInfiniteLoad,
          enableHapticFeedback: enableHapticFeedback,
          overScroll: overScroll,
          safeArea: safeArea,
          padding: padding,
        );

  @override
  Widget contentBuilder(BuildContext context, LoadMode loadState, double pulledExtent, double loadTriggerPullDistance, double loadIndicatorExtent, AxisDirection axisDirection,
      bool float, Duration? completeDuration, bool enableInfiniteLoad, bool success, bool noMore) {
    return _LoadMoreFooterWidget(
      key: key,
      classicalFooter: this,
      loadState: loadState,
      pulledExtent: pulledExtent,
      loadTriggerPullDistance: loadTriggerPullDistance,
      loadIndicatorExtent: loadIndicatorExtent,
      axisDirection: axisDirection,
      float: float,
      completeDuration: completeDuration,
      enableInfiniteLoad: enableInfiniteLoad,
      success: success,
      noMore: noMore,
    );
  }
}

class _LoadMoreFooterWidget extends StatefulWidget {
  final _LoadMoreFooter classicalFooter;
  final LoadMode loadState;
  final double pulledExtent;
  final double loadTriggerPullDistance;
  final double loadIndicatorExtent;
  final AxisDirection axisDirection;
  final bool float;
  final Duration? completeDuration;
  final bool enableInfiniteLoad;
  final bool success;
  final bool noMore;

  const _LoadMoreFooterWidget(
      {Key? key,
      required this.loadState,
      required this.classicalFooter,
      required this.pulledExtent,
      required this.loadTriggerPullDistance,
      required this.loadIndicatorExtent,
      required this.axisDirection,
      required this.float,
      this.completeDuration,
      required this.enableInfiniteLoad,
      required this.success,
      required this.noMore})
      : super(key: key);

  @override
  _LoadMoreFooterWidgetState createState() => _LoadMoreFooterWidgetState();
}

class _LoadMoreFooterWidgetState extends State<_LoadMoreFooterWidget> with TickerProviderStateMixin<_LoadMoreFooterWidget> {
  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
