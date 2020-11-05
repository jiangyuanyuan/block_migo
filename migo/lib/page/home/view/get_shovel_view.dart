import 'package:flutter/material.dart';
import 'package:migo/common/commview/gradient_text.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class ShovelCellView extends StatelessWidget {

  static const List<String> imgs = [
    "shovel_gold.png",
    "shovel_sliver.png",
    "shovel_iron.png",
  ];
  final int shovelType;
  final int number;
  const ShovelCellView({Key key, this.number, this.shovelType}) : super(key: key);
  
  String _create(BuildContext context) {
    List<String> titles = [
      I18n.of(context).shovel_gold,
      I18n.of(context).shovel_sliver,
      I18n.of(context).shovel_iron,
    ];
    return titles[shovelType];
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset("assets/${ShovelCellView.imgs[shovelType]}"),
        SizedBox(height: 10,),
        Row(
          children: [
            Text(_create(context), style: AppFont.textStyle(14, color: Colors.white),),
            GradientText(
              "X$number",
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