import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/model/mine_team_model.dart';
import 'package:migo/page/mine/view/mine_reward_view.dart';
import 'package:migo/page/mine/view/team_leading_detail.dart';
import 'package:migo/page/mine/view/team_share_detail.dart';

class TeamBottomView extends StatefulWidget {
  final int tabindex;
  final TeamModel model;
  const TeamBottomView({Key key, this.tabindex, this.model}) : super(key: key);

  @override
  _TeamBottomViewState createState() => _TeamBottomViewState();
}

class _TeamBottomViewState extends State<TeamBottomView> {
  
  PageController _pageController = PageController();
  double left = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(TeamBottomView oldWidget) {
    if(widget.tabindex != _pageController.page) {
      _pageController.animateToPage(widget.tabindex, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
    super.didUpdateWidget(oldWidget);
  }

  String _getLeftTitle(BuildContext context) {
    List<String> temp = [
      I18n.of(context).numberpeople,
      I18n.of(context).currtitle,
      I18n.of(context).compliancelevel
    ];
    return temp[widget.tabindex];
  }

  String _getRightTitle(BuildContext context) {
    List<String> temp = [
      I18n.of(context).totalnumberpeople,
      I18n.of(context).cumulativepledgedmining,
      I18n.of(context).seePoint
    ];
    return temp[widget.tabindex];
  }

  String _getLeftValue() {
    List<String> list = [
      "${widget.model?.shareDTO?.todayAuthUserCount ?? 0}",
      "${widget.model?.leaderDTO?.title ?? "0"}",
      "M${widget.model?.shareDTO?.userLevel ?? "0"}"
    ];
    return list[widget.tabindex];
  }

  String _getRightValue() {
    List<String> list = [
      "${widget.model?.shareDTO?.totalAuthUserCount ?? 0}",
      "${widget.model?.leaderDTO?.minTeamPledgeAmount ?? 0}",
      "${widget.model?.directDTO?.pdirectConfig?.remark ?? "暂无奖励"}"
    ];
    return list[widget.tabindex];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 130,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff23496E),
              borderRadius: BorderRadius.vertical(top: Radius.circular(8))
            ),
            padding: const EdgeInsets.only(top: 26, left: 32, right: 26),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_getLeftTitle(context), style: AppFont.textStyle(12, color: Color(0xffDBF0FF)),),
                    SizedBox(height: 10,),
                    Text(_getLeftValue(), style: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold),)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(_getRightTitle(context), style: AppFont.textStyle(12, color: Color(0xffDBF0FF)),),
                    SizedBox(height: 10,),
                    // Text(widget.tabindex == 2 ? "4-6 ${I18n.of(context).generation} \n ${I18n.of(context).everyactiveuser} 0.8MIGOs" : "0", textAlign: TextAlign.right, style: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold),)
                    Text(_getRightValue(), textAlign: TextAlign.right, style: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold),)
                  ],
                ),
              ],
            ),
          ), 
        ),
        Positioned.fill(
          top: widget.tabindex == 2 ? 107 : 88,
          child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffF3F3F3),
            borderRadius: BorderRadius.vertical(top: Radius.circular(8))
          ),
          child: PageView(
            controller: _pageController,
            children: [
              TeamShareDetailView(),
              TeamLeadingDetailView(number: widget.model?.leaderDTO?.minTeamUserCount,),
              MineRewardView()
            ],
          )
        )),
        // Positioned(
        //   left: left,
        //   child: Image.asset("assets/line_team_curre_def.png"),
        // )
      ],
    );
  }
}

