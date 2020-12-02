import 'package:flutter/material.dart';
import 'package:migo/common/commview/CustomProgressView.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';

import 'home_gradient_text.dart';

class HomeDetailUserView extends StatelessWidget {
  final Function() onTap;
  final num amount;
  final String coinName;
  final int endTime;
  final int paytime;
  final String title;
  const HomeDetailUserView({Key key, this.title, this.paytime, this.endTime, this.onTap, this.coinName, this.amount,}) : super(key: key);

  Widget _create(BuildContext context) {
    if(endTime == null || endTime == 0) {
      return BtnImageBottomView(
        title: I18n.of(context).minenow,
        onTap: onTap,
      );
    } else {
      final now = DateTime.now();
      final to = DateTime.fromMillisecondsSinceEpoch(endTime);
      final todu = to.difference(DateTime.now());
      final nowdu = now.difference(DateTime.fromMillisecondsSinceEpoch(paytime));
      double progress = nowdu.inHours / (todu.inHours.toDouble() == 0 ? 1 : todu.inHours.toDouble());
      if(progress > 1) progress = 1.0;
      return CustomProgressView(titles: Tool.timeHourAndDayForNow(context,endTime), progress: progress,);
    }
  }

  Widget _createhead(BuildContext context) {
    if(endTime == null || endTime == 0) {
      return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(I18n.of(context).buy(title), style: AppFont.textStyle(
                12, 
                color: Colors.white,
                showshadow: true
              ),),
            ],
          );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(I18n.of(context).paid, style: AppFont.textStyle(
            12, 
            color: Colors.white,
            showshadow: true
          ),),
          SizedBox(width: 4,),
          HomeGradientText(
            data: "$coinName",
            fontstyle: AppFont.textStyle(
              12, 
              fontWeight: FontWeight.bold,
              showshadow: true
            ),
          )
        ],
      );
    }
  }

  Widget _createBody(BuildContext context) {
    if(endTime == null || endTime == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(I18n.of(context).pay, style: AppFont.textStyle(
            24, 
            color: Colors.white, 
            fontWeight: FontWeight.bold,
            showshadow: true
          )),
          HomeGradientText(
            data: " $amount $coinName",
            fontstyle: AppFont.textStyle(24, 
            fontWeight: FontWeight.bold,
            showshadow: true),
          ),
        ],
      );
    } else {
      return Center(
        child: HomeGradientText(
            data: " $amount $coinName",
            fontstyle: AppFont.textStyle(24, 
            fontWeight: FontWeight.bold,
            showshadow: true),
          ),
      );
    }
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
          _createhead(context),
          SizedBox(height: 12,),
          _createBody(context),
          SizedBox(height: 12,),
          _create(context)
          // CustomProgressView(titles: "12 days", progress: 0.3,)
          // CustomProgressView(titles: "12 days", issmall: true, progress: 0.3,)
        ],
      ),
    );
  }
}