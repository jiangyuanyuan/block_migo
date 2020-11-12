import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/model/mine_team_model.dart';

class MineRewardView extends StatelessWidget {
  final List<AccountDetailModel> accountDetailList;

  const MineRewardView({Key key, this.accountDetailList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: accountDetailList.length,
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => Divider(height: 1,),
            itemBuilder: (context, index) {
              final model = accountDetailList[index];
            return _Cell(model: model);
          }),
        ),
        SafeArea(
          top: false,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: BtnImageBottomView(
              title: I18n.of(context).invite,
              onTap: () => Navigator.pushNamed(context, "/invite"),
            ),
          ),
        )
      ],
    ); 
  }
}

class _Cell extends StatelessWidget {
  final AccountDetailModel model;

  const _Cell({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(I18n.of(context).directPushAward, style: AppFont.textStyle(14, color: Colors.black),),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "+${model.amount}", style: AppFont.textStyle(14, color: AppColor.green, fontWeight: FontWeight.bold)),
                    TextSpan(text: " ${model.coinName}", style: AppFont.textStyle(14, color: Colors.black)),
                  ]
                )
              )
            ],
          ),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${Tool.timeFormat("MM/dd", model.createTime)} ${I18n.of(context).aimreward}", style: AppFont.textStyle(14, color: Colors.black.withOpacity(0.5)),),
              Text("${Tool.timeFormat("MM/dd", model.createTime)}", style: AppFont.textStyle(14, color: Colors.black.withOpacity(0.5)),)
            ],
          ),
        ],
      ),
    );
  }
}