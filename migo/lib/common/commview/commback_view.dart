import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

import 'appbar.dart';

class CommbackView extends StatelessWidget {
  final Widget child;
  final List<Widget> actions;
  final Widget leading;
  final String titles;
  final String backImg;
  final Function() onPop;
  const CommbackView({Key key, this.backImg = "背景图.png", this.onPop, @required this.titles, this.leading, this.actions, @required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/$backImg"),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: NormalAppbar.normal(
                color: Colors.transparent,
                title: Text(titles,style: AppFont.textStyle(14, color: Colors.white),),
                leading: leading,
                actions: actions,
                onPress: onPop,
              ),
            ),
            Expanded(
              child: child,
            )
          ]
        )
      );
  }
}