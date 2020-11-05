import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';

class HomeDetailCell extends StatelessWidget {
  final int tabindex;

  const HomeDetailCell({Key key, this.tabindex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("10 MIGO", style: AppFont.textStyle(14, color: AppColor.back998),),
              SizedBox(height: 4,),
              Text("2019-10-10", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),)
            ],
          ),
          Spacer(), 
          Text(tabindex == 0 ? "已支付" : "已获得", style: AppFont.textStyle(12, color: AppColor.back998),)
        ],
      ),
    );
  }
}