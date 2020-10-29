import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichProtocolView extends StatelessWidget {

  void _userProtocol(BuildContext context,bool isuserprotocl) {
    print(isuserprotocl);
    Navigator.pushNamed(context, "/userprotocol",arguments: {
      "isuser":isuserprotocl,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: "登录即表明同意",style: AppFont.textStyle(12, color: AppColor.fontgrey),),
          TextSpan(
            text: "《币小贝用户协议》",
            style: AppFont.textStyle(12, color: Colors.blue),
            recognizer: TapGestureRecognizer()..onTap = () => _userProtocol(context,true),
          ),
          TextSpan(
            text: "和",
            style: AppFont.textStyle(12, color: AppColor.fontgrey),
          ),
          TextSpan(
            text: "《风险投资说明》",
            style: AppFont.textStyle(12, color: Colors.blue),
            recognizer: TapGestureRecognizer()..onTap = () => _userProtocol(context,false),
          )
        ]
      )
    );
  }
}