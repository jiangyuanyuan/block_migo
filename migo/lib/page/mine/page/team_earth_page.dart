import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/home/view/home_gradient_text.dart';
import 'package:migo/page/mine/model/team_earth_model.dart';
import 'package:migo/page/mine/view/mine_team_tab.dart';

class TeamEarthPage extends StatefulWidget {
  @override
  _TeamEarthPageState createState() => _TeamEarthPageState();
}

class _TeamEarthPageState extends State<TeamEarthPage> {


  int tabindex = 0;
  TeamEarthModel _earthModel;
  @override
  void initState() {
    super.initState();
    _request();
  }

  void _request() {
    Networktool.request(API.poolBonusPage, success: (data) {
      final temp = TeamEarthResponse.fromJson(data).data;
      _earthModel = temp;
      if(mounted) setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).earthmoney,
        onPop: () => Navigator.pop(context),
        actions: [
          IconButton(
            icon: Image.asset("assets/ico_incom_hist_def.png"),
            onPressed: () {
              Navigator.pushNamed(context, "/teamrecord");
            },
          )
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("${I18n.of(context).mineaddgrade}(MIGOs)", style: AppFont.textStyle(12, color: const Color(0xffDBF0FF), showshadow: true),),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 20),
              child: HomeGradientText(data: "${_earthModel?.newAmount ?? 00}", fontstyle: AppFont.textStyle(24, color: Colors.white, fontWeight: FontWeight.bold, showshadow: true),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(I18n.of(context).startdate, style: AppFont.textStyle(12, color: const Color(0xffDBF0FF), showshadow: true),),
                      SizedBox(height: 10,),
                      HomeGradientText(data: "${_earthModel?.startToEndTime ?? 0}", fontstyle: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold, showshadow: true),),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(I18n.of(context).getmoneydate, style: AppFont.textStyle(12, color: const Color(0xffDBF0FF), showshadow: true),),
                      SizedBox(height: 10,),
                      HomeGradientText(data: "${_earthModel?.bonusStartToEndTime ?? 0}", fontstyle: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold, showshadow: true),),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: const Color(0xff23496E),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 52,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 31.0),
                            child: Text(I18n.of(context).teamdetail, style: AppFont.textStyle(14, color: Colors.white),),
                          ),
                          Spacer(),
                          MineTeamTabarView(
                            onTabIndex: (sender) {
                              setState(() {
                                tabindex = sender;
                              });
                            },
                            titles: [I18n.of(context).minepush, I18n.of(context).mineumbrella], isscrolll: true,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                        child: Column(
                          children: [
                            _Cell(left: tabindex == 0 ? I18n.of(context).minepushanumber : I18n.of(context).mineumbrellanumber, right: "${tabindex == 0 ? _earthModel?.myDirectDTO?.userCount : _earthModel?.mySubordinateDTO?.subordinateUserCount}",),
                            SizedBox(height: 16,),
                            _Cell(left: I18n.of(context).realuser, right: "${tabindex == 0 ? _earthModel?.myDirectDTO?.authUserCount : _earthModel?.mySubordinateDTO?.subordinateAuthUserCount}",),
                            SizedBox(height: 16,),
                            _Cell(left: "${I18n.of(context).weakaddMEGO}MEGO", right: "${tabindex == 0 ? _earthModel?.myDirectDTO?.thisWeekAmount : _earthModel?.mySubordinateDTO?.thisWeekSubordinateAmount}",),
                            SizedBox(height: 16,),
                            _Cell(left: "${I18n.of(context).allmego}MEGO", right: "${tabindex == 0 ? _earthModel?.myDirectDTO?.totalAmount : _earthModel?.mySubordinateDTO?.totalSubordinateAmount}",),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  final String left;
  final String right;

  const _Cell({Key key, this.left, this.right}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left, style: AppFont.textStyle(16, color: Colors.black),),
        Text(right == "null" ? "0" : right, style: AppFont.textStyle(16, color: Colors.black.withOpacity(0.5)),),
      ],
    );
  }
}
