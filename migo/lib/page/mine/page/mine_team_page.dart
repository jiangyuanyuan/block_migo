import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/view/mine_team_tab.dart';
import 'package:migo/page/mine/view/team_bottom_view.dart';

class MineTeamPage extends StatefulWidget {
  @override
  _MineTeamPageState createState() => _MineTeamPageState();
}

class _MineTeamPageState extends State<MineTeamPage> {
  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).myteam,
        leading: SizedBox(),
        actions: [
          IconButton(
            icon: Image.asset("assets/ico_incom_hist_def.png"),
            onPressed: () {

            },
          )
        ],
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 1.1,
            child: Column(
              children: [
                SizedBox(height: 42,),
                Text(I18n.of(context).lasetteamvalue + "(MICOs)", style: AppFont.textStyle(12, color: const Color(0xff816C65)),),
                Padding(
                  padding: const EdgeInsets.only(top:10.0, bottom: 20),
                  child: Text("+9000.56", style: AppFont.textStyle(24, color: Colors.white, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("${I18n.of(context).totalteamvalue}(MICOs)", style: AppFont.textStyle(12, color: const Color(0xff816C65)),),
                          SizedBox(height: 10,),
                          Text("+9000.56", style: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Column(
                        children: [
                          Text("${I18n.of(context).teamstaticvalue}(MICOs)", style: AppFont.textStyle(12, color: const Color(0xff816C65)),),
                          SizedBox(height: 10,),
                          Text("2000.28", style: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold),),
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
                            Text(I18n.of(context).totalnotice, style: AppFont.textStyle(14, fontWeight: FontWeight.bold, color: Colors.white),),
                            SizedBox(height: 10,),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset("assets/btn_team_join_def.png"),
                                Text(I18n.of(context).teamjoin, style: AppFont.textStyle(12, color: Colors.white),)
                              ],
                            )
                          ],
                        )
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: MineTeamTabarView(
                    onTabIndex: (sender) {
                      setState(() {
                        tabIndex = sender;
                      });
                    },
                  ),
                ),
                Expanded(child: TeamBottomView(tabindex: tabIndex,))
              ],
            ),
          ),
        ),
      ),
    );
  }
}