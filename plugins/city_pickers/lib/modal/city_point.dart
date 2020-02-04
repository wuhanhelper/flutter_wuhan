/// @desc:
/// @time 2019-05-29 16:31
/// @author mrliuys
import 'dart:convert' show json;

class CityPoint {
  String label = "";
  String value = "";
  List<CityPoint> children;

  CityPoint.fromParams({this.label, this.value, this.children});

  factory CityPoint(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? CityPoint.fromJson(json.decode(jsonStr))
          : CityPoint.fromJson(jsonStr);

  CityPoint.fromJson(jsonRes) {
    label = jsonRes['label'];
    value = jsonRes['value'];
    children = jsonRes['children'] == null ? null : [];

    for (var childrenItem in children == null ? [] : jsonRes['children']) {
      children
          .add(childrenItem == null ? null : CityPoint.fromJson(childrenItem));
    }
  }

  @override
  String toString() {
    return '{"label": ${label != null ? '${json.encode(label)}' : 'null'},"value": ${value != null ? '${json.encode(value)}' : 'null'},"children": $children}';
  }
}
