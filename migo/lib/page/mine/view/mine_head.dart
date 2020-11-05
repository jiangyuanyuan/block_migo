import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:migo/page/home/view/home_gradient_text.dart';

import 'mine_action_view.dart';

class MainHeadView extends StatelessWidget {
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
      child: Column(
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
        Padding(
          padding: const EdgeInsets.only(top: 17, bottom: 10),
          child: PhysicalModel(
            color: Colors.transparent,
            shape: BoxShape.circle,
            clipBehavior: Clip.antiAlias,
            child: Image.asset("assets/default.png"),
          ),
        ),
        Text("ID：MIGO", style: AppFont.textStyle(
          14, 
          color: Colors.white, 
          fontWeight: FontWeight.bold,
          showshadow: true
        ),),
        Text("我的团队：123", style: AppFont.textStyle(
          12, 
          color: const Color(0xffDBF0FF),
          showshadow: true
        ),),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _DetailView(title: "团队总业绩(MICOs)", detail: Tool.number(5000.09, 2),),
              _DetailView(title: "日收益(MICOs)", detail: Tool.number(5000.09, 2),),
              _DetailView(title: "我的面值(MICOs)", detail: Tool.number(5000.09, 2),),
            ],
          ),
        ),

        /// mine action
        MineActionView(),
        Container(
          alignment: Alignment.centerLeft,
          color: Colors.white,
          padding: const EdgeInsets.only(left: 15.0, top: 20),
          child: Text("资产账户", style: AppFont.textStyle(14, fontWeight: FontWeight.bold),),
        )
      ],
    ),
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