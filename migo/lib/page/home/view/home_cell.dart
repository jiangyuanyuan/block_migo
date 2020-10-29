import 'package:migo/common/textstyle/textstyle.dart';
import 'package:flutter/material.dart';

class HomeCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Text("赚取MIGO", style: AppFont.textStyle(12, color: AppColor.yellowMain),),
              Text("MIGO乐乡", style: AppFont.textStyle(12),)
            ],
          )
        ],
      ),
    );
  }
}