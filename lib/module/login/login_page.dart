import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:wuhan/base/lcfarm_widget.dart';
import 'package:wuhan/base/navigator_manager.dart';
import 'package:wuhan/base/router.dart';
import 'package:wuhan/module/home/home.dart';
import 'package:wuhan/utils/lcfarm_util.dart';
import 'package:wuhan/utils/shared_preferences_utils.dart';

import '../../config.dart';
import 'login_contract.dart';




class LoginPageMain extends LcfarmWidget {
  ///路由
  static const String router = Router.login;

  LoginPageMain({Object arguments}) : super(arguments: arguments, routerName: router);

  @override
  LcfarmWidgetState getState() {
    return LoginPageMainState();
  }
}



//class LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
class LoginPageMainState  extends LcfarmWidgetState<Presenter, LoginPageMain> implements View {
  final int delayedAmount = 100;
  final TapGestureRecognizer recognizer = TapGestureRecognizer();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _codeController = new TextEditingController();




  //是否发送了验证码
  bool sendCode = false;
  Timer _timer;
  int _countdownTime = 0;


  //当前屏幕设备高度，屏幕适配用
  double currentDeviceHeight = 0.0;
  double bottomTextHeight = 50;


  void startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);
    var callback = (timer) => {
      setState(() {
        if (_countdownTime < 1) {
          _timer.cancel();
          sendCode = false;
        } else {
          _countdownTime = _countdownTime - 1;
        }
      })
    };

    _timer = Timer.periodic(oneSec, callback);
  }





  @override
  void dispose() {

    _phoneController.dispose();
    _codeController.dispose();

    super.dispose();

  }

  void getLoginInfo() async{


    String userInfo =  await SharedPreferencesUtils.get(Config.USER_LOGIN_INFO);

    if(userInfo != null && userInfo.trim().length == 11){
      Navigator.pushReplacementNamed(context, Home.router);
  //    NavigatorManager().pushReplacementNamed(context,LoginPageMain.router);

    }




  }

  @override
  void initState() {

    //getLoginInfo();
    super.initState();

    hiddenAppbar();

    recognizer.onTap = () {

      showToast(
        "服务协议",
        duration: Duration(seconds: 2),
        position: ToastPosition.top,
        backgroundColor: Color(0xff4d4d4d),
        radius: 5.0,
        textPadding: EdgeInsets.only(top: 5,bottom: 5,right: 5,left: 5),
        textStyle: TextStyle(fontSize: 15.0),
      );
    };

  }







  @override
  Widget buildWidget(BuildContext context) {




    MediaQueryData mediaQuery = MediaQuery.of(context);
    currentDeviceHeight = mediaQuery.size.height;



    //发送短信验证码
    sendSMSCode(){



      if(_phoneController.text.trim() == "" ){


        LcfarmUtil.makeToast('请输入手机号');


        return;

      }



      if(_phoneController.text.trim().length != 11 ){
        LcfarmUtil.makeToast('请输入正确的手机号码');


        return;

      }

      //Http请求发送验证码
      _countdownTime = Config.COUNTDOWN_TIME;
      sendCode = true;
      //开始倒计时
      startCountdownTimer();
      setState(() {
      });

      LcfarmUtil.makeToast('验证短信已发出，请注意查收');




    }


    void loginSuccess(){
      SharedPreferencesUtils.save(Config.USER_LOGIN_INFO, _phoneController.text);
      Navigator.pushReplacementNamed(context, Home.router);

    }




    //登录
    void login(){
      if(_phoneController.text.trim().length != 11 ){
        LcfarmUtil.makeToast('请输入正确的手机号码');


        return;

      }


      if(_codeController.text.trim().length != 4){
        LcfarmUtil.makeToast('请输入正确的验证码');


        return;

      }


      if(Config.DEBUG && _codeController.text == "1234") {
        loginSuccess();
        return;
      }







    }




     return  Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Container(
              height:  currentDeviceHeight - bottomTextHeight,
              child: Column(
                children: <Widget>[

                  Container(
                    height: 150,
                    margin: EdgeInsets.only(left: 20),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 75,
                          height: 75,
                          child: Image.asset("images/logo.jpeg",fit: BoxFit.fill,),
                        ),

                        Container(
                          height: 75,
                          alignment:Alignment.center,
                          margin: EdgeInsets.only(left: 10),
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("共克时艰",style: TextStyle(fontSize: 17),),
                              Text("你我同行",style: TextStyle(fontSize: 17),),
                            ],
                          )
                          ,
                        ),
                      ],
                    ),
                  ),



                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20,right: 20,),


                    height: 50,
                    child: Theme(

                      data: ThemeData(
                        splashColor: Colors.transparent,
                        textTheme: TextTheme(subhead: TextStyle(textBaseline: TextBaseline.alphabetic)),


                      ),
                      child: TextField(
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(11)],
                        controller: _phoneController,
                        textAlign: TextAlign.left,
                        cursorColor: Color(0x08a82f),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "请输入手机号",
                          hintStyle: TextStyle(
                            fontSize: 17.0,
                            color: Colors.grey.withOpacity(0.5),
                            fontFamily: "Roboto",
                            //    color: darkText.withOpacity(darkText.opacity * 0.5)
                          ),

                          border: InputBorder.none,
                        ),


                        style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: "Roboto",
                          //   color: darkText.withOpacity(darkText.opacity),
                        ),



                      ),
                    ),
                  ),


                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 1,
                    color: Colors.grey,
                  ),


                  Row(
                    children: <Widget>[

                      Expanded(
                        child:
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 20,right: 20,),

                          height: 50,
                          child: Theme(

                            data: ThemeData(
                              //  primaryColor: darkText.withOpacity(darkText.opacity * 0.5),
                              splashColor: Colors.transparent,
                              textTheme: TextTheme(subhead: TextStyle(textBaseline: TextBaseline.alphabetic)),

                            ),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: _codeController,
                              textAlign: TextAlign.left,
                              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(4)],
                              cursorColor: Color(0x08a82f),
                              decoration: InputDecoration(
                                hintText: "请输入验证码",
                                hintStyle: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.grey.withOpacity(0.5),
                                  fontFamily: "Roboto",
                                  //    color: darkText.withOpacity(darkText.opacity * 0.5)
                                ),

                                border: InputBorder.none,
                              ),


                              style: TextStyle(
                                fontSize: 17.0,
                                fontFamily: "Roboto",
                                //   color: darkText.withOpacity(darkText.opacity),
                              ),



                            ),
                          ),
                        ),
                        flex: 2,
                      ),


                      Expanded(
                        child:GestureDetector(
                          child:      Container(
                            alignment: Alignment.centerRight,
                            child: sendCode?
                            //  Text(_countdownTime.toString()+"s重新获取", style: TextStyle(color: Color(0xffB8C1D3),fontSize: 16),)

                            RichText(
                              text: TextSpan(children: [

                                TextSpan(
                                  text: "重新获取 ",
                                  style: TextStyle(color: Color(0xffB8C1D3),fontSize: 16),
                                ),


                                TextSpan(
                                  text: _countdownTime.toString() + " ",
                                  style: TextStyle(color: Color(0xffa8d8ce),fontSize: 16),
                                ),



                              ]
                              ),
                            )



                                :Text("获取验证码",
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.grey.withOpacity(0.5),
                                fontFamily: "Roboto",
                                //    color: darkText.withOpacity(darkText.opacity * 0.5)
                              ),


                            ),
                            margin: EdgeInsets.only(right: 20),
                          ),

                          onTap: (){

                            if(!sendCode){

                              sendSMSCode();

                            }



                          },
                        ),







                        flex: 1,
                      ),


                    ],
                  ),


                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 1,
                    color: Colors.grey,
                  ),


                  Container(
                    margin: EdgeInsets.only(top: 10,right: 20),
                    alignment: Alignment.centerRight,
                    child: Text("收不到验证码？",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                        fontFamily: "Roboto",
                        //    color: darkText.withOpacity(darkText.opacity * 0.5)
                      ),
                    ),
                  ),



                  SizedBox(height: 50,),
                  GestureDetector(
                    child:
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 20,right: 20),
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xffabaabc),
                          borderRadius: BorderRadius.all(new Radius.circular(10))
                      ),

                      child: Text("登录",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          //    color: darkText.withOpacity(darkText.opacity * 0.5)
                        ),
                      ),

                    ),
                    onTap: (){
                      login();

                    },
                  ),




                  Container(
                    margin: EdgeInsets.only(top: 10,),
                    alignment: Alignment.center,
                    child: Text("未注册手机号码验证后自动注册",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                        fontFamily: "Roboto",
                        //    color: darkText.withOpacity(darkText.opacity * 0.5)
                      ),
                    ),
                  ),




                  Config.USE_THIRDPARD_LOGIN?Column(
                    children: <Widget>[

                      SizedBox(height: 100,),

                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 1,
                              margin: EdgeInsets.only(left: 20),
                              color: Colors.grey,
                            ),
                            flex: 1,
                          ),

                          Expanded(
                            child: Container(
                              child: Text("第三方账号登录"
                              ),
                              alignment: Alignment.center,
                            ),
                            flex: 1,
                          ),

                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              height: 1,
                              color: Colors.grey,
                            ),
                            flex: 1,
                          ),
                        ],
                      ),



                      SizedBox(
                        height: 20,
                      ),

                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(right: 20),
                              child:InkWell(
                                child:     Container(
                                  width: 60,
                                  height: 60,
                                  child: Image.asset("images/wechat_icon.png"),
                                ),
                                onTap: (){

                                  showToast(
                                    "微信登录",
                                    duration: Duration(seconds: 2),
                                    position: ToastPosition.top,
                                    backgroundColor: Color(0xff4d4d4d),
                                    radius: 5.0,
                                    textPadding: EdgeInsets.only(top: 5,bottom: 5,right: 5,left: 5),
                                    textStyle: TextStyle(fontSize: 15.0),
                                  );
                                },
                              ),

                            ),
                            flex: 1,
                          ),


                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 20),
                              child:InkWell(
                                child:  Container(
                                  width: 60,
                                  height: 60,
                                  child: Image.asset("images/qq_icon.png"),
                                ),
                                onTap: (){

                                  showToast(
                                    "qq 登录",
                                    duration: Duration(seconds: 2),
                                    position: ToastPosition.top,
                                    backgroundColor: Color(0xff4d4d4d),
                                    radius: 5.0,
                                    textPadding: EdgeInsets.only(top: 5,bottom: 5,right: 5,left: 5),
                                    textStyle: TextStyle(fontSize: 15.0),
                                  );

                                },
                              ),
                            ),
                            flex: 1,
                          ),


                        ],
                      ),



                    ],
                  )
                      :Container(),





                ],
              ),
            ),







            Container(
              height: bottomTextHeight,
              alignment: Alignment.center,
              child:           RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "登录代表你已同意 ",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                      fontFamily: "Roboto",
                      //    color: darkText.withOpacity(darkText.opacity * 0.5)
                    ),
                  ),


                  TextSpan(
                      text: "用户服务协议、隐私保护政策",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: "Roboto",
                        color: Color(0xff666666),
                        //    color: darkText.withOpacity(darkText.opacity * 0.5)
                      ),
                      recognizer: recognizer
                  )


                ]
                ),
              ),
            ),








          ],
        )


    );



  }

  @override
  void onKeycodeBack() {
    LcfarmUtil.exitApp();
  }


  @override
  Presenter createPresenter() {
    // TODO: implement createPresenter
    return null;
  }

  @override
  void queryData() {
    disabledLoading();
  }







}
