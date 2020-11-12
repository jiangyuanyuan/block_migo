import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/model/mine_team_model.dart';

class TeamLeadingDetailView extends StatelessWidget {
  final int number;
  final List<SubordinateLeaderDTOModel> subordinateLeaderDTOList;
  const TeamLeadingDetailView({Key key, this.number, this.subordinateLeaderDTOList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(I18n.of(context).mycommunity, style: AppFont.textStyle(12, color: Colors.black)),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: I18n.of(context).teamleadertotal,
                      style: AppFont.textStyle(12, color: Colors.black)
                    ),
                    TextSpan(
                      text: "$number ",
                      style: AppFont.textStyle(12, color: Colors.black, fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: I18n.of(context).peopleintotal,
                      style: AppFont.textStyle(12, color: Colors.black)
                    ),
                  ]
                )
              )
            ],
          ),
        ),
        Divider(height: 30,),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: subordinateLeaderDTOList.length,
            itemBuilder: (context, index){
              final model = subordinateLeaderDTOList[index];
              return _Cell(index: index + 1, model: model,);
            }
          ),
        )
      ]
    );
  }
}

class _Cell extends StatelessWidget {
  final int index;
  final SubordinateLeaderDTOModel model;
  const _Cell({Key key, this.index, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset("assets/bg_team_area_def.png"),
                  Text("$index", style: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold),)
                ],
              ),
              SizedBox(width: 18,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${model.userNumber}", style: AppFont.textStyle(12, color: Colors.black),),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(I18n.of(context).teamnumber, style: AppFont.textStyle(12, color: Colors.black),),
                          Text("${model.maxTeamAmount}", style: AppFont.textStyle(12, color: Colors.black, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(I18n.of(context).dynamicincome, style: AppFont.textStyle(12, color: Colors.black),),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: "${model.maxTeamAmount}", style: AppFont.textStyle(12, color: AppColor.green, fontWeight: FontWeight.bold),),
                              TextSpan(text: " MIGO", style: AppFont.textStyle(12, color: Colors.black),)
                            ]
                          )
                        )
                      ],
                    ),
                  ],
                ),
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