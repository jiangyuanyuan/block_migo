import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class MineTeamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).myteam,
        onPop: () => Navigator.pop(context),
        actions: [
          IconButton(
            icon: Image.asset("assets/ico_incom_hist_def.png"),
            onPressed: () {

            },
          )
        ],
        child: Column(
          children: [
            SizedBox(height: 42,),
            Text("昨日团队收益价值(MICOs)", style: AppFont.textStyle(12, color: const Color(0xff816C65)),),
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
                      Text("总收益价值(MICOs)", style: AppFont.textStyle(12, color: const Color(0xff816C65)),),
                      SizedBox(height: 10,),
                      Text("+9000.56", style: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Column(
                    children: [
                      Text("小区静态产出(MICOs)", style: AppFont.textStyle(12, color: const Color(0xff816C65)),),
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
                        Text("建立自己团队的矿场\n参与MIGO矿池分红", style: AppFont.textStyle(14, fontWeight: FontWeight.bold, color: Colors.white),),
                        SizedBox(height: 10,),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset("assets/btn_team_join_def.png"),
                            Text("立即参与", style: AppFont.textStyle(12, color: Colors.white),)
                          ],
                        )
                      ],
                    )
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}