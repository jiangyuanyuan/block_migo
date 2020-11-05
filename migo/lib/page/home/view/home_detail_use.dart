import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/textstyle/textstyle.dart';

import 'home_gradient_text.dart';

class HomeDetailUserView extends StatelessWidget {
  final Function() onTap;

  const HomeDetailUserView({Key key, this.onTap}) : super(key: key);
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
              Text("已使用 铜铲子", style: AppFont.textStyle(12, color: Colors.white),),
              SizedBox(width: 4,),
              HomeGradientText(
                data: "1个",
                fontstyle: AppFont.textStyle(12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("获得", style: AppFont.textStyle(24, color: Colors.white, fontWeight: FontWeight.bold),),
              HomeGradientText(
                data: " 60 MIGOs",
                fontstyle: AppFont.textStyle(24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          BtnImageBottomView(
            title: "立即挖矿",
            onTap: onTap,
          )
        ],
      ),
    );
  }
}