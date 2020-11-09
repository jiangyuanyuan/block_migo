import 'package:flutter/material.dart';
import 'package:migo/common/commview/CustomProgressView.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

import 'home_gradient_text.dart';

class HomeDetailUserView extends StatelessWidget {
  final Function() onTap;

  const HomeDetailUserView({Key key, this.onTap}) : super(key: key);

  String _getString(BuildContext context) {
    List<String> titles = [
      I18n.of(context).shovel_gold,
      I18n.of(context).shovel_sliver,
      I18n.of(context).shovel_iron,
    ];
    return I18n.of(context).homeused + " " + titles[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.only(top: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/home_borad.png"),
          fit: BoxFit.fill
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_getString(context), style: AppFont.textStyle(
                12, 
                color: Colors.white,
                showshadow: true
              ),),
              SizedBox(width: 4,),
              HomeGradientText(
                data: "X1",
                fontstyle: AppFont.textStyle(
                  12, 
                  fontWeight: FontWeight.bold,
                  showshadow: true
                ),
              ),
            ],
          ),
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(I18n.of(context).obtain, style: AppFont.textStyle(
                24, 
                color: Colors.white, 
                fontWeight: FontWeight.bold,
                showshadow: true
              ),),
              HomeGradientText(
                data: " 60 MIGOs",
                fontstyle: AppFont.textStyle(24, 
                fontWeight: FontWeight.bold,
                showshadow: true),
              ),
            ],
          ),
          BtnImageBottomView(
            title: I18n.of(context).minenow,
            onTap: onTap,
          ),
          // CustomProgressView(titles: "12 days", progress: 0.3,)
          // CustomProgressView(titles: "12 days", issmall: true, progress: 0.3,)
        ],
      ),
    );
  }
}