import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/page/home/view/home_gradient_text.dart';

class PackageHeadView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 26, left: 32, right: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("当前总生产率", style: AppFont.textStyle(12, color: const Color(0xffDBF0FF), showshadow: true),),
              SizedBox(height: 8,),
              // Text(, style: AppFont.textStyle(12, color: Colors.white),),
              HomeGradientText(data: Tool.number(12.499, 2), fontstyle: AppFont.textStyle(16, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Text("今日预估获得", style: AppFont.textStyle(12, color: const Color(0xffDBF0FF), showshadow: true),),
              HomeGradientText(data: Tool.number(12.499, 2), fontstyle: AppFont.textStyle(16, fontWeight: FontWeight.bold),),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("背包容量", style: AppFont.textStyle(12, color: const Color(0xffDBF0FF), showshadow: true),),
              SizedBox(height: 8,),
              HomeGradientText(data: "6 / 200", fontstyle: AppFont.textStyle(16, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Text("累计产出MIGOs", style: AppFont.textStyle(12, color: const Color(0xffDBF0FF), showshadow: true),),
              HomeGradientText(data: Tool.number(12.499, 2), fontstyle: AppFont.textStyle(16, fontWeight: FontWeight.bold),),
            ],
          )
        ],
      ),
    );
  }
}