import 'dart:async';

import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/time_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class SmsCounterView extends StatefulWidget {
  
  final String phone;

  const SmsCounterView({Key key, this.phone}) : super(key: key);

  @override
  _SmsCounterViewState createState() => _SmsCounterViewState();
}

class _SmsCounterViewState extends State<SmsCounterView> {

  TimeTool _timer;
  int counter = 59;
  bool isstop = false;

  @override
  void initState() {
    super.initState();
    _beginTimer();
  }

  @override
  void dispose() {
    _timer.stop();
    super.dispose();
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
    EasyLoading.show(status: "Loading...");
    Networktool.request(API.sms + widget.phone, method: HTTPMETHOD.GET, success: (data){
      // 回传新发的验证码
      _beginTimer();
    },finaly: () => EasyLoading.dismiss());
  }

  @override
  Widget build(BuildContext context) {
    return isstop ? InkWell(
      onTap: _resend,
      child: Text("重新发送", style: AppFont.textStyle(14, color: Colors.blue),))
      : Text.rich(
      TextSpan(
        children: [
          TextSpan(text: "$counter", style: AppFont.textStyle(14, color: Colors.blue)),
          TextSpan(text: " 秒后重新发送验证码", style: AppFont.textStyle(14, color: Colors.grey)),
        ]
      )
    );
  }
}