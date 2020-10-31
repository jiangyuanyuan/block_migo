import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/commview/bottom_buttom.dart';
import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/login_email.dart';
import 'package:migo/login&regist/view/login_phone.dart';
import 'package:migo/login&regist/view/phone_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../view/rich_protocol.dart';

class LoginPage extends StatefulWidget {
  final Map param;

  const LoginPage({Key key, this.param}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {

  FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  TabController _tabController;
  int tabIndex = 0;
  PageController _pageController = PageController();
  // 1: 修改密码 2: 修改交易密码
  int modtype = 0;
  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if(widget.param != null) {
      modtype = widget.param["modtype"];
    }
    _tabController = TabController(length: 2, vsync: this);
  }

  void _jumpSmsCode() {
    if(_controller.text.isEmpty) return;
    EasyLoading.show(status: "Loading...");
    Networktool.request(API.sms + _controller.text, method: HTTPMETHOD.GET, success: (data){
      Navigator.pushNamed(context, "/smscode", arguments: {"phone":_controller.text, "code": data["data"]});
    },finaly: () => EasyLoading.dismiss());
  }

  void _login(String account, String pwd, bool isemail) {
    if(account.isEmpty) {
      EasyLoading.showToast(isemail ? I18n.of(context).pleaseinputemail : I18n.of(context).pleaseinputphone);
      return;
    }
    if(pwd.isEmpty) {
      EasyLoading.showToast(I18n.of(context).pleaseinputpwd);
      return;
    }
    Navigator.of(context).pushReplacementNamed('/root');
  }

  void _jumpPwdlogin() {
    Navigator.pushNamed(context, "/pwdlogin", arguments: {"phone": _controller.text});
  }

  List<Widget> _createTabs(BuildContext context) {
    List<String> titles = [
      I18n.of(context).phone,
      I18n.of(context).email,
    ];
    return titles.map((e) => Text(
      e, 
      style: AppFont.textStyle(
        tabIndex == titles.indexOf(e) ? 20 : 14, 
        color: tabIndex == titles.indexOf(e) ? Colors.white : Colors.white38),
      )
    ).toList();
  }

  String _getTitle(BuildContext context) {
    switch (modtype) {
      case 0:
        return I18n.of(context).login;
        break;
      case 1:
        return I18n.of(context).setting + " " + I18n.of(context).loginpwd;
      default:
        return I18n.of(context).setting + " " + I18n.of(context).txpassword;
    }
  } 

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: AppColor.back998,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => _focusNode.unfocus(),
        child: Column(
          children: [
            NormalAppbar.normal(
              color: AppColor.back998,
              title: Text(_getTitle(context), style: AppFont.textStyle(14, color: Colors.white, fontWeight: FontWeight.bold),),
              leading: IconButton(
                icon: Image.asset("assets/icon_zuo.png", color: Colors.white,),
                onPressed: () {
                  if(Navigator.canPop(context)) {
                     Navigator.pop(context);
                  }
                },
              )
            ),
            Container(
              margin: const EdgeInsets.only(top: 4, left: 14),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  tabs: _createTabs(context),
                  indicatorPadding: const EdgeInsets.only(left: 30, right: 30,),
                  labelPadding: const EdgeInsets.only(top: 16, bottom: 10, right: 16, left: 16),
                  controller: _tabController,
                  indicatorWeight: 3,
                  indicatorColor: Colors.white,
                  isScrollable: true,
                  onTap: (sender) {
                    _pageController.jumpToPage(sender);
                    setState(() {
                      tabIndex = sender;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  LoginPhoneView(modetype: modtype, onLogin: (sender, pwd) => _login(sender, pwd, false),),
                  LoginEmailView(modtype: modtype, onLogin: (sender, pwd) => _login(sender, pwd, true))
                ],
                onPageChanged: (value) {
                  setState(() {
                    tabIndex = value;
                  });
                  _tabController.animateTo(value);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}