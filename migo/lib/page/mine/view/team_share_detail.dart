import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/textstyle/textstyle.dart';

class TeamShareDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 24),
          child: Text("分享奖励", style: AppFont.textStyle(12, color: Colors.black)),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _Cell(),
              _Cell(),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          child: BtnAction(
            title: "马上邀请好友",
          ),
        )
      ],
    );
  }
}

class _Cell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 104,
          color: const Color(0xffFEE1BF),
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 80,
                margin: const EdgeInsets.only(right: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffF7C28A),
                  shape: BoxShape.circle
                ),
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xffFEE1BF),
                    shape: BoxShape.circle,
                    border: Border.all(width: 4, color: const Color(0xff654248))
                  ),
                  alignment: Alignment.center,
                  child: Text("M5", style: AppFont.textStyle(24, color: const Color(0xff654248), fontWeight: FontWeight.bold),),
                ),
              ),

              Text("享受7-9代 \n2%奖励", textAlign: TextAlign.left, style: AppFont.textStyle(16, color: const Color(0xff654248), fontWeight: FontWeight.bold),)
            ],
          ),
        ),
        Positioned(
          left: 23,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset("assets/bg_price_level_def.png"),
              Text("当前等级", style: AppFont.textStyle(12, color: Colors.white),)
            ],
          ),
        )
      ],
    );
  }
}