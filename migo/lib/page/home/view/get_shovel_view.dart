import 'package:flutter/material.dart';
import 'package:migo/common/commview/gradient_text.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/home/model/home_box_model.dart';

class ShovelCellView extends StatelessWidget {
  final HomeShovelModel model;
  static const List<String> imgs = [
    "shovel_gold.png",
    "shovel_sliver.png",
    "shovel_iron.png",
  ];
  const ShovelCellView({Key key, this.model}) : super(key: key);
  
  // String _create(BuildContext context) {
  //   List<String> titles = [
  //     I18n.of(context).shovel_gold,
  //     I18n.of(context).shovel_sliver,
  //     I18n.of(context).shovel_iron,
  //   ];
  //   return titles[shovelType];
  // }

   String _getImage() {
    if(model.name.contains("金") || model.name.toLowerCase().contains("gold")) {
      return imgs[0];
    } else if(model.name.contains("银") || model.name.toLowerCase().contains("sliver")) {
      return imgs[1];
    } else {
      return imgs[2];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset("assets/${_getImage()}"),
        SizedBox(height: 10,),
        Row(
          children: [
            Text(model.name, style: AppFont.textStyle(14, color: Colors.white),),
            GradientText(
              "X${model.count}",
              gradient: LinearGradient(colors: [
                Color(0xffFFD765),
                Color(0xffFF9C00),
                Color(0xffFFF5BE)
              ]),
              style: AppFont.textStyle(14),
            )
          ],
        )
      ],
    );
  }
}