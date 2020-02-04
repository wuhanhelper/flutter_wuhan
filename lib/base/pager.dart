import 'dart:convert' show json;

//typedef JsonParse=Function(dynamic jsonStr);
typedef JsonParse = Function(dynamic jsonRes);

/// @desc  分页数据解析
/// @time 2019/4/11 4:00 PM
/// @author chenyun
class Pager<T> {
  int pageNo;
  int pageSize;
  int totalCount;
  List<T> list;

  Pager.fromParams({this.pageNo, this.pageSize, this.totalCount, this.list});

  factory Pager(jsonStr, JsonParse buildFun) => jsonStr == null
      ? null
      : jsonStr is String
          ? Pager.fromJson(json.decode(jsonStr), buildFun)
          : Pager.fromJson(jsonStr, buildFun);

  Pager.fromJson(jsonRes, [JsonParse buildFun]) {
    pageNo = jsonRes['pageNo'];
    pageSize = jsonRes['pageSize'];
    totalCount = jsonRes['totalCount'];
    list = jsonRes['list'] == null ? null : [];

    for (var listItem in list == null ? [] : jsonRes['list']) {
      if (buildFun != null) {
        list.add(listItem == null ? null : buildFun(listItem));
      }
    }
  }

  @override
  String toString() {
    return '{"pageNo": $pageNo,"pageSize": $pageSize,"totalCount": $totalCount,"list": $list}';
  }
}
