import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/home/view/home_gradient_text.dart';
import 'package:migo/page/mine/model/me_model.dart';
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
                height: 86, width: 86,
                child: PhysicalModel(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  clipBehavior: Clip.antiAlias,
                  child: value.data.logo == null ? Image.asset("assets/default.png") : Image.network(value.data.logo),
                ),
              ),
            ),
            Text("ID：${value.data.id.toString().substring(11)}", style: AppFont.textStyle(
              14, 
              color: Colors.white, 
              fontWeight: FontWeight.bold,
              showshadow: true
            ),),
            Text("${I18n.of(context).myteam}：${value.data.nickName}", style: AppFont.textStyle(
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
                  _DetailView(title: "${I18n.of(context).teamperformance}(MICOs)", detail: Tool.number(model?.totalTeamUserAmount, 2),),
                  _DetailView(title: "${I18n.of(context).dailyoutput}(MICOs)", detail: Tool.number(0.0, 2),),
                  _DetailView(title: "${I18n.of(context).dayincome}(MICOs)", detail: Tool.number(model?.todayProfit, 2),),
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

class _DetailView extends StatelessWidget {
  final String title;
  final String detail;

  const _DetailView({Key key, this.title, this.detail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppFont.textStyle(
            12, 
            color: const Color(0xffDBF0FF),
            showshadow: true
          ),
        ),
        SizedBox(height: 8,),
        HomeGradientText(
          data: detail,
          fontstyle: AppFont.textStyle(
            16, 
            fontWeight: FontWeight.bold,
            showshadow: true
          ),
        )
      ],
    );
  }
}