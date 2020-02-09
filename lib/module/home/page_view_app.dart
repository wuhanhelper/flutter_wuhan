import 'package:flutter/material.dart';
import 'package:wuhan/module/home/publish/publish.dart';

import 'homepage/homepage.dart';
import 'mine/mine.dart';

/// @desc 标准产品页面视图
/// @time 2019-09-27 13:43
/// @author chenyun
class PageViewApp extends StatelessWidget {
  final PageController _controller;

  PageViewApp(this._controller);

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _controller,
      children: <Widget>[Homepage(), Publish(), Mine()],
    );
  }
}
