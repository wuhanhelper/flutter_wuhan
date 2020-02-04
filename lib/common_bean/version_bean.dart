import 'dart:convert' show json;

/// @desc 版本升级信息
/// @time 2019-05-27 10:12
/// @author chenyun
class VersionBean {
  int createTime;

  ///是否强升
  bool forceUpdate;

  ///是否显示升级弹窗
  bool needsUpdate;

  ///按钮文本
  String btnText;

  ///下载地址
  String downloadPage;

  ///升级内容文本
  String remark;
  String size;

  ///服务器版本
  String version;

  VersionBean.fromParams(
      {this.createTime,
      this.forceUpdate,
      this.needsUpdate,
      this.btnText,
      this.downloadPage,
      this.remark,
      this.size,
      this.version});

  factory VersionBean(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? VersionBean.fromJson(json.decode(jsonStr))
          : VersionBean.fromJson(jsonStr);

  VersionBean.fromJson(jsonRes) {
    createTime = jsonRes['createTime'];
    forceUpdate = jsonRes['forceUpdate'];
    needsUpdate = jsonRes['needsUpdate'];
    btnText = jsonRes['btnText'];
    downloadPage = jsonRes['downloadPage'];
    remark = jsonRes['remark'];
    size = jsonRes['size'];
    version = jsonRes['version'];
  }

  @override
  String toString() {
    return '{"createTime": $createTime,"forceUpdate": $forceUpdate,"needsUpdate": $needsUpdate,"btnText": ${btnText != null ? '${json.encode(btnText)}' : 'null'},"downloadPage": ${downloadPage != null ? '${json.encode(downloadPage)}' : 'null'},"remark": ${remark != null ? '${json.encode(remark)}' : 'null'},"size": ${size != null ? '${json.encode(size)}' : 'null'},"version": ${version != null ? '${json.encode(version)}' : 'null'}}';
  }
}
