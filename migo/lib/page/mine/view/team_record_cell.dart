import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/model/team_record_model.dart';

class TeamRecordCell extends StatelessWidget {
  final TeamRecordModel model;
  final bool isshowarrow;
  const TeamRecordCell({Key key, this.model, this.isshowarrow = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(isshowarrow) {
          Navigator.pushNamed(context, "/teamrecorddetail", arguments: {"time": model.createTime, "title": model.businessRemark});
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, top: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(model.businessRemark, style: AppFont.textStyle(14, color: Colors.black),),
                      
                      Row(
                        children: [
                          Text("+${model.amount}", style: AppFont.textStyle(14, color: AppColor.green, fontWeight: FontWeight.bold),),
                          SizedBox(width: 4,),
                          Text("${model.coinName}", style: AppFont.textStyle(14, color: Colors.black),)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${Tool.timeFormat("MM/dd", model.createTime)} ${I18n.of(context).arriveAim} ${model.businessRemark}", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
                      Text(Tool.timeFormat("yyyy-MM-dd", model.createTime), style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isshowarrow,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image.asset("assets/icon_you.png", height: 10, color: AppColor.fontgrey,)
              ),
            )
          ],
        ),
      ),
    );
  }
}