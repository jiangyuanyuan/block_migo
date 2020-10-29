import 'package:coinexchange/provider/user.dart';
import 'package:coinexchange/root/root.dart';
import 'package:coinexchange/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/const/cosnt.dart';
import 'login&regist/page/guide_page.dart';
import 'login&regist/page/pwd_login.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xff5C96EA),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        appBarTheme: AppBarTheme(elevation: 0, brightness: Brightness.light),
        primaryTextTheme: TextTheme(headline6: TextStyle(fontSize:17, fontFamily: "PingFang-Medium", color: AppColor.font333)),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      home: MainPage(),
      builder: (context, child) {
        ScreenUtil.init(context, width: 375, height: 667, allowFontScaling: true);
        FlutterStatusbarcolor.setStatusBarColor(Colors.transparent, animate: true);
        return Material(
          type: MaterialType.transparency,
          child: FlutterEasyLoading(
            child: child,
          ),
        );
      },
    );
  }
}

class MainPage extends StatelessWidget {


  Future<Widget> _create() async {
    final share = await SharedPreferences.getInstance();
    if(share.getString(AppConst.KEY_user_token) != null) {
      return RootPage();
    } else {
      return PwdLoginPage();
      // Navigator.of(context).pushReplacementNamed('/pwdlogin');
      // Navigator.of(context).pushReplacementNamed('/login');
      // Navigator.pushNamed(context, "/pwdlogin", arguments: {"phone": _controller.text});
    }
  }
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent, animate: true);
    ScreenUtil.init(context, width: 375, height: 667, allowFontScaling: true);
    return FutureBuilder(
      initialData: Container(),
      future: _create(),
      builder: (context, snapshot) => snapshot.data,
    );
  }
}
