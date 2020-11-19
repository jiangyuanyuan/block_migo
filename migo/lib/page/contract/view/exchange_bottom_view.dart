import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/contract/model/exchange_model.dart';

class ExchangeBottomView extends StatelessWidget {
  final String fee;
  final String getAmount;
  final String level;
  const ExchangeBottomView({Key key, this.fee, this.getAmount, this.level}) : super(key: key);

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
              Text(I18n.of(context).enough, style: AppFont.textStyle(12, color: Colors.white,)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(I18n.of(context).leastget, style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.5))),
                Text("$getAmount", style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.5),)),
              ],
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(I18n.of(context).priceslippage, style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.5))),
          //     Text("6.26%", style: AppFont.textStyle(12, color: Colors.white,)),
          //   ],
          // ),
          // SizedBox(height: 14,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${I18n.of(context).handlingfee}（M$level）", style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.5))),
              Text("$fee", style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.5),)),
            ],
          ),
        ],
      ),
    );
  }
}