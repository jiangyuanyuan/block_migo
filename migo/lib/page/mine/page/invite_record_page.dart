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
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
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
        image: DecorationImage(
          image: AssetImage("assets/bg_list_invite_def.png"),
          fit: BoxFit.fill
        )
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("18311111111", style: AppFont.textStyle(20, color: Colors.white, showshadow: true, fontWeight: FontWeight.bold),),
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("2020-09-22", style: AppFont.textStyle(14, color: const Color(0xffDBF0FF), showshadow: true),),
              Text(I18n.of(context).inviteverified, style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),)
            ],
          )
        ],
      ),
    );
  }
}

