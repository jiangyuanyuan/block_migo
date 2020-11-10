import 'dart:async';

import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/time_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/util/time_tool.dart';
import 'package:migo/generated/i18n.dart';


class SmsCounterView extends StatefulWidget {
  
  final String phone;
  final bool isemail;
  const SmsCounterView({Key key, this.phone, this.isemail = false}) : super(key: key);

  @override
  _SmsCounterViewState createState() => _SmsCounterViewState();
}

class _SmsCounterViewState extends State<SmsCounterView> {

  TimeTool _timer;
  int counter = 59;
  bool isstop = true;
  String phone = "";

  @override
  void initState() {
    super.initState();
    phone = widget.phone;
  }

  @override
  void dispose() {
    _timer?.stop();
    super.dispose();
  }

  @override
  void didUpdateWidget(SmsCounterView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _beginTimer() {
    if(mounted) {
      setState(() {
        isstop = false;
      });
    }
    _timer = TimeTool.begin(duration: 59, callback:(timerCount){ 
      if(mounted){
        setState(() {
          counter = timerCount;
          if(timerCount <= 0) {
            counter = 59;
            isstop = true;
          }
        });
      }
    });
  }

  void _resend() {
    String phone = widget.phone ?? "";
    if(widget.isemail && widget.phone == null) {
      EasyLoading.showError(I18n.of(context).pleaseinputphone);
      return;
    }
    if(!widget.isemail && phone.isEmpty) {
      EasyLoading.showError(I18n.of(context).pleaseinputphone);
      return;
    }
    EasyLoading.show(status: "Loading...");
    String url = API.sms + "$phone/1";
    if(widget.isemail) url = API.emailcode + "$phone";
    Networktool.request(url, method: HTTPMETHOD.GET, success: (data){
      // 回传新发的验证码
      _beginTimer();
    },finaly: () => EasyLoading.dismiss());
  }

  @override
  Widget build(BuildContext context) {
    return isstop ? InkWell(
      onTap: _resend,
      child: Text(I18n.of(context).getcoude, style: AppFont.textStyle(12, color: AppColor.back998),))
      : Text("${I18n.of(context).reacquire}（${counter}s）", style: AppFont.textStyle(12, color: AppColor.back998.withOpacity(0.3))
    );
  }
}