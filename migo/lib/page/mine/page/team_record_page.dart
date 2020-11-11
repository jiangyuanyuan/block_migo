import "package:flutter/material.dart";
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/view/mine_team_tab.dart';

class TeamRecordPage extends StatefulWidget {
  @override
  _TeamRecordPageState createState() => _TeamRecordPageState();
}

class _TeamRecordPageState extends State<TeamRecordPage> {

  int tabIndex = 0;
  List<String> _tags() {
    return [
      I18n.of(context).all,
      I18n.of(context).teamgroupshare,
      I18n.of(context).teamgroupleader,
      I18n.of(context).teamgrouppush,
      I18n.of(context).minedividends
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).teamearnrecord,
        onPop: () => Navigator.pop(context),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: MineTeamTabarView(
                titles: _tags(),
                isscrolll: true,
                onTabIndex: (sender) {
                  setState(() {
                    tabIndex = sender;
                  });
                },
              ),
            ),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.divigrey,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8))
                ),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemBuilder: (context, index) {
                    return _Cell();
                  }, 
                  separatorBuilder: (context, index) => Divider(height: 1, color: const Color(0xffD8D8D8),), 
                  itemCount: 0
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("分享奖励", style: AppFont.textStyle(14, color: Colors.black),),
              
              Row(
                children: [
                  Text("+39", style: AppFont.textStyle(14, color: AppColor.green, fontWeight: FontWeight.bold),),
                  SizedBox(width: 4,),
                  Text("MICOs", style: AppFont.textStyle(14, color: Colors.black),)
                ],
              )
            ],
          ),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("10/15达标领导奖励", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
              Text("2020/10/28 22:57", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
            ],
          )
        ],
      ),
    );
  }
}