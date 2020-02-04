import 'package:flutter/material.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';

import 'lcfarm_frame_animation_image.dart';


/// @desc 加载动态
/// @time 2019-07-09 09:36
/// @author chenyun
class LcfarmLoading extends StatelessWidget {
  final double size;

  final int interval;

  LcfarmLoading({this.size, this.interval});

  @override
  Widget build(BuildContext context) {
    return LcfarmFrameAnimationImage(
      [
        "images/loading/loading_1@3x.png",
        "images/loading/loading_2@3x.png",
        "images/loading/loading_3@3x.png",
        "images/loading/loading_4@3x.png",
        "images/loading/loading_5@3x.png",
        "images/loading/loading_6@3x.png",
        "images/loading/loading_7@3x.png",
        "images/loading/loading_8@3x.png",
      ],
      width: size ?? LcfarmSize.dp(40),
      height: size ?? LcfarmSize.dp(40),
      interval: interval ?? 120,
    );
  }
}
