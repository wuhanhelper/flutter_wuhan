import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_common_utils/event_manager.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:flutter_common_utils/log_util.dart';
import 'package:flutter_mvp/presenter/i_presenter.dart';
import 'package:flutter_mvp/view/abstract_view.dart';
import 'package:lcfarm_flutter_umeng/lcfarm_flutter_umeng.dart';
import 'package:provider/provider.dart';
import 'package:wuhan/base/loader_notifier.dart';
import 'package:wuhan/base/router.dart';
import 'package:wuhan/utils/lcfarm_color.dart';
import 'package:wuhan/utils/lcfarm_icon.dart';
import 'package:wuhan/utils/lcfarm_style.dart';
import 'package:wuhan/utils/lcfarm_util.dart';
import 'package:wuhan/widget/lcfarm_appbar.dart';

import 'app_bar_notifier.dart';
import 'build_config.dart';
import 'const.dart';
import 'dialog_manager.dart';
import 'dialog_util.dart';
import 'event.dart';
import 'loader_container.dart';
import 'navigator_manager.dart';

/// @desc  基本widget
/// @time 2019/4/12 6:10 PM
/// @author chenyun
abstract class LcfarmWidget extends AbstractView {
  final Object arguments;

  final String routerName;

  LcfarmWidget({Key key, this.arguments, this.routerName});

  @override
  LcfarmWidgetState createState() => getState();

  ///子类实现
  LcfarmWidgetState getState();
}

abstract class LcfarmWidgetState<P extends IPresenter, V extends LcfarmWidget>
    extends AbstractViewState<P, V> with AutomaticKeepAliveClientMixin {
  ///是否为内页，相当于 androidFragment,不加入自定义栈管理
  bool _isInnerPager = false;

  ///主背景色
  Color _background = LcfarmColor.colorF7F8FA;

  ///是否包含导航栏
  bool _isAppbarShow = true;

  ///是否显示左边按钮
  bool _isAppbarBackShow = true;

  ///是否标题下划线
  bool _isUnderlineShapeShow = false;

  ///标题栏
  String _appBarTitle = '';

  Color _appBarTineColor = LcfarmColor.color80000000;

  Color _appBarBackground = LcfarmColor.colorFFFFFF;

  ///右边按钮
  Widget _trailingWidget;

  ///返回按钮
  Widget _leadingWidget;

  ///全局刷新
  StreamSubscription _refreshSubscription;

  ///加载状态
  LoaderNotifier _loaderNotifier;

  ///标题栏状态
  AppBarNotifier _appBarNotifier;

  ///提交框 id ,用于 pop 判断当前是否显示。为了解决在提交时报LOGIN_NOT_NORMAL
  String _submitDialogId;

  @override
  void initState() {
    super.initState();
    _appBarNotifier = AppBarNotifier();
    _loaderNotifier = LoaderNotifier();
    LogUtil.v("${getClassName()} lifecycle --> initState");
    if (!_isInnerPager) {
      NavigatorManager().addWidget(this);
    }
    _refreshSubscription = EventManager().on<RefreshEvent>().listen((event) {
      refreshData(from: event.from);
    });
    queryData();
  }

  //  @override
//  void setState(fn) {
//    assert(1 == 2);
//    super.setState(fn);
////    throw "禁止使用setState全局刷新，请使用Provider.";
//  }

  ///默认查询数据
  void queryData();

  ///loading状态
  LoaderType get loaderStatusType => _loaderNotifier.loaderType;

  @override
  bool get wantKeepAlive => _isInnerPager;

  @override
  Widget build(BuildContext context) {
    super.build(context); //保存状态必须加上
    LcfarmSize.getInstance().init(context);
//    LogUtil.v(
//        "ModalRoute.of(context).settings.name=${ModalRoute.of(context).settings.name}");
    //这个在顶层可以直接使用自动管理的构建方式绑定数据
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppBarNotifier>(builder: (_) => _appBarNotifier),
        ChangeNotifierProvider<LoaderNotifier>(builder: (_) => _loaderNotifier),
      ],
      child: buildWillPopScope(context),
    );
  }

  ///子类可重写
  Widget buildWillPopScope(BuildContext context) {
    //物理返回不重写。那里来回那里去。
    return BuildConfig.isAndroid && !_isInnerPager
        ? WillPopScope(
            child: buildScaffold(context),
            onWillPop: requestPop,
          )
        : buildScaffold(context);
  }

  ///子类可重写
  Widget buildScaffold(BuildContext context, {bool resizeToAvoidBottomInset}) {
    return Scaffold(
//      backgroundColor: Colors.transparent,

      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: _isAppbarShow ? buildAppBar() : null,
      body: buildBody(),
    );
  }

  ///默认返回，子类可重写是否拦截
  Future<bool> requestPop() async {
    LogUtil.v("requestPop===");
    onKeycodeBack();
    //物理返回不重写。那里来回那里去。
    return false;
  }

  ///物理返回，子类可重写
  void onKeycodeBack() {
    LogUtil.v("onKeycodeBack===");
    onBack();
  }

  ///默认返回，子类可重写
  void onBack() {
    NavigatorManager().pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    LogUtil.v("${getClassName()} lifecycle --> dispose");
    if (!_isInnerPager) {
      NavigatorManager().removeWidget(this);
    }
    _refreshSubscription.cancel();

    //页面返回时取消提示
//    LcfarmUtil.cancelToast();
  }

