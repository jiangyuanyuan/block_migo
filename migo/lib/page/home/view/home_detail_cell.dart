import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';

class HomeDetailCell extends StatelessWidget {
  final int tabindex;
  final num amount;
  final int createtime;
  final String coinName;
  const HomeDetailCell({Key key, this.coinName, this.tabindex, this.amount, this.createtime}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$amount $coinName", style: AppFont.textStyle(14, color: AppColor.back998),),
              SizedBox(height: 4,),
              Text(Tool.timeFormat("yyyy-MM-dd HH:mm", createtime), style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),)
            ],
          ),
          Spacer(), 
          Text(tabindex == 0 ? I18n.of(context).paid : I18n.of(context).geted, style: AppFont.textStyle(12, color: AppColor.back998),)
        ],
      ),
    );
  }
}