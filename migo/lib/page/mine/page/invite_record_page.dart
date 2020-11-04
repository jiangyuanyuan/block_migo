import 'package:flutter/material.dart';
import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class InviteRecordPage extends StatefulWidget {
  @override
  _InviteRecordPageState createState() => _InviteRecordPageState();
}

class _InviteRecordPageState extends State<InviteRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).inviterecord,
        onPop: () => Navigator.pop(context),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 30),
          itemBuilder: (context, index) {
            return _Cell();
          }
        ),
      )
    );
  }
}

class _Cell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black26),
        color: AppColor.red
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("18311111111"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("2020-09-22"),
              Text("已认证", style: AppFont.textStyle(14, color: AppColor.back998),)
            ],
          )
        ],
      ),
    );
  }
}

