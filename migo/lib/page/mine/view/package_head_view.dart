import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';

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
              Text("当前总生产率", style: AppFont.textStyle(12, color: const Color(0xffDBF0FF)),),
              SizedBox(height: 8,),
              Text(Tool.number(12.499, 2), style: AppFont.textStyle(12, color: Colors.white),),
              SizedBox(height: 20,),
              Text("今日预估获得", style: AppFont.textStyle(12, color: const Color(0xffDBF0FF)),),
              Text(Tool.number(12.499, 2), style: AppFont.textStyle(12, color: Colors.white),),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("背包容量", style: AppFont.textStyle(12, color: const Color(0xffDBF0FF)),),
              SizedBox(height: 8,),
              Text("6 / 200", style: AppFont.textStyle(12, color: Colors.white),),
              SizedBox(height: 20,),
              Text("累计产出MIGOs", style: AppFont.textStyle(12, color: const Color(0xffDBF0FF)),),
              Text(Tool.number(2000.22, 2), style: AppFont.textStyle(12, color: Colors.white),),
            ],
          )
        ],
      ),
    );
  }
}