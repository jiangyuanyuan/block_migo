import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class PackageCell extends StatelessWidget {
  final Function() onUserAction;

  const PackageCell({Key key, this.onUserAction}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
      padding: const EdgeInsets.only(top: 19),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/Image.png"),
          fit: BoxFit.fill
        )
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Image.asset("assets/shovel_gold.png"),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(I18n.of(context).shovel_gold, style: AppFont.textStyle(12, color: Colors.white),),
                  Text("${I18n.of(context).specification}：8500", style: AppFont.textStyle(12, color: Colors.white),),
                  Text("${I18n.of(context).production}：1.35", style: AppFont.textStyle(12, color: Colors.white),),
                ],
              ),
              // SizedBox(width: 45,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(" ", style: AppFont.textStyle(12, color: Colors.white),),
                  Text("${I18n.of(context).durability}：8500", style: AppFont.textStyle(12, color: Colors.white),),
                  Text("${I18n.of(context).volume}：1.35", style: AppFont.textStyle(12, color: Colors.white),),
                ],
              )
            ],
          ),
          BtnImageBottomView(
            title: I18n.of(context).use,
            onTap: onUserAction,
          )
        ],
      ),
    );
  }
}