//   set innerPager(bool isInnerPager) => _isInnerPager = isInnerPager;

  ///是否为内页面
  void innerPager(bool isInnerPager) => _isInnerPager = isInnerPager;

  @override
  void onCreate() {
    super.onCreate();
    LogUtil.v("${getClassName()} lifecycle --> onCreate");
  }

  ///页面可见时调用，子类可重写
  @override
  void onResume() {
    super.onResume();
    LogUtil.v("${getClassName()} lifecycle --> onResume");

    LcfarmFlutterUmeng.beginLogPageView(Router.getName(getClassName()));
//    LcfarmFlutterUmeng.onResume();

    Future.delayed(Duration.zero, () {
      //显示弹窗
      if (mounted) DialogManager().show(context);
    });
  }

  ///页面不可见时调用，子类可重写
  @override
  void onPause() {
    super.onPause();
    LogUtil.v("${getClassName()} lifecycle --> onPause");

    LcfarmFlutterUmeng.endLogPageView(Router.getName(getClassName()));
//    LcfarmFlutterUmeng.onPause();
  }

  @override
  void onDestroy() {
    super.onDestroy();
    LogUtil.v("${getClassName()} lifecycle --> onDestroy");
  }

  ///从后台回到前吧，子类重写
  @override
  void onForeground() {
    super.onForeground();
    LogUtil.v("${getClassName()} lifecycle --> onForeground");
  }

  ///从前台压到后台，子类可重写
  @override
  void onBackground() {
    super.onBackground();
    LogUtil.v("${getClassName()} lifecycle --> onBackground");
  }

  ///取得当前类名
  String getClassName() {
    //在 release 模式下无法取得 context
    assert(widget.routerName != null);

    return widget.routerName;
  }

  ///取得当前的内页名,子类可重写
  String getInnerClassName() {
    return null;
  }

  @override
  void deactivate() {
    super.deactivate();
    LogUtil.v("${getClassName()} lifecycle --> deactivate");
  }

  @override
  void didPush() {
    super.didPush();
    LogUtil.v("${getClassName()} lifecycle --> didPush");
  }

  @override
  void didPopNext() {
    super.didPopNext();
    LogUtil.v("${getClassName()} lifecycle --> didPopNext");
  }

  @override
  void didPop() {
    super.didPop();
    LogUtil.v("${getClassName()} lifecycle --> didPopNext");
  }

  ///子类实现，构建各自页面UI控件 相当于setContentView()
  Widget buildWidget(BuildContext context);

  ///构建内容区，子类不用标题栏时，子类重写 build 方法，body调用buildBody。再重写 buildWidget.
  Widget buildBody(
      {Color backgroundColor, bool top = false, bool bottom = true}) {
    LogUtil.v("${getClassName()} lifecycle --> build");
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        //内容区背景颜色
        color: backgroundColor ?? getBackground,
        child: SafeArea(
          top: top,
          bottom: bottom,
          child: Consumer<LoaderNotifier>(
            builder: (context, loaderState, _) => LoaderContainer(
              contentView: loaderState.isLoadingSuccess()
                  ? buildWidget(context)
                  : Container(),
              onReload: onReload,
              loaderType: loaderState.loaderType,
              errorCode: loaderState.errorCode,
              errorMessage: loaderState.errorMessage,
              noDataImgPath: loaderState.noDataImgPath,
              noDataMessage: loaderState.noDataMessage,
              isAppbarShow: loaderState.isAppbarShow,
            ),
          ),
        ),
      ),
    );
  }

  ///重新加载
  void onReload() {
    //重新查询数据
    startLoading();
    queryData();
  }

  ///获取主背景色
  Color get getBackground => _background;

  ///设置主背景色
  set setBackground(Color value) {
    _background = value;
  }

  ///构建 App标题栏
  Widget buildAppBar(
      {Color backgroundColor, String title, bool isAppbarBackShow}) {
    _isAppbarBackShow = isAppbarBackShow ?? _isAppbarBackShow;
    return PreferredSize(
        //必须要包一层，不然会报错
        child: Consumer<AppBarNotifier>(
          builder: (context, appBarState, _) => LcfarmAppBar(
            backgroundColor: backgroundColor ?? _appBarBackground,
            underlineShape: _isUnderlineShapeShow,
            title: Text(title ?? _appBarTitle,
                style: LcfarmStyle.style000000_18.copyWith(
                    fontWeight: FontWeight.w400, color: _appBarTineColor)),
            navLeftAction: _isAppbarBackShow ? _buildBackWidget() : null,
            navRightAction: _trailingWidget,
          ),
        ),
        preferredSize: Size.fromHeight(LcfarmSize.dp(44)));
  }

  ///返回按钮
  Widget _buildBackWidget() {
    return _leadingWidget ??
        Builder(
          builder: (BuildContext context) {
            return IconButton(
              alignment: Alignment.centerLeft,
              icon: Icon(
                LcfarmIcon.icon_arrow_left,
                color: _appBarTineColor,
                size: LcfarmSize.dp(20),
              ),
              onPressed: () {
                onBack();
              },
            );
          },
        );
  }

  ///设置导航栏居中标题
  void setAppbar(
      {String title,
      Color appBarTineColor,
      Widget leadingWidget,
      Widget trailingWidget,
      bool hiddenBack,
      bool isUnderlineShape,
      Color appBarBackground}) {
    _isAppbarShow = true;
    if (title != null) {
      _appBarTitle = title;
    }
    if (leadingWidget != null) {
      _leadingWidget = leadingWidget;
    }
    if (trailingWidget != null) {
      _trailingWidget = trailingWidget;
    }
    if (hiddenBack != null) {
      _isAppbarBackShow = !hiddenBack;
    }
    if (isUnderlineShape != null) {
      _isUnderlineShapeShow = isUnderlineShape;
    }
    if (appBarTineColor != null) {
      _appBarTineColor = appBarTineColor;
    }
    if (appBarBackground != null) {
      _appBarBackground = appBarBackground;
    }
    _appBarNotifier.changeStatus();
  }

  ///设置导航栏居中标题
  void setTitle(String title) {
    _isAppbarShow = true;
    _appBarTitle = title;
    _appBarNotifier.changeStatus();
  }

  ///设置导航栏右边视图
  void setNavRightAction(Widget trailingWidget) {
    _isAppbarShow = true;
    _trailingWidget = trailingWidget;
    _appBarNotifier.changeStatus();
  }

  ///隐藏导航栏
  void hiddenAppbar() {
    _isAppbarShow = false;
    _appBarNotifier.changeStatus();
    _loaderNotifier.setAppbarState(false);
  }

  ///设置加载视图是否显示
  void disabledLoading() {
    _loaderNotifier.setLoaderType(type: LoaderType.Success);
  }

  ///开始加载
  @override
  void startLoading() {
    _loaderNotifier.setLoaderType(type: LoaderType.Loading);
  }

  ///加载成功,且更新状态，刷新数据
  @override
  void showLoadSuccess() {
    _loaderNotifier.setLoaderType(type: LoaderType.Success);
  }

  ///加载失败
  @override
  void showLoadFailure(String code, String message) {
    _loaderNotifier.setLoaderType(
      type: LoaderType.Failure,
      errorCode: code,
      errorMessage: message,
    );
  }

  @override
  void showEmptyData({String emptyImage, String emptyText}) {
    _loaderNotifier.setLoaderType(
      type: LoaderType.NoData,
      noDataMessage: emptyText,
      noDataImgPath: emptyImage,
    );
  }

  ///带参数的对话框
  @override
  void startSubmit({String message}) {
    //开始请求网络，显示提交框
    _submitDialogId = DialogUtil.generateId("createSubmitDialog");
    LcfarmUtil.showSubmitDialog(
      context,
      message: message,
      dialogId: _submitDialogId,
    );
  }

  ///隐藏对话框
  @override
  void showSubmitSuccess() {
    //成功回调,隐藏提交对话框
    DialogManager().popByDialogId(context, _submitDialogId);
  }

  ///显示提交失败 todo 假如在提交时，发生 LOGIN_NO_NORMAL 会打开登录页，这时 pop 会 pop掉登录页，而对话框不能消失
  @override
  void showSubmitFailure(String code, String message) {
    //隐藏提交对话框
    DialogManager().popByDialogId(context, _submitDialogId);
// FlutterToast 在 ios 提示有时很短,先做延迟,使用 OkToast 没问题
    LcfarmUtil.makeToast(message);
  }

  ///显示提交失败
  @override
  void showTips(String message) {
    LcfarmUtil.makeToast(message);
  }

  ///通知刷新
  void refreshData({String from}) {
    if (Const.fromLogin == from || Const.fromRegister == from) {
      //登录、注册显示加载动画。不然默默加载会显示上一个用户的数据
      startLoading();
    }
    queryData();
  }
}
