//import 'package:flutter/material.dart';
//import 'package:flutter_easyrefresh/easy_refresh.dart';
//import 'package:kappa_app/utils/lcfarm_color.dart';
//
///// @desc: 自定义Footer
///// @time: 2019-06-10 16:21:23
///// @author: yuming
//class CustomRefreshFooter extends ClassicsFooter {
//  // 提示加载文字
//  final String loadText;
//  // 准备加载文字
//  final String loadReadyText;
//  // 正在加载文字
//  final String loadingText;
//  // 没有更多文字
//  final String noMoreText;
//  // 刷新完成文字
//  final String loadedText;
//  // 背景颜色
//  final Color bgColor;
//  // 字体颜色
//  final Color textColor;
//  // 触发加载的高度
//  final double loadHeight;
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
//  CustomRefreshFooter({
//    @required GlobalKey<RefreshFooterState> key,
//    this.loadText: '上拉加载',
//    this.loadReadyText: '释放加载',
//    this.loadingText: '正在加载',
//    this.loadedText: '加载结束',
//    this.noMoreText: '没有更多数据',
//    this.bgColor: Colors.transparent,
//    this.textColor: LcfarmColor.color80000000,
//    this.moreInfoColor: LcfarmColor.color60000000,
//    this.loadHeight: 70.0,
//    this.isFloat: false,
//    this.showMore: false,
//    this.moreInfo: '更新于 %T',
//  }) : super(key: key, loadHeight: loadHeight, isFloat: isFloat);
//}
