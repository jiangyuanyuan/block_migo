import 'package:migo/common/textstyle/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/home/model/home_list_model.dart';

class HomeCell extends StatelessWidget {
  final int index;
  final HomeModel model;
  const HomeCell({Key key, this.index, this.model}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Stack(
          children: [
            Image.asset("assets/Panel.png",),
            Positioned.fill(
              child: Container(
              margin: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 85,
                          height: 25,
                          margin: const EdgeInsets.only(bottom: 20),
                          alignment: Alignment.center,
                          child: Text("${I18n.of(context).homeearn} ${model.mineCoinName}", style: AppFont.textStyle(12, color: AppColor.yellowMain),)
                        ),
                        Text(model.mineTitle, style: AppFont.textStyle(11, color: Colors.white, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  SizedBox(width: 24,),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${I18n.of(context).homepay}：${model.pledgeAmount} ${model.pledgeCoinName}", style: AppFont.textStyle(12, color: Colors.white),),
                        Text("${I18n.of(context).dailyoutput}：${model.oneDayAmount}", style: AppFont.textStyle(12, color: Colors.white),),
                        Text("${I18n.of(context).miningcycle}：${model.mineTimes} ${I18n.of(context).day}", style: AppFont.textStyle(12, color: Colors.white),),
                        Text("${I18n.of(context).miningamount}：${model.totalMine}", style: AppFont.textStyle(12, color: Colors.white),),
                      ],
                    ),
                  )
                ],
              ),
            ),
            )
          ],
        ),
      ),
    );
  }
}