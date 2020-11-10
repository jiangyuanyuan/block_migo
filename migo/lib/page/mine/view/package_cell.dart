import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/model/mine_package_model.dart';

class PackageCell extends StatelessWidget {
  final Function() onUserAction;
  final MineShovelModel model;
  const PackageCell({Key key, this.model, this.onUserAction}) : super(key: key);

  static const List<String> imgs = [
    "shovel_gold.png",
    "shovel_sliver.png",
    "shovel_iron.png",
  ];

  String _getImage() {
    if(model.toolbox.toolName.contains("金") || model.toolbox.toolName.toLowerCase().contains("gold")) {
      return imgs[0];
    } else if(model.toolbox.toolName.contains("银") || model.toolbox.toolName.toLowerCase().contains("sliver")) {
      return imgs[1];
    } else {
      return imgs[2];
    }
  }

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
                child: Image.asset("assets/${_getImage()}"),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.toolbox.toolName, style: AppFont.textStyle(12, color: Colors.white),),
                  Text("${I18n.of(context).specification}：${model.toolbox.toolSpecs}", style: AppFont.textStyle(12, color: Colors.white),),
                  Text("${I18n.of(context).production}：${model.toolbox.baseEfficiency}", style: AppFont.textStyle(12, color: Colors.white),),
                ],
              ),
              // SizedBox(width: 45,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(" ", style: AppFont.textStyle(12, color: Colors.white),),
                  Text("${I18n.of(context).durability}：${model.toolbox.durable}", style: AppFont.textStyle(12, color: Colors.white),),
                  Text("${I18n.of(context).volume}：${model.toolbox.volume}", style: AppFont.textStyle(12, color: Colors.white),),
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