import 'dart:async';

import 'package:city_pickers/modal/city_point.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../modal/result.dart';
import 'base/base2.dart';
import 'mod/picker_popup_route.dart';
import 'show_types.dart';

/// ios city pickers
/// provide config height, initLocation and so on
///
/// Sample:flutter format
/// ```
/// await CityPicker.showPicker(
///   location: String,
///   height: double
/// );
///
/// ```

class CityPickers {
  static Future<Result> showCityPicker2({
    @required BuildContext context,
    showType = ShowType.pca,
    double height = 400.0,
    String locationCode = '110000',
    Result initDataResult,
    ThemeData theme,
    List<CityPoint> provinceCityAreaList,
    // CityPickerRoute params
    bool barrierDismissible = true,
    double barrierOpacity = 0.5,
  }) {
    return Navigator.of(context, rootNavigator: true).push(
      CityPickerRoute(
          theme: theme ?? Theme.of(context),
          canBarrierDismiss: barrierDismissible,
          barrierOpacity: barrierOpacity,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          child: Base2View(
            showType: showType,
            height: height,
            provinceCityAreaList: provinceCityAreaList,
            locationCode: locationCode,
            initDataResult: initDataResult,
          )),
    );
  }
}
