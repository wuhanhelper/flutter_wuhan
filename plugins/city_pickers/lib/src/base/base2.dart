/**
 * Created with Android Studio.
 * User: 三帆
 * Date: 28/01/2019
 * Time: 18:20
 * email: sanfan.hx@alibaba-inc.com
 * tartget:  xxx
 */
import 'dart:async';

import 'package:city_pickers/modal/city_point.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../modal/result.dart';
import '../mod/inherit_process.dart';
import '../show_types.dart';

class Base2View extends StatefulWidget {
  final double progress;
  final String locationCode;
  final ShowType showType;
  final List<CityPoint> provinceCityAreaList;

  final Result initDataResult;

  // 容器高度
  final double height;

  Base2View({
    this.progress,
    this.showType,
    this.height,
    this.locationCode,
    this.provinceCityAreaList,
    this.initDataResult,
  });

  _BaseView createState() => _BaseView();
}

class _BaseView extends State<Base2View> {
  Timer _changeTimer;
  bool _resetControllerOnce = false;
  FixedExtentScrollController provinceController;
  FixedExtentScrollController cityController;
  FixedExtentScrollController areaController;

  List<CityPoint> provinceCityAreaList;

  CityPoint targetProvince;
  CityPoint targetCity;
  CityPoint targetArea;

  @override
  void initState() {
    super.initState();
    provinceCityAreaList = widget.provinceCityAreaList;

    initData();
  }

  void initData() {
    try {
      _initLocation(widget.locationCode);
    } catch (e) {
      print('Exception details:\n 初始化地理位置信息失败, 请检查省分城市数据 \n $e');
    }
    _initController();
  }

  void dispose() {
    provinceController.dispose();
    cityController.dispose();
    areaController.dispose();
    if (_changeTimer != null && _changeTimer.isActive) {
      _changeTimer.cancel();
    }
    super.dispose();
  }

  // 初始化controller, 为了使给定的默认值, 在选框的中心位置
  void _initController() {
    provinceController = FixedExtentScrollController(
        initialItem: provinceCityAreaList
            .indexWhere((CityPoint p) => p.value == targetProvince.value));

    cityController = FixedExtentScrollController(
        initialItem: targetProvince.children
            .indexWhere((CityPoint p) => p.value == targetCity.value));

    areaController = FixedExtentScrollController(
        initialItem: targetCity.children
            .indexWhere((CityPoint p) => p.value == targetArea.value));
  }

  // 重置Controller的原因在于, 无法手动去更改initialItem, 也无法通过
  // jumpTo or animateTo去更改, 强行更改, 会触发 _onProvinceChange  _onCityChange 与 _onAreacChange
  // 只为覆盖初始化化的参数initialItem
  void _resetController() {
    if (_resetControllerOnce) return;
    provinceController = FixedExtentScrollController(initialItem: 0);

    cityController = FixedExtentScrollController(initialItem: 0);
    areaController = FixedExtentScrollController(initialItem: 0);
    _resetControllerOnce = true;
  }

  void _initLocation(String locationCode) {
    Result dataResult = widget.initDataResult;

    if (dataResult != null && dataResult.provinceName != null) {
      {
        CityPoint point = provinceCityAreaList.firstWhere(
            (province) => dataResult.provinceName == province.label,
            orElse: () => null);

        if (point != null) {
          targetProvince = point;
        } else {
          targetProvince = provinceCityAreaList[0];
        }
      }

      {
        CityPoint point = targetProvince.children.firstWhere(
            (city) => dataResult.cityName == city.label,
            orElse: () => null);

        if (point != null) {
          targetCity = point;
        } else {
          targetCity = targetProvince.children[0];
        }
      }
      {
        CityPoint point = targetCity.children.firstWhere(
            (area) => dataResult.areaName == area.label,
            orElse: () => null);

        if (point != null) {
          targetArea = point;
        } else {
          targetArea = targetCity.children[0];
        }
      }
    } else {
      targetProvince = provinceCityAreaList[0];
      targetCity = targetProvince.children[0];
      targetArea = targetCity.children[0];
    }
  }

  // 通过选中的省份, 构建以省份为根节点的树型结构
  List<String> getCityItemList() {
    List<String> result = [];
    if (targetProvince != null) {
      result.addAll(targetProvince.children.map((p) => p.label).toList());
    }
    return result;
  }

  List<String> getAreaItemList() {
    List<String> result = [];

    if (targetCity != null) {
      result.addAll(targetCity.children.map((p) => p.label).toList());
    }
    return result;
  }

  // province change handle
  // 加入延时处理, 减少构建树的消耗
  _onProvinceChange(CityPoint _province) {
    if (_changeTimer != null && _changeTimer.isActive) {
      _changeTimer.cancel();
    }
    _changeTimer = Timer(Duration(milliseconds: 500), () {
//      Point _provinceTree =
//          cityTree.initTree(int.parse(_province.code.toString()));
      setState(() {
        targetProvince = _province;
        targetCity = targetProvince.children[0];
        targetArea = targetCity.children[0];
        _resetController();
      });
    });
  }

