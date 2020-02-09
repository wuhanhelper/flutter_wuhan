import 'package:flutter/material.dart';
import 'package:flutter_common_utils/lcfarm_size.dart';
import 'package:flutter_common_utils/log_util.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wuhan/base/lcfarm_widget.dart';
import 'package:wuhan/base/router.dart';
import 'package:wuhan/module/home/detail/detail_need/need_detail_contract.dart';
import 'package:wuhan/module/home/detail/detail_need/need_detail_presenter.dart';
import 'package:wuhan/utils/lcfarm_color.dart';
import 'package:wuhan/utils/lcfarm_icon.dart';
import 'package:wuhan/utils/lcfarm_style.dart';
import 'package:wuhan/widget/easyrefresh/lcfarm_refresh_footer.dart';
import 'package:wuhan/widget/easyrefresh/lcfarm_refresh_header.dart';
import 'package:wuhan/widget/image_cache/net_cache_image.dart';
import 'package:wuhan/widget/swiper/strip_swiper_plugin.dart';

/// @desc 需求详情
/// @time 2020/02/09 14:26
/// @author lizubing1992
class NeedDetail extends LcfarmWidget {
  ///路由
  static const String router = Router.scheme + "need_detail";

  NeedDetail({Object arguments})
      : super(arguments: arguments, routerName: router);

  @override
  LcfarmWidgetState getState() {
    return _NeedDetailState();
  }
}

