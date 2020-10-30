import "package:flutter/material.dart";
import 'package:migo/common/commview/appbar.dart';

class MineInvitePage extends StatefulWidget {
  @override
  _MineInvitePageState createState() => _MineInvitePageState();
}

class _MineInvitePageState extends State<MineInvitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppbar.normal(
        title: Text("邀请好友"),
        onPress: () => Navigator.pop(context),
        actions: [
          FlatButton(
            child: Text('邀请记录'),
            onPressed: () {
              Navigator.pushNamed(context, "/inviterecord");
            },
          )
        ]
      ),
    );
  }
}