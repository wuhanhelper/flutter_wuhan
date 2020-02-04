import 'package:flutter/material.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:wuhan/base/navigator_manager.dart';
import 'package:wuhan/utils/lcfarm_color.dart';
import 'package:wuhan/utils/lcfarm_style.dart';

/// @desc: 选择框
/// @time 2019-05-07 10:58
/// @author mrliuys

typedef BottomSheetCallback<T> = void Function(int index);

class LcfarmBottomSheet extends StatelessWidget {
  const LcfarmBottomSheet({
    Key key,
    @required this.context,
    //如果有titleList,将不会取值itemList
    this.titleList,
    //如果有titleList,将不会取值itemList
    this.itemList,
    //如果有itemBuilder,就不会使用默认的布局
    this.itemBuilder,
    //点击事件回调
    this.itemListCallBack,
  }) : super(key: key);

  final BuildContext context;

  final List<String> titleList;

  final List<LcfarmBottomSheetModel> itemList;
  final IndexedWidgetBuilder itemBuilder;
  final BottomSheetCallback itemListCallBack;

  @override
  Widget build(BuildContext context) {
    List pList = [];

    if (titleList != null) {
      for (String title in titleList) {
        LcfarmBottomSheetModel model = LcfarmBottomSheetModel(title: title);
        pList.add(model);
      }
    } else if (itemList != null) {
      pList = itemList;
    }

    return SafeArea(
      child: Container(
        constraints: BoxConstraints(maxHeight: double.infinity),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: pList.length,
                  itemBuilder: (BuildContext context, int position) {
                    return getItem(context, pList[position], position);
                  }),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: LcfarmSize.dp(10),
                    color: LcfarmColor.color08000000,
                  ),
                  GestureDetector(
                    onTap: () {
                      NavigatorManager().pop(context);
                    },
                    child: Container(
                      height: LcfarmSize.dp(48),
                      color: Colors.white,
                      child: Center(
                        child: Text("取消"),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getItem(
      BuildContext context, LcfarmBottomSheetModel sheetModel, int position) {
    return GestureDetector(
      onTap: () {
        if (sheetModel.clickDismissible) {
          NavigatorManager().pop(context);
        }

        if (sheetModel.bottomSheetCallback != null) {
          sheetModel.bottomSheetCallback(position);
        }
        if (itemListCallBack != null) {
          itemListCallBack(position);
        }
      },
      child: itemBuilder != null
          ? itemBuilder(context, position)
          : Container(
              color: LcfarmColor.colorFFFFFF,
              width: MediaQuery.of(context).size.width,
              height: LcfarmSize.dp(48),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text(
                        sheetModel.title,
                        style: sheetModel.titleStyle ??
                            LcfarmStyle.style80000000_14,
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: LcfarmColor.color08000000,
                  ),
                ],
              ),
            ),
    );
  }
}

class LcfarmBottomSheetModel {
  String title;
  TextStyle titleStyle;
  bool clickDismissible;

  ///点击回调
  BottomSheetCallback<LcfarmBottomSheetModel> bottomSheetCallback;

  LcfarmBottomSheetModel(
      {String title,
      TextStyle titleStyle,
      bool clickDismissible = true,
      BottomSheetCallback<LcfarmBottomSheetModel> bottomSheetCallback}) {
    this.title = title;
    this.titleStyle = titleStyle;
    this.clickDismissible = clickDismissible;
    this.bottomSheetCallback = bottomSheetCallback;
  }
}