class _NeedDetailState extends LcfarmWidgetState<Presenter, NeedDetail>
    implements View {
  EasyRefreshController _controller = EasyRefreshController();

  List<String> imageAds = List();

  @override
  void initState() {
    super.initState();
    setTitle("需求详情");
  }

  @override
  Widget buildScaffold(BuildContext context, {bool resizeToAvoidBottomInset}) {
    return Scaffold(
      backgroundColor: LcfarmColor.colorFFFFFF, //把scaffold的背景色改成透
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: _buildButton(),
    );
  }

  Widget _buildButton() {
    return Container(
      padding: EdgeInsets.only(left: LcfarmSize.dp(15),right: LcfarmSize.dp(15)),
      child: Row(
        children: <Widget>[
          RaisedButton(
            elevation: 0,
            highlightElevation: 0,
            color: LcfarmColor.color3776E9,
            textColor: LcfarmColor.color3776E9,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(LcfarmSize.dp(4.0))),
            child: Text("转发", style: LcfarmStyle.styleFFFFFF_14),
            onPressed: () {},
          ),
          SizedBox(width: LcfarmSize.dp(15),),
          Expanded(
            child: RaisedButton(
              elevation: 0,
              highlightElevation: 0,
              color: LcfarmColor.color3776E9,
              textColor: LcfarmColor.color3776E9,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(LcfarmSize.dp(4.0))),
              child: Text("提供援助", style: LcfarmStyle.styleFFFFFF_14),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return EasyRefresh(
      enableControlFinishRefresh: true,
      enableControlFinishLoad: true,
      controller: _controller,
      header: LcfarmRefreshHeader(),
      footer: LcfarmLoadMoreFooter(),
      onRefresh: () async {
        queryData();
      },
      child: ListView(
        children: <Widget>[
          // banner
          _buildTopBanner(),

          _buildContent(),

          Divider(
            color: LcfarmColor.color333333,
            height: LcfarmSize.dp(1),
          ),

          _buildGoods(),
          Container(
            color: LcfarmColor.color999999_40,
            height: LcfarmSize.dp(26),
          ),
          _buildMsg(),
        ],
      ),
    );
  }

  Widget _buildMsg() {
    return Container(
        margin: EdgeInsets.only(
            left: LcfarmSize.dp(15),
            right: LcfarmSize.dp(15),
            top: LcfarmSize.dp(8),
            bottom: LcfarmSize.dp(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.phone),
                  Expanded(
                    child: Text("陈老师： 188123123123 \n"
                        "陈老师： 188123123123"),
                  ),
                  Icon(Icons.phone),
                ],
              ),
              margin: EdgeInsets.only(bottom: LcfarmSize.dp(15)),
            ),
            Divider(
              color: LcfarmColor.color333333,
              height: LcfarmSize.dp(1),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.add_location),
                  Expanded(
                    child: Text("武汉市咖啡壶卡斯比高考撒 "),
                  ),
                ],
              ),
              margin: EdgeInsets.only(
                  bottom: LcfarmSize.dp(15), top: LcfarmSize.dp(15)),
            ),
            Divider(
              color: LcfarmColor.color333333,
              height: LcfarmSize.dp(1),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.add_location),
                  Expanded(
                    child: Text("真实性认证 "),
                  ),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Text("5 ")
                ],
              ),
              margin: EdgeInsets.only(
                  bottom: LcfarmSize.dp(15), top: LcfarmSize.dp(15)),
            ),
            Divider(
              color: LcfarmColor.color333333,
              height: LcfarmSize.dp(1),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.ondemand_video),
                  Expanded(
                    child: Text("热心人认证 "),
                  ),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Text("5 ")
                ],
              ),
              margin: EdgeInsets.only(
                  bottom: LcfarmSize.dp(15), top: LcfarmSize.dp(15)),
            ),
            Divider(
              color: LcfarmColor.color333333,
              height: LcfarmSize.dp(1),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.add_location),
                  Expanded(
                    child: Text("信息来源 "),
                  ),
                  Text("个人来源 ")
                ],
              ),
              margin: EdgeInsets.only(
                  bottom: LcfarmSize.dp(15), top: LcfarmSize.dp(15)),
            ),
            Divider(
              color: LcfarmColor.color333333,
              height: LcfarmSize.dp(1),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.add_location),
                  Expanded(
                    child: Text("类型 "),
                  ),
                  Text("个人 ")
                ],
              ),
              margin: EdgeInsets.only(
                  bottom: LcfarmSize.dp(15), top: LcfarmSize.dp(15)),
            ),
          ],
        ));
  }

  Widget _buildGoods() {
    return Container(
      padding: EdgeInsets.only(
          left: LcfarmSize.dp(15),
          top: LcfarmSize.dp(15),
          bottom: LcfarmSize.dp(10),
          right: LcfarmSize.dp(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "紧缺物资",
            style: LcfarmStyle.style000000_18,
          ),
          Container(
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: 5,
                //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //横轴元素个数
                  crossAxisCount: 3,
                  //纵轴间距
                  mainAxisSpacing: 0,
                  //横轴间距
                  crossAxisSpacing: 0,
                  //子组件宽高长度比例
                  childAspectRatio: 3.2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Text("医用外科口罩");
                }),
          ),
        ],
      ),
    );
  }

  ///中间的内容
  Widget _buildContent() {
    return Container(
      margin: EdgeInsets.only(
          left: LcfarmSize.dp(15),
          top: LcfarmSize.dp(8),
          right: LcfarmSize.dp(15),
          bottom: LcfarmSize.dp(8)),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                LcfarmIcon.icon_account_normal,
                size: LcfarmSize.dp(25),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "武汉协和医院",
                  ),
                  Text("2020-02-02 14:30:30")
                ],
              )),
              Text("个人发布"),
            ],
          ),
          Text("agahgkahgkhasklghaklhgkashgklashdgkahdglkjhasdglhasdghshfsklgh"
              "skhgkshgflshgskhgfshgfkshgskhgfkshgkshgkshgslhgshgkhadklhgsadhga"
              "sdhfkalshdkashgkahs"),
          InkWell(
            onTap: () {
              //展开事件
              LogUtil.v("点击事假");
            },
            child: Container(
              child: Text("展开全部"),
              padding: EdgeInsets.only(
                  top: LcfarmSize.dp(8), bottom: LcfarmSize.dp(8)),
            ),
          ),
        ],
      ),
    );
  }

  ///顶部banner
  Widget _buildTopBanner() {
    return Container(
      height: LcfarmSize.dp(183.0),
      width: double.infinity,
      child: Swiper(
        itemCount: imageAds.length,
        scrollDirection: Axis.horizontal,
        autoplay: imageAds.length > 1,
        loop: imageAds.length > 1,
        itemBuilder: (BuildContext context, int index) {
          return _bannerCell(imageAds[index]);
        },
        pagination: SwiperPagination(
            margin: EdgeInsets.all(LcfarmSize.dp(6)),
            builder: StripPaginationBuilder(
                width: LcfarmSize.dp(8),
                height: LcfarmSize.dp(2),
                space: LcfarmSize.dp(2),
                color: LcfarmColor.colorDBDBDB,
                activeColor: LcfarmColor.color1D77FA),
            alignment: Alignment.bottomCenter),
      ),
    );
  }

  Widget _bannerCell(String imgUrl) {
    return Container(
        margin: EdgeInsets.all(LcfarmSize.dp(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(LcfarmSize.dp(4.0)),
          child: NetCacheImage(
            imageUrl: imgUrl,
            fit: BoxFit.fill,
            placeholderWidget: Image.asset("images/placeholder_335_143.png"),
            errorWidget: Image.asset("images/placeholder_335_143.png"),
          ),
        ));
  }

  @override
  void queryData() {
    imageAds.add("");
    imageAds.add("");
    imageAds.add("");
    showLoadSuccess();
  }

  @override
  Presenter createPresenter() {
    return NeedDetailPresenter();
  }
}
