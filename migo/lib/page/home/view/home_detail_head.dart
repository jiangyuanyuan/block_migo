import 'package:flutter/material.dart';
import 'package:migo/common/commview/gradient_text.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';

class HomeDetailHeadView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("使用中铲子", style: AppFont.textStyle(12, color: const Color(0xffDBF0FF)),),
              SizedBox(height: 8,),
              GradientText(
                "2",
                gradient: LinearGradient(colors: [
                  Color(0xffFFD765),
                  Color(0xffFF9C00),
                  Color(0xffFFF5BE)
                ],begin: Alignment.topCenter, end: Alignment.bottomCenter),
                style: AppFont.textStyle(16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20,),
              Text("矿池日产量", style: AppFont.textStyle(12, color: const Color(0xffDBF0FF)),),
              SizedBox(height: 10,),
              GradientText(
                "1.8",
                gradient: LinearGradient(colors: [
                  Color(0xffFFD765),
                  Color(0xffFF9C00),
                  Color(0xffFFF5BE),
                ],begin: Alignment.topCenter, end: Alignment.bottomCenter),
                style: AppFont.textStyle(16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("挖矿周期", style: AppFont.textStyle(12, color: const Color(0xffDBF0FF)),),
              SizedBox(height: 8,),
              GradientText(
                "30天",
                gradient: LinearGradient(colors: [
                  Color(0xffFFD765),
                  Color(0xffFF9C00),
                  Color(0xffFFF5BE)
                ],begin: Alignment.topCenter, end: Alignment.bottomCenter),
                style: AppFont.textStyle(16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20,),
              Text("矿池总产量", style: AppFont.textStyle(12, color: const Color(0xffDBF0FF)),),
              GradientText(
                "20",
                gradient: LinearGradient(colors: [
                  Color(0xffFFD765),
                  Color(0xffFF9C00),
                  Color(0xffFFF5BE)
                ],begin: Alignment.topCenter, end: Alignment.bottomCenter),
                style: AppFont.textStyle(16, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}