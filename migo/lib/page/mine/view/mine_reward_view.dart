import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/textstyle/textstyle.dart';

class MineRewardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: 10,
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => Divider(height: 1,),
            itemBuilder: (context, index) {
            return _Cell();
          }),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("直推奖", style: AppFont.textStyle(14, color: Colors.black),),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "+39", style: AppFont.textStyle(14, color: AppColor.green, fontWeight: FontWeight.bold)),
                    TextSpan(text: " MICOs", style: AppFont.textStyle(14, color: Colors.black)),
                  ]
                )
              )
            ],
          ),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("10/15达标领导奖励", style: AppFont.textStyle(14, color: Colors.black.withOpacity(0.5)),),
              Text("2020/10/28 22:57", style: AppFont.textStyle(14, color: Colors.black.withOpacity(0.5)),)
            ],
          ),
        ],
      ),
    );
  }
}