import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/home/view/home_gradient_text.dart';
import 'package:migo/page/mine/model/me_model.dart';
import 'package:migo/page/mine/view/headdetail_view.dart';
import 'package:migo/provider/user.dart';
import 'package:provider/provider.dart';

import 'mine_action_view.dart';

class MainHeadView extends StatelessWidget {
  final MeModel model;

  const MainHeadView({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/背景图.png"),
          fit: BoxFit.cover
        ),
      ),
      child: Consumer<UserModel>(builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 42,),
                  Image.asset("assets/logo.png", height: 20,),
                  IconButton(
                    icon: Image.asset("assets/mine_setting.png"),
                    onPressed: () => Navigator.pushNamed(context, "/setting"),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, "/mod"),
              child: Container(
                padding: const EdgeInsets.only(top: 17, bottom: 10),
                child: PhysicalModel(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  clipBehavior: Clip.antiAlias,
                  child: value.data.logo == null ? Image.asset("assets/default.png") : Image.network(value.data.logo, height: 76, width: 76, fit: BoxFit.fill,),
                ),
              ),
            ),
            Text("${value.data.mobile != null ? value.data.mobile : value.data.email}", style: AppFont.textStyle(
              14, 
              color: Colors.white, 
              fontWeight: FontWeight.bold,
              showshadow: true
            ),),
            Text("${value.data.nickName ?? "--"}", style: AppFont.textStyle(
              14, 
              color: Colors.white, 
              showshadow: true
            ),),
            Text("${I18n.of(context).myteam}：${model?.teamUserCount ?? 0}", style: AppFont.textStyle(
              12, 
              color: const Color(0xffDBF0FF),
              showshadow: true
            ),),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeadDetailView(title: "${I18n.of(context).teamperformance}(MIGO)", detail: Tool.number(model?.totalTeamUserAmount, 2),),
                  HeadDetailView(title: "${I18n.of(context).yearterdayoutput}(MIGO)", detail: Tool.number(model?.todayProfit, 2),),
                  HeadDetailView(title: "${I18n.of(context).yearterdayoutput}(MIGOs)", detail: Tool.number(model?.faceValue, 2),),
                ],
              ),
            ),

            /// mine action
            MineActionView(),
            Container(
              alignment: Alignment.centerLeft,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 19, top: 19, bottom: 19),
                    child: Text(I18n.of(context).assetaccount, style: AppFont.textStyle(14, fontWeight: FontWeight.bold),),
                  ),
                  Divider(height: 1)
                ],
              ),
            ),
          ],
        );
      },)
    );
  }
}


class LevelView extends StatelessWidget {
  final String img;
  final String titles;

  const LevelView({Key key, this.img, this.titles}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.account_circle, size: 20,),
        Text(titles)
      ],
    );
  }
}