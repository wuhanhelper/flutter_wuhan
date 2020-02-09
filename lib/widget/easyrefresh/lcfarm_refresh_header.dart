import 'package:flutter/material.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../lcfarm_loading.dart';

/// @desc  自定义下拉刷新头部
/// @time 2019/4/16 9:32 AM
/// @author chenyun
///

/// 经典Header
class LcfarmRefreshHeader extends Header {
  /// Key
  final Key key;

  /// 方位
  final AlignmentGeometry alignment;

  /// 背景颜色
  final Color bgColor;

  LcfarmRefreshHeader({
    extent = 60.0,
    triggerDistance = 70.0,
    float = false,
    completeDuration = const Duration(seconds: 1),
    enableInfiniteRefresh = false,
    enableHapticFeedback = true,
    this.key,
    this.alignment,
    this.bgColor = Colors.transparent,
  }) : super(
          extent: extent,
          triggerDistance: triggerDistance,
          float: float,
          completeDuration: float
              ? completeDuration == null
                  ? Duration(
                      milliseconds: 400,
                    )
                  : completeDuration +
                      Duration(
                        milliseconds: 400,
                      )
              : completeDuration,
          enableInfiniteRefresh: enableInfiniteRefresh,
          enableHapticFeedback: enableHapticFeedback,
        );

  @override
  Widget contentBuilder(
      BuildContext context,
      RefreshMode refreshState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration completeDuration,
      bool enableInfiniteRefresh,
      bool success,
      bool noMore) {
    return LcfarmRefreshHeaderWidget(
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

/// 经典Header组件
class LcfarmRefreshHeaderWidget extends StatefulWidget {
  final LcfarmRefreshHeader classicalHeader;
  final RefreshMode refreshState;
  final double pulledExtent;
  final double refreshTriggerPullDistance;
  final double refreshIndicatorExtent;
  final AxisDirection axisDirection;
  final bool float;
  final Duration completeDuration;
  final bool enableInfiniteRefresh;
  final bool success;
  final bool noMore;

  LcfarmRefreshHeaderWidget(
      {Key key,
      this.refreshState,
      this.classicalHeader,
      this.pulledExtent,
      this.refreshTriggerPullDistance,
      this.refreshIndicatorExtent,
      this.axisDirection,
      this.float,
      this.completeDuration,
      this.enableInfiniteRefresh,
      this.success,
      this.noMore})
      : super(key: key);

  @override
  LcfarmRefreshHeaderWidgetState createState() =>
      LcfarmRefreshHeaderWidgetState();
}

class LcfarmRefreshHeaderWidgetState extends State<LcfarmRefreshHeaderWidget>
    with TickerProviderStateMixin<LcfarmRefreshHeaderWidget> {
  // 是否到达触发刷新距离
  bool _overTriggerDistance = false;

  bool _isLoading = false;

  bool get overTriggerDistance => _overTriggerDistance;

  set overTriggerDistance(bool over) {
    if (_overTriggerDistance != over) {
      _overTriggerDistance = over;
    }
  }

  // 是否刷新完成
  bool _refreshFinish = false;

  set refreshFinish(bool finish) {
    if (_refreshFinish != finish) {
      if (finish && widget.float) {
        Future.delayed(widget.completeDuration - Duration(milliseconds: 400),
            () {
          if (mounted) {
            _floatBackController.forward();
          }
        });
        Future.delayed(widget.completeDuration, () {
          _floatBackDistance = null;
          _refreshFinish = false;
        });
      }
      _refreshFinish = finish;
    }
  }

  AnimationController _floatBackController;
  Animation<double> _floatBackAnimation;

  // 浮动时,收起距离
  double _floatBackDistance;

  @override
  void initState() {
    super.initState();

    // float收起动画
    _floatBackController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _floatBackAnimation = Tween(begin: widget.refreshIndicatorExtent, end: 0.0)
        .animate(_floatBackController)
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
    _floatBackController.dispose();
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
    // 是否到达触发刷新距离
    overTriggerDistance = widget.refreshState != RefreshMode.inactive &&
        widget.pulledExtent >= widget.refreshTriggerPullDistance;
    if (widget.refreshState == RefreshMode.refreshed) {
      refreshFinish = true;
    }

    _isLoading = (widget.refreshState == RefreshMode.armed ||
        widget.refreshState == RefreshMode.refresh ||
        widget.refreshState == RefreshMode.refreshed);
    //   LogUtil.v('refreshState = ${widget.refreshState}');

    return Stack(
      children: <Widget>[
        Positioned(
          top: !isVertical
              ? 0.0
              : isReverse
                  ? _floatBackDistance == null
                      ? 0.0
                      : (widget.refreshIndicatorExtent - _floatBackDistance)
                  : null,
          bottom: !isVertical
              ? 0.0
              : !isReverse
                  ? _floatBackDistance == null
                      ? 0.0
                      : (widget.refreshIndicatorExtent - _floatBackDistance)
                  : null,
          left: isVertical
              ? 0.0
              : isReverse
                  ? _floatBackDistance == null
                      ? 0.0
                      : (widget.refreshIndicatorExtent - _floatBackDistance)
                  : null,
          right: isVertical
              ? 0.0
              : !isReverse
                  ? _floatBackDistance == null
                      ? 0.0
                      : (widget.refreshIndicatorExtent - _floatBackDistance)
                  : null,
          child: Container(
            alignment: widget.classicalHeader.alignment ?? isVertical
                ? isReverse ? Alignment.topCenter : Alignment.bottomCenter
                : !isReverse ? Alignment.centerRight : Alignment.centerLeft,
            width: isVertical
                ? double.infinity
                : _floatBackDistance == null
                    ? (widget.refreshIndicatorExtent > widget.pulledExtent
                        ? widget.refreshIndicatorExtent
                        : widget.pulledExtent)
                    : widget.refreshIndicatorExtent,
            height: isVertical
                ? _floatBackDistance == null
                    ? (widget.refreshIndicatorExtent > widget.pulledExtent
                        ? widget.refreshIndicatorExtent
                        : widget.pulledExtent)
                    : widget.refreshIndicatorExtent
                : double.infinity,
            color: widget.classicalHeader.bgColor,
            child: SizedBox(
              height:
                  isVertical ? widget.refreshIndicatorExtent : double.infinity,
              width:
                  !isVertical ? widget.refreshIndicatorExtent : double.infinity,
              child: buildLoading(isVertical, isReverse),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLoading(bool isVertical, bool isReverse) {
    return Container(
      height: widget.classicalHeader.extent,
      child: SingleChildScrollView(
        child: Container(
//          color: LcfarmColor.colorF7F8FA,
          child: Container(
            height: widget.classicalHeader.extent > LcfarmSize.dp(45)
                ? widget.classicalHeader.extent
                : LcfarmSize.dp(45),
            child: isVertical
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Offstage(
                        offstage: !_isLoading,
                        child: LcfarmLoading(),
                      ),
                      Offstage(
                        offstage: _isLoading,
                        child: Image.asset(
                          'images/loading/loading_1@3x.png',
                          width: LcfarmSize.dp(40),
                          height: LcfarmSize.dp(40),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Offstage(
                        offstage: !_isLoading,
                        child: LcfarmLoading(),
                      ),
                      Offstage(
                        offstage: _isLoading,
                        child: Image.asset(
                          'images/loading/loading_1@3x.png',
                          width: LcfarmSize.dp(40),
                          height: LcfarmSize.dp(40),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