  _onCityChange(CityPoint _targetCity) {
    if (_changeTimer != null && _changeTimer.isActive) {
      _changeTimer.cancel();
    }
    _changeTimer = Timer(Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() {
        targetCity = _targetCity;
        targetArea = targetCity.children[0];
      });
    });
    _resetController();
  }

  _onAreaChange(CityPoint _targetArea) {
    if (_changeTimer != null && _changeTimer.isActive) {
      _changeTimer.cancel();
    }
    _changeTimer = Timer(Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() {
        targetArea = _targetArea;
      });
    });
  }

  Result _buildResult() {
    Result result = Result();
    ShowType showType = widget.showType;
    if (showType.contain(ShowType.p)) {
      result.provinceId = targetProvince.value.toString();
      result.provinceName = targetProvince.label;
    }
    if (showType.contain(ShowType.c)) {
      result.provinceId = targetProvince.value.toString();
      result.provinceName = targetProvince.label;
      result.cityId = targetCity != null ? targetCity.value.toString() : null;
      result.cityName = targetCity != null ? targetCity.label : null;
    }
    if (showType.contain(ShowType.a)) {
      result.provinceId = targetProvince.value.toString();
      result.provinceName = targetProvince.label;
      result.cityId = targetCity != null ? targetCity.value.toString() : null;
      result.cityName = targetCity != null ? targetCity.label : null;
      result.areaId = targetArea != null ? targetArea.value.toString() : null;
      result.areaName = targetArea != null ? targetArea.label : null;
    }
    // 台湾异常数据. 需要过滤
    if (result.provinceId == "710000") {
      result.cityId = null;
      result.cityName = null;
      result.areaId = null;
      result.areaName = null;
    }
    return result;
  }

  Widget _bottomBuild() {
    if (provinceCityAreaList == null) {
      return Container();
    }

    return Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '取消',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context, _buildResult());
                    },
                    child: Text(
                      '确定',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
            Row(
              children: <Widget>[
                _MyCityPicker(
                  key: Key('province'),
                  isShow: widget.showType.contain(ShowType.p),
                  height: widget.height,
                  controller: provinceController,
                  value: targetProvince.label,
                  itemList: provinceCityAreaList.map((v) => v.label).toList(),
                  changed: (index) {
                    _onProvinceChange(provinceCityAreaList[index]);
                  },
                ),
                _MyCityPicker(
                  key: Key('citys $targetProvince'),
                  // 这个属性是为了强制刷新
                  isShow: widget.showType.contain(ShowType.c),
                  controller: cityController,
                  height: widget.height,
                  value: targetCity == null ? null : targetCity.label,
                  itemList: getCityItemList(),
                  changed: (index) {
                    _onCityChange(targetProvince.children[index]);
                  },
                ),
                _MyCityPicker(
                  key: Key('towns $targetCity'),
                  isShow: widget.showType.contain(ShowType.a),
                  controller: areaController,
                  value: targetArea == null ? null : targetArea.label,
                  height: widget.height,
                  itemList: getAreaItemList(),
                  changed: (index) {
                    _onAreaChange(targetCity.children[index]);
                  },
                )
              ],
            )
          ],
        ));
  }

  Widget build(BuildContext context) {
    final route = InheritRouteWidget.of(context).router;
    return AnimatedBuilder(
      animation: route.animation,
      builder: (BuildContext context, Widget child) {
        return CustomSingleChildLayout(
          delegate: _WrapLayout(
              progress: route.animation.value, height: widget.height),
          child: GestureDetector(
            child: Material(
              color: Colors.transparent,
              child: Container(width: double.infinity, child: _bottomBuild()),
            ),
          ),
        );
      },
    );
  }
}

class _MyCityPicker extends StatefulWidget {
  final List<String> itemList;
  final Key key;
  final String value;
  final bool isShow;
  final FixedExtentScrollController controller;
  final ValueChanged<int> changed;
  final double height;

  _MyCityPicker(
      {this.key,
      this.controller,
      this.isShow = false,
      this.changed,
      this.height,
      this.itemList,
      this.value});

  @override
  State createState() {
    return _MyCityPickerState();
  }
}

class _MyCityPickerState extends State<_MyCityPicker> {
  List<Widget> children;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isShow) {
      return Container();
    }
    if (widget.itemList == null || widget.itemList.isEmpty) {
      return Expanded(
        child: Container(),
      );
    }
    return Expanded(
      child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(6.0),
          height: widget.height - 40,
          alignment: Alignment.center,
          child: CupertinoPicker.builder(
              magnification: 1.0,
              itemExtent: 40.0,
              backgroundColor: Colors.white,
              scrollController: widget.controller,
              onSelectedItemChanged: (index) {
                widget.changed(index);
              },
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    '${widget.itemList[index]}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                );
              },
              childCount: widget.itemList.length)),
      flex: 1,
    );
  }
}

class _WrapLayout extends SingleChildLayoutDelegate {
  _WrapLayout({
    this.progress,
    this.height,
  });

  final double progress;
  final double height;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = height;

    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double height = size.height - childSize.height * progress;
    return Offset(0.0, height);
  }

  @override
  bool shouldRelayout(_WrapLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
