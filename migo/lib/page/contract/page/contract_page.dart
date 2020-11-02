import 'package:flutter/material.dart';
import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/contract/view/exchange_cell.dart';

class ContractPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/背景图.png"),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          children: [
            NormalAppbar.normal(
              color: Colors.transparent,
              title: Text(I18n.of(context).exchange,style: AppFont.textStyle(14, color: Colors.white),),
              leading: SizedBox()
            ),
            SizedBox(height: 18,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 19),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8, 
                    color: Colors.black.withOpacity(0.3), 
                    spreadRadius: 0,
                    offset: Offset(0, 2)
                  )
                ]
              ),
              child: Column(
                children: [
                  Text(I18n.of(context).exchange, style: AppFont.textStyle(14, color: AppColor.back998, fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.only(top:19.0, bottom: 17),
                    child: ExchangeCell(),
                  ),
                  Image.asset("assets/pull_next.png"),
                  Padding(
                    padding: const EdgeInsets.only(top:19.0),
                    child: ExchangeCell(ispre: false,),
                  ),
                  SizedBox(height: 32,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("价格", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Text("当前M4级别", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                          ),
                          Text("下一级M5级别", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text("1.343747 每 MICO", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                              Icon(Icons.change_history)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Text("手续费减免10%", style: AppFont.textStyle(12, color: AppColor.back998),),
                          ),
                          Text("手续费可减免20%", style: AppFont.textStyle(12, color: AppColor.red),),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  BtnAction(
                    title: "立即兑换",
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