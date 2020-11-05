import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/page/home/view/home_detail_head.dart';

class HomeDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: "乐屋",
        onPop: () => Navigator.pop(context),
        child: Column(
          children: [
            HomeDetailHeadView(),
          ],
        ),
      ),
    );
  }
}