import 'package:flutter/cupertino.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:migo/generated/i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuidePage extends StatefulWidget {

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100)).then((value) => _jumpToRoot(context));
  }


  void _jumpToRoot(BuildContext context) async {
    final share = await SharedPreferences.getInstance();
    if(share.getString(AppConst.KEY_user_token) != null) {
      Navigator.of(context).pushNamedAndRemoveUntil('/root', (route) => false);
    } else {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent, animate: true);
    ScreenUtil.init(context, width: 375, height: 667, allowFontScaling: true);
    return Scaffold(
      backgroundColor: AppColor.back998,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/背景图.png"),
            fit: BoxFit.cover
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Image.asset("assets/手机.png"),
                  Positioned(
                    right: 40,
                    top: 40,
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, "/language"),
                      child: Image.asset("assets/语言切换.png")
                    ),
                  )
                ],
              ),
              SizedBox(height: 40,),
              BtnAction(
                title: I18n.of(context).login,
                onTap: () {
                  Navigator.of(context).pushNamed('/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
