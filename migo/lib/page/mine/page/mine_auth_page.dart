import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/custom_menu_view.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';

import 'alert_auth_view.dart';
class MineAuthPage extends StatefulWidget {
  @override
  _MineAuthPageState createState() => _MineAuthPageState();
}

class _MineAuthPageState extends State<MineAuthPage> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  TextEditingController _numcontroller = TextEditingController();
  FocusNode _numfocusNode = FocusNode();
  // 证件类型1身份证 2护照 3其他	
  int type = 1;
  String typename;
  int number = 0;
  String tick = "--";

  @override
  void initState() {
    super.initState();
    _getUser();
  }
  @override
  void dispose() {
    _controller.dispose();
    _numcontroller.dispose();
    super.dispose();
  }

  List<String> _createtitle(BuildContext context) {
    return [
      I18n.of(context).idcard,
      I18n.of(context).iddrive,
      I18n.of(context).idprotect,
    ];
  }

  void _getUser() {
    Networktool.request(API.getUserTicket, method: HTTPMETHOD.GET, success: (data) {
      final tmep = data["data"];
      if(tmep != null) {
        tick = tmep["ticketTitle"];
        number = tmep["ticketNumber"];
      }
      if(mounted) setState(() {
        
      });
    });
  }

  void _submit() {
    if(_controller.text.isEmpty) {
      EasyLoading.showToast(I18n.of(context).pleaseinputname);
      return;
    }
    if(_numcontroller.text.isEmpty) {
      EasyLoading.showToast(I18n.of(context).pleaseinputid);
      return;
    }
    Alert.showViewDialog(context, AlertAuthView(status: number == 0 ? 3 : 0,onSure: () {
      Future.delayed(const Duration(milliseconds: 100)).then((value) {
        Navigator.pushNamed(context, "/authupload", arguments: {"name":_controller.text, "number": _numcontroller.text, "type":type});
      });
    },));
  }

  void _changetype(String val, int sender) {
    switch (sender) {
      case 0:
        type = 1;
        break;
      case 2:
        type = 2;
        break;
      default:
        type = 3;
    }
    setState(() {
      typename = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _numfocusNode.unfocus();
          _focusNode.unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 18,),
              Stack(
                children: [
                  NormalTextfield(
                    hintText: I18n.of(context).pleaseinputname,
                    align: TextAlign.right,
                    controller: _controller,
                    focusNode: _focusNode,
                  ),
                  Positioned(
                    left: 5,
                    top: 8,
                    bottom: 8,
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.only(left: 12),
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                      child: Text(I18n.of(context).name, style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),),

                    ),
                  )
                ],
              ),
              SizedBox(height: 14,),
              Stack(
                children: [
                  Container(
                    height: 51,
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/input_back.png"),
                        fit: BoxFit.fill
                      )
                    ),
                  ),
                  Positioned(
                    left: 5,
                    top: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.only(left: 12),
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                      child: Text(I18n.of(context).idtype, style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Positioned(
                    right: 15,
                    top: 8,
                    left: 100,
                    bottom: 8,
                    child: Container(
                      height: 28,
                      color: Colors.white,
                      alignment: Alignment.centerRight,
                      child: CustiomMenuView(
                        backgroundColor: Colors.white,
                        titles: _createtitle(context),
                        onSelected: (index, val) {
                          _changetype(val, index);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(typename == null ? I18n.of(context).idcard : typename, style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),),
                            SizedBox(width: 6,),
                            Image.asset("assets/sign_choos_arrow_down.png")
                          ],
                        ),
                      ),
                    )
                  ),
                ],
              ),
              SizedBox(height: 14,),
              Stack(
                children: [
                  NormalTextfield(
                    hintText: I18n.of(context).pleaseinputid,
                    align: TextAlign.right,
                    controller: _numcontroller,
                    focusNode: _numfocusNode,
                  ),
                  Positioned(
                    left: 5,
                    top: 8,
                    bottom: 8,
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.only(left: 12),
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                      child: Text(I18n.of(context).idnumber, style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),),
                    ),
                  )
                ],
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Row(
                  children: [
                    Image.asset("assets/sign_tip_arrow_right.png"),
                    SizedBox(width: 6,),
                    Text(I18n.of(context).notice, style: AppFont.textStyle(14, color: const Color(0xffDBF0FF), fontWeight: FontWeight.bold, showshadow: true),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Text(
                  I18n.of(context).threeauthNotice2,
                  style: AppFont.textStyle(12, color: const Color(0xffDBF0FF)),
                ),
              ),
              Spacer(),
              SafeArea(
                child: BtnImageBottomView(
                  title: I18n.of(context).next,
                  onTap: _submit,
                ),
              ),
              SizedBox(height: 70,)
            ],
          ),
        ),
      );
  }
}