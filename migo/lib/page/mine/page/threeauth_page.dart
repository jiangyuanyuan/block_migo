import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/event_bus.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';
import 'package:migo/page/mine/page/alert_auth_view.dart';

class ThreeAuthPage extends StatefulWidget {
  @override
  _ThreeAuthPageState createState() => _ThreeAuthPageState();
}

class _ThreeAuthPageState extends State<ThreeAuthPage> {
  
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  TextEditingController _numcontroller = TextEditingController();
  FocusNode _numfocusNode = FocusNode();
  TextEditingController _bankcontroller = TextEditingController();
  FocusNode _bankfocusNode = FocusNode();
  TextEditingController _phonecontroller = TextEditingController();
  FocusNode _phonefocusNode = FocusNode();

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
    _bankcontroller.dispose();
    super.dispose();
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
    if(_bankcontroller.text.isEmpty) {
      EasyLoading.showToast(I18n.of(context).pleasebankNo);
      return;
    }
    if(_phonecontroller.text.isEmpty) {
      EasyLoading.showToast(I18n.of(context).pleaseinputphone);
      return;
    }

    Alert.showViewDialog(context, AlertAuthView(status: number == 0 ? 3 : 0,onSure: () {
      EasyLoading.show(status: "Loading...");
      Networktool.request(API.authUserByBank, params: {
          "bankNumber": _bankcontroller.text,
          "cardNo": _numcontroller.text,
          "userName": _controller.text,
          "userPhone": _phonecontroller.text,
      }, success: (data) {
        EasyLoading.showToast(I18n.of(context).success);
        Navigator.pop(context);
        EventBus.instance.commit(EventKeys.RefreshAuth, null);
      }, fail: (msg) => EasyLoading.showToast(msg),);
    },));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _focusNode.unfocus();
        _numfocusNode.unfocus();
        _bankfocusNode.unfocus();
        _phonefocusNode.unfocus();
      },
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
            SizedBox(height: 10,),
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
            SizedBox(height: 10,),
            Stack(
              children: [
                NormalTextfield(
                  hintText: I18n.of(context).pleasebankNo,
                  align: TextAlign.right,
                  controller: _bankcontroller,
                  focusNode: _bankfocusNode,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
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
                    child: Text(I18n.of(context).bankNo, style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            Stack(
              children: [
                NormalTextfield(
                  hintText: I18n.of(context).pleaseinputbanknumber,
                  align: TextAlign.right,
                  controller: _phonecontroller,
                  focusNode: _phonefocusNode,
                  maxLength: 11,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
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
                    child: Text(I18n.of(context).phone, style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(left: 6.0, top: 40),
                child: Row(
                  children: [
                    Image.asset("assets/sign_tip_arrow_right.png"),
                    SizedBox(width: 6,),
                    Text(I18n.of(context).notice, style: AppFont.textStyle(14, color: const Color(0xffDBF0FF), fontWeight: FontWeight.bold, showshadow: true),)
                  ],
                ),
              ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
                child: Text(
                  I18n.of(context).threeauthNotice,
                  style: AppFont.textStyle(12, color: const Color(0xffDBF0FF)),
                ),
              ),
              Spacer(),
              SafeArea(
                child: BtnImageBottomView(
                  title: I18n.of(context).submit,
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