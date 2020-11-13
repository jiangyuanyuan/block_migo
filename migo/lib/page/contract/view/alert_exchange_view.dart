import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class AlertExhangeView extends StatelessWidget {
  final Function() onSure;
  final String outputAmount;
  final String currCoinName;
  final String outCoinName;
  final String price;
  final String fee;
  final String inputAmout;
  final String precent;
  final String level;
  const AlertExhangeView({Key key, this.level, this.precent, this.onSure, this.outputAmount, this.currCoinName, this.outCoinName, this.price, this.fee, this.inputAmout}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(8))
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 24,),
                Text(I18n.of(context).confirmexchange, style: AppFont.textStyle(14,color: AppColor.back998, fontWeight: FontWeight.bold),),
                IconButton(
                  icon: Icon(Icons.cancel, color: const Color(0xffdedede),),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: AppColor.divigrey,
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Text("$inputAmout", style: AppFont.textStyle(14,color: AppColor.back998, fontWeight: FontWeight.bold),),
                      ),
                      Text("$currCoinName", style: AppFont.textStyle(14,color: Colors.black.withOpacity(0.5)),),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Image.asset("assets/pull_next.png"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Text("$outputAmount", style: AppFont.textStyle(14,color: AppColor.back998, fontWeight: FontWeight.bold),),
                      ),
                      Text("$outCoinName", style: AppFont.textStyle(14,color: Colors.black.withOpacity(0.5)),),
                    ],
                  ),
                  Divider(height: 41,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(I18n.of(context).price, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                  //     Text("$precent $currCoinName / $outCoinName", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5),)),
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(I18n.of(context).leastget, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5))),
                        Text("$outputAmount $outCoinName", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5),)),
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(I18n.of(context).priceslippage, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5))),
                  //     Text("6.26%", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5),)),
                  //   ],
                  // ),
                  // SizedBox(height: 14,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${I18n.of(context).handlingfee}（M$level）", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5))),
                      Text("$fee", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5),)),
                    ],
                  ),
                  SizedBox(height: 43,),
                  BtnAction(
                    title: I18n.of(context).sure,
                    onTap: () {
                      if(onSure != null) onSure();
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}