import 'package:flutter/material.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';

import 'base/router.dart';

/// @desc 文本内部间距
/// @time 2019-07-16 09:17
/// @author chenyun
class FlutterTextExample extends StatelessWidget {
  static const String router = Router.scheme + "FlutterTextExample";

  final List<int> fontSizes = [];

  @override
  Widget build(BuildContext context) {
    for (int i = 8; i < 49; i++) {
      fontSizes.add(i);
    }
    return ListView.builder(
      itemBuilder: _buildItem,
      itemCount: (fontSizes.length ~/ 2),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5),
//          color: Colors.lightBlue,
          color: Colors.red,
          child: Text(
            "${fontSizes[index * 2]}号字体",
            style: TextStyle(
              backgroundColor: Colors.lightBlue,
              color: Colors.orange,
//              textBaseline: TextBaseline.alphabetic,
              fontSize:
                  LcfarmSize.dp(fontSizes[index * 2].toDouble().toDouble()),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
//          color: Colors.lightBlue,
          child: Text(
            "${fontSizes[index * 2 + 1]}号字体",
            style: TextStyle(
              backgroundColor: Colors.lightBlue,
              color: Colors.orange,
//              textBaseline: TextBaseline.alphabetic,
              fontSize: LcfarmSize.dp(fontSizes[index * 2 + 1].toDouble()),
            ),
          ),
        )
      ],
    );
  }
}
