import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class ExchangeBottomView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xff23496E),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(I18n.of(context).supply, style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.5)),),
              Text("充足", style: AppFont.textStyle(12, color: Colors.white,)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(I18n.of(context).leastget, style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.5))),
                Text("450 HDAOS", style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.5),)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(I18n.of(context).priceslippage, style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.5))),
              Text("6.26%", style: AppFont.textStyle(12, color: Colors.white,)),
            ],
          ),
          SizedBox(height: 14,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${I18n.of(context).handlingfee}（M1）", style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.5))),
              Text("40%", style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.5),)),
            ],
          ),
        ],
      ),
    );
  }
}