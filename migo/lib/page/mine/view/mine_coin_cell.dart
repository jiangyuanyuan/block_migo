import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/page/mine/model/me_model.dart';

class MineCoinCell extends StatelessWidget {
  final MineCoinModel model;
  final String img;
  const MineCoinCell({Key key, this.model, this.img}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
      child: Column(
        children: [
          Row(
            children: [
              // Image.asset("assets/usdt.png"),
              Image.network(model.coinUrl ?? "", width: 40, height: 40,),
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.coinName, style: AppFont.textStyle(14, color: Colors.black),),
                  SizedBox(height: 4,),
                  Text(model.coinName.toLowerCase(), style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(Tool.number(model.amount, 4), style: AppFont.textStyle(14, color: Colors.black),),
                  SizedBox(height: 4,),
                  Text(model.cnyAmount == 0 ? "" : "≈¥${Tool.number(model.cnyAmount * model.amount, 2)}", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
                ],
              ),
            ],
          ),
          SizedBox(height: 16,),
          Divider(height: 1,)
        ],
      ),
    );
  }
}