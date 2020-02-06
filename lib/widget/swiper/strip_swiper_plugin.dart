import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wuhan/utils/lcfarm_color.dart';

/// @desc
/// @time 2019/12/24 18:45
/// @author liuwaiping
/// 轮播广告 --- 方块状指示器
///
class StripPaginationBuilder extends SwiperPlugin {
  ///color when current index,if set null , will be Theme.of(context).primaryColor
  final Color activeColor;

  ///,if set null , will be Theme.of(context).scaffoldBackgroundColor
  final Color color;

  ///Size of the dot when activate
  final double width;

  ///Size of the dot
  final double height;

  /// Space between dots
  final double space;

  final Key key;

  const StripPaginationBuilder(
      {this.activeColor,
      this.color,
      this.key,
      this.width = 8.0,
      this.height = 2.0,
      this.space = 3.0});

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    if (config.itemCount > 20) {
      print(
          "The itemCount is too big, we suggest use FractionPaginationBuilder instead of DotSwiperPaginationBuilder in this sitituation");
    }
    Color activeColor = this.activeColor;
    Color color = this.color;

    if (activeColor == null || color == null) {
      ThemeData themeData = Theme.of(context);
      activeColor = this.activeColor ?? themeData.primaryColor;
      color = this.color ?? themeData.scaffoldBackgroundColor;
    }

    if (config.indicatorLayout != PageIndicatorLayout.NONE &&
        config.layout == SwiperLayout.DEFAULT) {
      return PageIndicator(
        count: config.itemCount,
        controller: config.pageController,
        layout: config.indicatorLayout,
        activeColor: activeColor,
        color: color,
        space: space,
      );
    }

    List<Widget> list = [];

    int itemCount = config.itemCount;
    int activeIndex = config.activeIndex;

    bool vertical = config.scrollDirection == Axis.vertical;

    for (int i = 0; i < itemCount; ++i) {
      bool active = i == activeIndex;
      list.add(
        Container(
          key: Key("pagination_$i"),
          margin: EdgeInsets.only(
              left: vertical ? 0 : space,
              right: vertical ? 0 : space,
              top: vertical ? space : 0,
              bottom: vertical ? space : 0),
          child: Container(
            color: itemCount == 1
                ? LcfarmColor.color00000000
                : active ? activeColor : color,
            width: width,
            height: height,
          ),
        ),
      );
    }

    if (config.scrollDirection == Axis.vertical) {
      return Column(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    } else {
      return Row(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    }
  }
}
