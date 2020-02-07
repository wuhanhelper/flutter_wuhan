import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wuhan/base/router.dart';

class LoginPageMain extends StatefulWidget{
  static const String router = Router.login;

  @override
  State<StatefulWidget> createState() {
    return LoginPageMainState();
  }
}


//class LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
class LoginPageMainState extends State<LoginPageMain>{
  final int delayedAmount = 100;



  @override
  void initState() {

    super.initState();

  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ListView(
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
//                    decoration: BoxDecoration(
//                      color: FintnessAppTheme.white,
//                      borderRadius: BorderRadius.only(
//                          topLeft: Radius.circular(1.0),
//                          bottomLeft: Radius.circular(1.0),
//                          bottomRight: Radius.circular(1.0),
//                          topRight: Radius.circular(1.0)),
//                      boxShadow: <BoxShadow>[
//                        BoxShadow(
//                            color: FintnessAppTheme.grey.withOpacity(0.2),
//                            offset: Offset(1.1, 1.1),
//                            blurRadius: 10.0),
//                      ],
//                    ),
//


              height: 50,
              child: Theme(

                data: ThemeData(
                  //  primaryColor: darkText.withOpacity(darkText.opacity * 0.5),
                  splashColor: Colors.transparent,
                ),
                child: TextField(
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      hintText: "请输入手机号",
                      hintStyle: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey.withOpacity(0.5),
                        fontFamily: "Roboto",
                        //    color: darkText.withOpacity(darkText.opacity * 0.5)
                      ),

                      border: InputBorder.none,
                  ),


                  style: TextStyle(
                    fontSize: 18.0,
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
                      ),
                      child: TextField(
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: "请输入验证码",
                          hintStyle: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey.withOpacity(0.5),
                            fontFamily: "Roboto",
                            //    color: darkText.withOpacity(darkText.opacity * 0.5)
                          ),

                          border: InputBorder.none,
                        ),


                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "Roboto",
                          //   color: darkText.withOpacity(darkText.opacity),
                        ),



                      ),
                    ),
                  ),
                  flex: 3,
                ),


                Expanded(
                  child: Text("获取验证码"),
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
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.centerRight,
              child: Text("收不到验证码？"),
            ),



            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20,top: 50,right: 20),
              height: 50,
              decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(new Radius.circular(10))
                    ),

              child: Text("登陆"),

            ),

          ],)


    );


  }







}
