import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class TeamShareDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 24),
            child: Text(I18n.of(context).sharerewards, style: AppFont.textStyle(12, color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _Cell(index: 0, showlevel: true,),
                _Cell(index: 1,),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BtnImageBottomView(
                title: I18n.of(context).invite,
                onTap: () => Navigator.pushNamed(context, "/invite"),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  final bool showlevel;
  final int index;
  const _Cell({Key key, this.index, this.showlevel = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 104,
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg_list_price_def.png"),
              fit: BoxFit.fill
            )
          ),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 80,
                margin: const EdgeInsets.only(right: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffF7C28A),
                  shape: BoxShape.circle
                ),
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xffFEE1BF),
                    shape: BoxShape.circle,
                    border: Border.all(width: 4, color: const Color(0xff654248))
                  ),
                  alignment: Alignment.center,
                  child: Text("M$index", style: AppFont.textStyle(24, color: const Color(0xff654248), fontWeight: FontWeight.bold),),
                ),
              ),

              Text(
                index == 1 ? "${I18n.of(context).enjoy}1 ${I18n.of(context).generation} \n20% ${I18n.of(context).reward}" : "暂无奖励", 
                textAlign: TextAlign.left, 
                style: AppFont.textStyle(
                  16, 
                  color: const Color(0xff654248), 
                  fontWeight: FontWeight.bold
                ),)
            ],
          ),
        ),
        Positioned(
          left: 23,
          child: Visibility(
            visible: showlevel,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset("assets/bg_price_level_def.png"),
                Text(I18n.of(context).currentlevel, style: AppFont.textStyle(12, color: Colors.white),)
              ],
            ),
          ),
        )
      ],
    );
  }
}