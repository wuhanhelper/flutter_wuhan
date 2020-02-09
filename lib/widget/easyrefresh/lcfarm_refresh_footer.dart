import 'package:flutter/material.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../lcfarm_loading.dart';

/// @desc  布谷农场加载更多
/// @time 2019/4/16 4:14 PM
/// @author chenyun
///

/// 经典Footer
class LcfarmLoadMoreFooter extends Footer {
  /// Key
  final Key key;

  /// 方位
  final AlignmentGeometry alignment;

  /// 背景颜色
  final Color bgColor;

  LcfarmLoadMoreFooter(
      {extent = 60.0,
      triggerDistance = 70.0,
      float = false,
      completeDuration = const Duration(seconds: 1),
      enableInfiniteLoad = true,
      enableHapticFeedback = true,
      this.key,
      this.alignment,
      this.bgColor = Colors.transparent})
      : super(
          extent: extent,
          triggerDistance: triggerDistance,
          float: float,
          completeDuration: completeDuration,
          enableInfiniteLoad: enableInfiniteLoad,
          enableHapticFeedback: enableHapticFeedback,
        );

  @override
  Widget contentBuilder(
      BuildContext context,
      LoadMode loadState,
      double pulledExtent,
      double loadTriggerPullDistance,
      double loadIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration completeDuration,
      bool enableInfiniteLoad,
      bool success,
      bool noMore) {
    return LcfarmLoadMoreFooterWidget(
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

/// 经典Footer组件
class LcfarmLoadMoreFooterWidget extends StatefulWidget {
  final LcfarmLoadMoreFooter classicalFooter;
  final LoadMode loadState;
  final double pulledExtent;
  final double loadTriggerPullDistance;
  final double loadIndicatorExtent;
  final AxisDirection axisDirection;
  final bool float;
  final Duration completeDuration;
  final bool enableInfiniteLoad;
  final bool success;
  final bool noMore;

  LcfarmLoadMoreFooterWidget(
      {Key key,
      this.loadState,
      this.classicalFooter,
      this.pulledExtent,
      this.loadTriggerPullDistance,
      this.loadIndicatorExtent,
      this.axisDirection,
      this.float,
      this.completeDuration,
      this.enableInfiniteLoad,
      this.success,
      this.noMore})
      : super(key: key);

  @override
  LcfarmLoadMoreFooterWidgetState createState() =>
      LcfarmLoadMoreFooterWidgetState();
}

class LcfarmLoadMoreFooterWidgetState extends State<LcfarmLoadMoreFooterWidget>
    with TickerProviderStateMixin<LcfarmLoadMoreFooterWidget> {
  // 是否到达触发加载距离
  bool _overTriggerDistance = false;

  bool get overTriggerDistance => _overTriggerDistance;

  set overTriggerDistance(bool over) {
    if (_overTriggerDistance != over) {
      _overTriggerDistance
          ? _readyController.forward()
          : _restoreController.forward();
    }
    _overTriggerDistance = over;
  }

  // 动画
  AnimationController _readyController;
  Animation<double> _readyAnimation;
  AnimationController _restoreController;
  Animation<double> _restoreAnimation;

  // Icon旋转度
  double _iconRotationValue = 1.0;

  bool loadComple;

  @override
  void initState() {
    super.initState();

    // 初始化动画
    _readyController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
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
    _restoreController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
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
  }

  @override
  void dispose() {
    _readyController.dispose();
    _restoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 是否为垂直方向
    bool isVertical = widget.axisDirection == AxisDirection.down ||
        widget.axisDirection == AxisDirection.up;
    // 是否反向
    bool isReverse = widget.axisDirection == AxisDirection.up ||
        widget.axisDirection == AxisDirection.left;
    // 是否到达触发加载距离
    overTriggerDistance = widget.loadState != LoadMode.inactive &&
        widget.pulledExtent >= widget.loadTriggerPullDistance;

    loadComple = (widget.loadState == LoadMode.loaded ||
        widget.loadState == LoadMode.inactive);

    return Stack(
      children: <Widget>[
        Positioned(
          top: !isVertical ? 0.0 : !isReverse ? 0.0 : null,
          bottom: !isVertical ? 0.0 : isReverse ? 0.0 : null,
          left: isVertical ? 0.0 : !isReverse ? 0.0 : null,
          right: isVertical ? 0.0 : isReverse ? 0.0 : null,
          child: Container(
            alignment: widget.classicalFooter.alignment ?? isVertical
                ? !isReverse ? Alignment.topCenter : Alignment.bottomCenter
                : isReverse ? Alignment.centerRight : Alignment.centerLeft,
            width: !isVertical
                ? widget.loadIndicatorExtent > widget.pulledExtent
                    ? widget.loadIndicatorExtent
                    : widget.pulledExtent
                : double.infinity,
            height: isVertical
                ? widget.loadIndicatorExtent > widget.pulledExtent
                    ? widget.loadIndicatorExtent
                    : widget.pulledExtent
                : double.infinity,
            color: widget.classicalFooter.bgColor,
            child: SizedBox(
              height: isVertical ? widget.loadIndicatorExtent : double.infinity,
              width: !isVertical ? widget.loadIndicatorExtent : double.infinity,
              child: isVertical
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [buildLoading(isVertical, isReverse)],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [buildLoading(isVertical, isReverse)],
                    ),
            ),
          ),
        ),
      ],
    );
  }

  double contentHeight = LcfarmSize.dp(35);

  Widget buildLoading(bool isVertical, bool isReverse) {
    return Container(
      height: widget.classicalFooter.extent,
//      color: LcfarmColor.colorF7F8FA,
      child: SingleChildScrollView(
        scrollDirection: isVertical ? Axis.vertical : Axis.horizontal,
        child: Container(
          height: widget.classicalFooter.extent > contentHeight
              ? widget.classicalFooter.extent
              : contentHeight,
          child: Center(
            child: LcfarmLoading(),
          ),
        ),
      ),
    );
  }
}
