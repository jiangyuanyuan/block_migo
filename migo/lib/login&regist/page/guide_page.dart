import 'package:flutter/cupertino.dart';
import 'package:migo/common/authbyimage/auth_manager.dart';
import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/page/lanuage_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:migo/main.dart' show FreeLocalizations;

class GuidePage extends StatefulWidget {

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {

  bool pushed = false;
  @override
  void initState() {
    super.initState();
  }


  void _jumpToRoot(BuildContext context) async {
    setState(() {
      pushed = true;
    });
    final share = await SharedPreferences.getInstance();
    if(share.getString(AppConst.KEY_user_token) != null) {
      Navigator.of(context).pushReplacementNamed('/root');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent, animate: true);
    ScreenUtil.init(context, width: 375, height: 667, allowFontScaling: true);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.back998,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text("语言切换")
            InkWell(
              onTap: () => Navigator.pushNamed(context, "/language"),
              child: Text(I18n.of(context).lang),
            ),
            Text("One MIGO One World"),
            // Text("登入")
            InkWell(
              onTap: () => Navigator.pushReplacementNamed(context, "/root"),
              // onTap: () {
              //   AuthManager.loadingBlockPuzzle(context);
              // },
              child: Text("登入"),
            ),
          ],
        ),
      ),
    );
  }
}
