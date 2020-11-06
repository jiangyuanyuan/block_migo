import "package:flutter/material.dart";
import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/generated/i18n.dart';

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
        actions: [
          IconButton(
            icon: Image.asset("assets/coins_record.png"),
            onPressed: () => Navigator.pushNamed(context, "/inviterecord"),
          )
        ],
        child: Container(),
      ),
    );
  }
}