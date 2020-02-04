import 'dart:math' as math;

import 'package:flutter/material.dart';

/// @desc 禁止字体大小跟随系统字体改变大小
/// @time 2019-07-31 17:38
/// @author chenyun
class NoScaleTextWidget extends StatelessWidget {
  final Widget child;
  const NoScaleTextWidget({
    Key key,
    @required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(textScaleFactor: 1.0),
      child: child,
    );
  }
}

class MaxScaleTextWidget extends StatelessWidget {
  final double max;
  final Widget child;
  const MaxScaleTextWidget({
    Key key,
    this.max = 1.2,
    @required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    var scale = math.min(max, data.textScaleFactor);
    return MediaQuery(
      data: data.copyWith(textScaleFactor: scale),
      child: child,
    );
  }
}

class ScaleTextWidget extends StatelessWidget {
  final double scale;
  final Widget child;
  const ScaleTextWidget({
    Key key,
    @required this.scale,
    @required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    var scale = this.scale ?? data.textScaleFactor;
    return MediaQuery(
      data: data.copyWith(textScaleFactor: scale),
      child: child,
    );
  }
}
