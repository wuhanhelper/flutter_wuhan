import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_common_utils/http/http_error.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:flutter_common_utils/log_util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wuhan/utils/lcfarm_color.dart';
import 'package:wuhan/utils/lcfarm_style.dart';
import 'package:wuhan/widget/lcfarm_loading.dart';

///加载态
enum LoaderType { Loading, Success, Failure, NoData }

///点击刷新回调
typedef OnReload = Function();

/// @desc 加载视图组件
/// @time 2019-07-23 11:20
/// @author chenyun
class LoaderContainer extends StatelessWidget {
  ///加载状态
  final LoaderType loaderType;

  ///加载中视图
  final Widget loadingView;

  ///错误视图
  final Widget errorView;

  ///错误编码
  final String errorCode;

  ///错误消息
  final String errorMessage;

  ///重新刷新
  final OnReload onReload;

  ///空白视图
  final Widget emptyView;

  ///自定义空白视图图片及文本
  final String noDataImgPath;
  final String noDataMessage;

  ///内容视图
  final Widget contentView;

  ///是否显示导航栏，为了设置错误跟空白视图距上面的间距
  final bool isAppbarShow;

  LoaderContainer({
    Key key,
    this.loaderType = LoaderType.Loading,
    this.loadingView,
    this.errorView,
    this.errorCode,
    this.errorMessage,
    @required this.onReload,
    this.emptyView,
    this.noDataImgPath,
    this.noDataMessage,
    @required this.contentView,
    this.isAppbarShow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget currentWidget;
    switch (loaderType) {
      case LoaderType.Loading:
        currentWidget = loadingView ?? _ClassicsLoadingView();
        break;
      case LoaderType.Success:
        currentWidget = contentView;
        break;
      case LoaderType.Failure:
        currentWidget = errorView ??
            _ClassicsErrorView(errorCode, errorMessage, isAppbarShow, onReload);
        break;
      case LoaderType.NoData:
        currentWidget = emptyView ??
            _ClassicsEmptyView(noDataImgPath, noDataMessage, isAppbarShow);
        break;
    }
    return currentWidget;
  }
}

///默认加载视图
class _ClassicsLoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: LcfarmColor.colorFFFFFF,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LcfarmLoading(),
//              Container(
//                width: LcfarmSize.dp(40),
//                height: LcfarmSize.dp(40),
//                child: CircularProgressIndicator(
//                  strokeWidth: LcfarmSize.dp(2),
//                  valueColor:
//                      AlwaysStoppedAnimation<Color>(LcfarmColor.color3776E9),
//                ),
//              ),
            Padding(padding: EdgeInsets.only(top: LcfarmSize.dp(10))),
            Text(
              '正在加载...',
              style: LcfarmStyle.style60000000_16,
            ),
          ],
        ),
      ),
    );
  }
}

///默认错误视图
class _ClassicsErrorView extends StatelessWidget {
  ///错误编码
  final String errorCode;

  ///错误消息
  final String errorMessage;

  ///是否显示导航栏，为了设置错误跟空白视图距上面的间距
  final bool isAppbarShow;

  ///重新刷新
  final OnReload onReload;

  _ClassicsErrorView(
      this.errorCode, this.errorMessage, this.isAppbarShow, this.onReload);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LcfarmColor.colorFFFFFF,
      child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                  top: LcfarmSize.dp(isAppbarShow ? 120 : 184))),
          Image.asset(
            errorCode == HttpError.NETWORK_ERROR
                ? 'images/base/icon_network_error.png'
                : "images/base/icon_server_error.png",
            width: LcfarmSize.dp(200),
          ),
          Padding(padding: EdgeInsets.only(top: LcfarmSize.dp(8))),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: LcfarmSize.dp(30)),
            child: Text(
              errorMessage ?? '网络异常，请稍后重试！',
              softWrap: true,
              style: LcfarmStyle.style24000000_16,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: LcfarmSize.dp(16))),
          SizedBox(
            width: LcfarmSize.dp(108),
            height: LcfarmSize.dp(32),
            child: OutlineButton(
              onPressed: () {
                //重新查询数据
//                startLoading();
//                queryData();
                if (onReload != null) {
                  onReload();
                }
              },
              shape: StadiumBorder(
                side: BorderSide(
                  width: LcfarmSize.dp(0.5),
                  color: LcfarmColor.color40000000,
                ),
              ),
              child: Text(
                '点击刷新',
                style: LcfarmStyle.style40000000_14,
              ),
            ),
          ),
          Expanded(child: Container()),
          RichText(
            text: TextSpan(
              text: '还没有恢复? ',
              style: LcfarmStyle.style24000000_14,
              children: <TextSpan>[
                TextSpan(
                    text: '点击此处',
                    style: LcfarmStyle.style40000000_14.copyWith(
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        LogUtil.v('联系客服');
                        String tel = "tel:400-00000-500";
                        if (await canLaunch(tel)) {
                          await launch(tel);
                        }
                      }),
                TextSpan(
                  text: '为您提供帮助服务',
                  style: LcfarmStyle.style24000000_14,
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: LcfarmSize.dp(24))),
        ],
      ),
    );
  }
}

class _ClassicsEmptyView extends StatelessWidget {
  ///自定义空白视图图片及文本
  final String noDataImgPath;
  final String noDataMessage;

  ///是否显示导航栏，为了设置错误跟空白视图距上面的间距
  final bool isAppbarShow;

  _ClassicsEmptyView(this.noDataImgPath, this.noDataMessage, this.isAppbarShow);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: LcfarmColor.colorFFFFFF,
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                  top: LcfarmSize.dp(isAppbarShow ? 120 : 184))),
          Image.asset(
            noDataImgPath ?? 'images/base/icon_no_data.png',
            width: LcfarmSize.dp(200),
          ),
          Padding(padding: EdgeInsets.only(top: LcfarmSize.dp(8))),
          Text(
            noDataMessage ?? '暂无相关记录',
            style: LcfarmStyle.style24000000_16,
          ),
        ],
      ),
    );
  }
}
