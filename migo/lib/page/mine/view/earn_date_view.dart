import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class EarnDateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(I18n.of(context).earnrecord, style: AppFont.textStyle(12, color: Colors.black),),
          Container(
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: const Color(0x1A7BA0B9),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text("2020.10", style: AppFont.textStyle(12, color: AppColor.back998),),
                Container(
                  height: 14,
                  width: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 9),
                  decoration: BoxDecoration(
                    color: AppColor.back998.withOpacity(0.2)
                  ),
                ),
                Image.asset("assets/earndate.png")
              ],
            ),
          )
        ],
      ),
    );
  }
}