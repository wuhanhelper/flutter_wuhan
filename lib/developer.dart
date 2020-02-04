import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:flutter_common_utils/log_util.dart';
import 'package:flutter_common_utils/sp_util.dart';
import 'package:flutter_common_utils/storage_util.dart';
import 'package:flutter_mvp/presenter/i_presenter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wuhan/using_proxy.dart';
import 'package:wuhan/utils/lcfarm_color.dart';
import 'package:wuhan/utils/lcfarm_util.dart';
import 'package:wuhan/widget/lcfarm_large_button.dart';
import 'package:wuhan/widget/lcfarm_simple_input.dart';

import 'base/api.dart';
import 'base/build_config.dart';
import 'base/lcfarm_widget.dart';
import 'base/navigator_manager.dart';
import 'base/router.dart';
import 'developerSDK.dart';
import 'flutter_text_example.dart';

/// @desc 开发者模式
/// @time 2019-06-11 15:40
/// @author chenyunThe pubspec.yaml file has been modified since the last time 'flutter packages get' was run.

class Developer extends LcfarmWidget {
  static const String router = Router.scheme + "developer";

  Developer({Object arguments})
      : super(arguments: arguments, routerName: router);

  @override
  LcfarmWidgetState getState() {
    return _DeveloperState();
  }
}

class _DeveloperState extends LcfarmWidgetState<IPresenter, Developer> {
  TextEditingController _serverController = TextEditingController();
  TextEditingController _serverMpController = TextEditingController();

  TextEditingController _proxyAddressController = TextEditingController();

  TextEditingController _proxyPortController = TextEditingController();

  TextEditingController _h5Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    setAppbar(title: "开发者模式");

    _serverController.text =
        SpUtil().getString("serverAddress") ?? Api.getBaseUrl();

    _proxyAddressController.text =
        SpUtil().getString("proxyAddress") ?? localProxyIPAddress;

    _proxyPortController.text =
        SpUtil().getString("proxyPort") ?? "$localProxyPort";

    _h5Controller.text =
        "http://172.20.0.39:8080/#/jsbridgeTestPage"; //"http://10.1.60.25:8004/test.html";//
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      color: LcfarmColor.colorFFFFFF,
      padding: EdgeInsets.symmetric(horizontal: LcfarmSize.dp(30)),
      child: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: LcfarmSize.dp(30))),
          LcfarmSimpleInput(
            controller: _serverController,
            label: "服务器地址",
            hint: "服务器地址",
          ),
          LcfarmSimpleInput(
            controller: _proxyAddressController,
            label: "代理地址",
            hint: "",
          ),
          LcfarmSimpleInput(
            controller: _proxyPortController,
            label: "代理端口",
            hint: "",
          ),
          Padding(padding: EdgeInsets.only(top: LcfarmSize.dp(30))),
          LcfarmLargeButton(
            label: "确定并重启",
            onPressed: () async {
              await SpUtil().putString("serverAddress", _serverController.text);
              await SpUtil()
                  .putString("serverAddressMp", _serverMpController.text);
              await SpUtil()
                  .putString("proxyAddress", _proxyAddressController.text);
              await SpUtil().putString("proxyPort", _proxyPortController.text);
              LcfarmUtil.exitApp();
            },
          ),
          Padding(padding: EdgeInsets.only(top: LcfarmSize.dp(10))),
          LcfarmLargeButton(
            label: "SDK",
            onPressed: () async {
              NavigatorManager().pushNamed(context, DeveloperSDK.router);

//            Future<String> tipFuture=LcfarmUtil.showTipDialog(context, "测试");
            },
          ),
          Padding(padding: EdgeInsets.only(top: LcfarmSize.dp(10))),
          LcfarmLargeButton(
            label: "文本内部间距",
            onPressed: () async {
              Navigator.pushNamed(context, FlutterTextExample.router);
            },
          ),
          Padding(padding: EdgeInsets.only(top: LcfarmSize.dp(10))),
          LcfarmLargeButton(
            label: "测试",
            onPressed: () async {
//              Navigator.popAndPushNamed(context, Login.router);
              String tempPath = await StorageUtil.getTempPath(
                  fileName: 'demo.png', dirName: 'image');
              LogUtil.v("temp path=$tempPath");
              String docPath = await StorageUtil.getAppDocPath(
                  fileName: 'demo.mp4', dirName: 'video');
              LogUtil.v("app doc path=$docPath");
              if (BuildConfig.isAndroid) {
                String storagePath = await StorageUtil.getStoragePath(
                    fileName: 'demo.apk', dirName: 'apk');
                LogUtil.v("storage doc path=$storagePath");
              }
            },
          ),
          Padding(padding: EdgeInsets.only(top: LcfarmSize.dp(10))),
          LcfarmLargeButton(
            label: "清除缓存",
            onPressed: () {
              _clearCache();
            },
          ),
          Padding(padding: EdgeInsets.only(top: LcfarmSize.dp(10))),
        ],
      ),
    );
  }

  void _clearCache() async {
    await SpUtil().clear();

    Directory tempDir = await getTemporaryDirectory();
    //删除缓存目录
    await delDir(tempDir);
    LcfarmUtil.makeToast('清除缓存成功');

    //退出
    LcfarmUtil.exitApp();
  }

  ///递归方式删除目录
  Future<Null> delDir(FileSystemEntity file) async {
    try {
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        for (final FileSystemEntity child in children) {
          await delDir(child);
        }
      }
      await file.delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  void queryData() {
    disabledLoading();
  }

  @override
  IPresenter createPresenter() {
    return null;
  }
}
