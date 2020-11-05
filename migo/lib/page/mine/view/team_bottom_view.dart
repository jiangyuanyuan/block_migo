import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/page/mine/view/mine_reward_view.dart';
import 'package:migo/page/mine/view/team_leading_detail.dart';
import 'package:migo/page/mine/view/team_share_detail.dart';

class TeamBottomView extends StatefulWidget {
  final int tabindex;

  const TeamBottomView({Key key, this.tabindex}) : super(key: key);

  @override
  _TeamBottomViewState createState() => _TeamBottomViewState();
}

class _TeamBottomViewState extends State<TeamBottomView> {
  
  PageController _pageController = PageController();
  double left = 0;
  @override
  void initState() {
    super.initState();
    // _pageController.addListener(() {
    //   _changeOffset(_pageController.page);
    // });
    // left = (ScreenUtil.screenWidthDp / 3 / 2) - 15;
  }

  // void _changeOffset(double offset) {
  //   setState(() {
  //     left = ScreenUtil.screenWidthDp / 3 * (offset) + ScreenUtil.screenWidthDp / 3 / 2 - 15;
  //   });
  // }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String _getLeftTitle(BuildContext context) {
    List<String> temp = [
      "今日完成认证人数",
      "目前称号",
      "达标等级"
    ];
    return temp[widget.tabindex];
  }

  String _getRightTitle(BuildContext context) {
    List<String> temp = [
      "累积完成认证人数",
      "小区累计质押挖矿",
      "见点奖励"
    ];
    return temp[widget.tabindex];
  }

  @override
  void didUpdateWidget(TeamBottomView oldWidget) {
    if(widget.tabindex != _pageController.page) {
      _pageController.animateToPage(widget.tabindex, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
    super.didUpdateWidget(oldWidget);
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
              color: Colors.red,
              gradient: LinearGradient(
              colors: [Colors.transparent, Color(0xff4B7897).withOpacity(0.01), Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
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
                    Text("17", style: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold),)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(_getRightTitle(context), style: AppFont.textStyle(12, color: Color(0xffDBF0FF)),),
                    SizedBox(height: 10,),
                    Text(widget.tabindex == 2 ? "4-6代 \n 每个有效用户0.8MIGOs" : "190", textAlign: TextAlign.right, style: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold),)
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
              TeamLeadingDetailView(),
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

