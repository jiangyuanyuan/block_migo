import 'package:migo/common/util/tool.dart';
import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:flutter/material.dart';

import 'mine_action_view.dart';

class MainHeadView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: AppColor.blue,
          height: 250,
          child: Column(
            children: [
              SizedBox(height: 30),
              InkWell(
                onTap: () => Navigator.pushNamed(context, "/mod"),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image.asset("default.png")
                    Container(
                      height: 60,
                      width: 60,
                      margin: const EdgeInsets.only(top: 40, left: 15),
                      color: Colors.yellow,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("小脑虎"),
                          Row(
                            children: [
                              LevelView(titles: "等级",),
                              SizedBox(width: 20,),
                              LevelView(titles: "称号",),
                            ],
                          ),
                          LevelView(titles: "我的团队",),
                        ],
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.menu),
                      padding: EdgeInsets.only(top: 15),
                      onPressed: () {
                        Navigator.pushNamed(context, "/setting");
                      },
                    )
                  ],
                ),
              ),

              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _DetailView(title: "团队总业绩(MICOs)", detail: Tool.number(5000.09, 2),),
                  _DetailView(title: "日收益(MICOs)", detail: Tool.number(5000.09, 2),),
                  _DetailView(title: "我的面值(MICOs)", detail: Tool.number(5000.09, 2),),
                ],
              )
            ],
          ),
        ),

        /// mine action
        MineActionView(),
        Container(height: 100, color: Colors.red,),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 20),
          child: Text("资产账户", style: AppFont.textStyle(14, fontWeight: FontWeight.bold),),
        )
      ],
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
      children: [
        Text(title),
        Text(detail)
      ],
    );
  }
}