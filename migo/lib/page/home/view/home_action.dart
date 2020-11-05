import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';

class HomeActionView extends StatelessWidget {
  final String img;
  final String title;
  final Function onTap;
  const HomeActionView({Key key, this.onTap, this.img, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset("assets/$img"),
          SizedBox(height: 8,),
          Text(title, style: AppFont.textStyle(10, color: Colors.white),)
        ],
      ),
    );
  }
}