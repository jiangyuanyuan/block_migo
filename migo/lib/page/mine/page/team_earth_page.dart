import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/page/mine/view/mine_team_tab.dart';

class TeamEarthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: "全球矿池分红",
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
            Text("我的新增业绩(MICOs)", style: AppFont.textStyle(12, color: const Color(0xff816C65)),),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 20),
              child: Text("37983", style: AppFont.textStyle(24, color: Colors.white, fontWeight: FontWeight.bold, showshadow: true),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("起止日期", style: AppFont.textStyle(12, color: const Color(0xff816C65)),),
                      SizedBox(height: 10,),
                      Text("10/15~10/30", style: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold, showshadow: true),),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("分红日期", style: AppFont.textStyle(12, color: const Color(0xff816C65)),),
                      SizedBox(height: 10,),
                      Text("10/20~10/30", style: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold, showshadow: true),),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Color(0xff4B7897).withOpacity(0.01), Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                ),
                child: Column(
                  children: [
                    MineTeamTabarView(titles: ["团队概况", "我的直推"],),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                        child: Column(
                          children: [
                            _Cell(left: "我的直推人数", right: "100",),
                            SizedBox(height: 16,),
                            _Cell(left: "有效用户数", right: "2020/10/28 22:57",),
                            SizedBox(height: 16,),
                            _Cell(left: "本周新增质押MEGO", right: "373.34343432",),
                            SizedBox(height: 16,),
                            _Cell(left: "累计质押MEGO", right: "1373.34343432",),
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
        Text(right, style: AppFont.textStyle(16, color: Colors.black.withOpacity(0.5)),),
      ],
    );
  }
}
