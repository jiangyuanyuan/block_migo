import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/home/view/home_gradient_text.dart';
import 'package:migo/page/mine/model/mine_team_model.dart';
import 'package:migo/page/mine/view/team_bottom_view.dart';

import 'mine_team_tab.dart';

class TeamHeadView extends StatelessWidget {
  final Function(int sender) onTapIndex;
  final int tabindex;
  final TeamModel model;
  const TeamHeadView({Key key, this.model, this.tabindex, this.onTapIndex}) : super(key: key);

  List<String> _tags(BuildContext context) {
    return [
      I18n.of(context).teamgroupshare,
      // I18n.of(context).teamgroupleader,
      I18n.of(context).teammoney,
      I18n.of(context).seePoint,
    ];
  }

  // String _getLeftTitle(BuildContext context) {
  //   List<String> temp = [
  //     I18n.of(context).numberpeople,
  //     I18n.of(context).currtitle,
  //     I18n.of(context).compliancelevel
  //   ];
  //   return temp[tabindex];
  // }

  // String _getRightTitle(BuildContext context) {
  //   List<String> temp = [
  //     I18n.of(context).totalnumberpeople,
  //     I18n.of(context).cumulativepledgedmining,
  //     I18n.of(context).seePoint
  //   ];
  //   return temp[tabindex];
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 42,),
        Text(I18n.of(context).lasetteamvalue + "(MIGO)", style: AppFont.textStyle(12, color: const Color(0xffDBF0FF), showshadow: true),),
        Padding(
          padding: const EdgeInsets.only(top:10.0, bottom: 20),
          child: HomeGradientText(data: "+${Tool.number(model?.yesterdayTeamAmount, 2)}", fontstyle: AppFont.textStyle(24, color: Colors.white, fontWeight: FontWeight.bold),),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text("${I18n.of(context).totalteamvalue}(MIGO)", style: AppFont.textStyle(12, color: const Color(0xffDBF0FF), showshadow: true),),
                  SizedBox(height: 10,),
                  HomeGradientText(data: "+${Tool.number(model?.totalTeamAmount, 2)}", fontstyle: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold, showshadow: true),),
                ],
              ),
              Column(
                children: [
                  Text("${I18n.of(context).teamstaticvalue}(MIGO)", style: AppFont.textStyle(12, color: const Color(0xffDBF0FF), showshadow: true),),
                  SizedBox(height: 10,),
                  HomeGradientText(data: "+${Tool.number(model?.minTeamAmount, 2)}", fontstyle: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold, showshadow: true),),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:30, left: 28, right: 28.0),
          child: Stack(
            children: [
              Image.asset("assets/img_team_join_def.png", width: double.infinity, fit: BoxFit.fill),
              Positioned(
                right: 30,
                top: 22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(I18n.of(context).totalnotice, style: AppFont.textStyle(12, fontWeight: FontWeight.bold, color: Colors.white),),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, "/teamearth"),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset("assets/btn_team_join_def.png"),
                          Text(I18n.of(context).teamjoin, style: AppFont.textStyle(12, color: Colors.white, showshadow: true),)
                        ],
                      ),
                    )
                  ],
                )
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 40.0),
          child: MineTeamTabarView(
            titles: _tags(context),
            isscrolll: false,
            onTabIndex: onTapIndex,
          ),
        ),

        // Container(
        //   decoration: BoxDecoration(
        //     color: const Color(0xff23496E),
        //     borderRadius: BorderRadius.vertical(top: Radius.circular(8))
        //   ),
        //   padding: const EdgeInsets.only(top: 26, left: 32, right: 26),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(_getLeftTitle(context), style: AppFont.textStyle(12, color: Color(0xffDBF0FF)),),
        //           SizedBox(height: 10,),
        //           Text("0", style: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold),)
        //         ],
        //       ),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.end,
        //         children: [
        //           Text(_getRightTitle(context), style: AppFont.textStyle(12, color: Color(0xffDBF0FF)),),
        //           SizedBox(height: 10,),
        //           // Text(widget.tabindex == 2 ? "4-6 ${I18n.of(context).generation} \n ${I18n.of(context).everyactiveuser} 0.8MIGOs" : "0", textAlign: TextAlign.right, style: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold),)
        //           Text(tabindex == 2 ? "暂无奖励" : "0", textAlign: TextAlign.right, style: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold),)
        //         ],
        //       ),
        //     ],
        //   ),
        // ), 

        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.5,
        //   child: TeamBottomView(tabindex: tabIndex,)
        // )
      ],
    );
  }
}