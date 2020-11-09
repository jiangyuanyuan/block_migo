import "package:flutter/material.dart";
import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MineInvitePage extends StatefulWidget {
  @override
  _MineInvitePageState createState() => _MineInvitePageState();
}

class _MineInvitePageState extends State<MineInvitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).invite,
        onPop: () => Navigator.pop(context),
        backImg: "share_bg.png",
        actions: [
          IconButton(
            icon: Image.asset("assets/coins_record.png"),
            onPressed: () => Navigator.pushNamed(context, "/inviterecord"),
          )
        ],
        child: Column(
          children: [
            SizedBox(height: 40,),
            Image.asset("assets/logo.png"),
            Container(
              margin: const EdgeInsets.only(top: 100, bottom: 20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(blurRadius: 14, offset: Offset(0 ,6), color: Color(0xff23496E).withOpacity(0.3)),
                ]
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 180,
                    width: 180,
                    color: Colors.white,
                    child: QrImage(
                      data: "",
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 180,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xffF29F23),
                          const Color(0xffE1660F),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                      )
                    ),
                    child: Text("${I18n.of(context).myinvitecode}MG123", style: AppFont.textStyle(12, color: Colors.white, fontWeight: FontWeight.bold, showshadow: true),),
                  )
                ],
              ),
            ),
            Text(I18n.of(context).myinvitecodenotice, textAlign: TextAlign.center, style: AppFont.textStyle(12, color: AppColor.back998, fontWeight: FontWeight.bold),),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 83),
              child: Row(
                children: [
                  Expanded(flex: 1, child: BtnImageBottomView(img: "home_btn.png", title: I18n.of(context).invitelink,)),
                  SizedBox(width: 20,),
                  Expanded(flex: 1, child: BtnImageBottomView(img: "home_btn_inactive.png", title: I18n.of(context).saveimage,)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}