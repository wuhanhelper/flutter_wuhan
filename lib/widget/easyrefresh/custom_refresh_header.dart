//import 'package:flutter/material.dart';
//import 'package:flutter_easyrefresh/easy_refresh.dart';
//import 'package:kappa_app/utils/lcfarm_color.dart';
//
///// @desc: 自定义Header
///// @time: 2019-06-10 15:29:39
///// @author: yuming
//class CustomRefreshHeader extends ClassicsHeader {
//  // 提示刷新文字
//  final String refreshText;
//  // 准备刷新文字
//  final String refreshReadyText;
//  // 正在刷新文字
//  final String refreshingText;
//  // 刷新完成文字
//  final String refreshedText;
//  // 背景颜色
//  final Color bgColor;
//  // 字体颜色
//  final Color textColor;
//  // 触发刷新的高度
//  final double refreshHeight;
//  // 是否浮动
//  final bool isFloat;
//  // 显示额外信息(默认为时间)
//  final bool showMore;
//  // 更多信息
//  final String moreInfo;
//  // 更多信息文字颜色
//  final Color moreInfoColor;
//
//  // 构造函数
//  CustomRefreshHeader({
//    @required GlobalKey<RefreshHeaderState> key,
//    this.refreshText: '下拉刷新',
//    this.refreshReadyText: '释放刷新',
//    this.refreshingText: '正在刷新',
//    this.refreshedText: '刷新结束',
//    this.bgColor: Colors.transparent,
//    this.textColor: LcfarmColor.color80000000,
//    this.moreInfoColor: LcfarmColor.color60000000,
//    this.refreshHeight: 70.0,
//    this.isFloat: false,
//    this.showMore: false,
//    this.moreInfo: '更新于 %T',
//  }) : super(key: key, refreshHeight: refreshHeight, isFloat: isFloat);
//}
