import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';

class TeamLeadingDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("我的小区", style: AppFont.textStyle(12, color: Colors.black)),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "共",
                      style: AppFont.textStyle(12, color: Colors.black)
                    ),
                    TextSpan(
                      text: "42",
                      style: AppFont.textStyle(12, color: Colors.black, fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: "人",
                      style: AppFont.textStyle(12, color: Colors.black)
                    ),
                  ]
                )
              )
            ],
          ),
        ),
        Divider(height: 30,),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 10,
            itemBuilder: (context, index){
              return _Cell(index: index + 1,);
            }
          ),
        )
      ]
    );
  }
}

class _Cell extends StatelessWidget {
  final int index;

  const _Cell({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset("assets/bg_team_area_def.png"),
                  Text("$index", style: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold),)
                ],
              ),
              SizedBox(width: 18,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("normanh***gmail.com", style: AppFont.textStyle(12, color: Colors.black),),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("团队人数", style: AppFont.textStyle(12, color: Colors.black),),
                          Text("23", style: AppFont.textStyle(12, color: Colors.black, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("大区动态收益", style: AppFont.textStyle(12, color: Colors.black),),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: "123479", style: AppFont.textStyle(12, color: AppColor.green, fontWeight: FontWeight.bold),),
                              TextSpan(text: " MICO", style: AppFont.textStyle(12, color: Colors.black),)
                            ]
                          )
                        )
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
          SizedBox(height: 16,),
          Divider(height: 1,)
        ],
      ),
    );
  }
}