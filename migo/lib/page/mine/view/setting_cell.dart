import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:flutter/material.dart';

class SettingCell extends StatelessWidget {
  
  final String title;
  final String detail;
  final Function onTap;
  final Color detailColor;
  final bool showArrowIcon;

  const SettingCell({
    Key key, 
    this.title, 
    this.detail = "", 
    this.onTap,
    this.showArrowIcon = true,
    this.detailColor = AppColor.fontgrey
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/input_back.png"),
            fit: BoxFit.fill
          )
        ),
        child: Container(
          color: const Color(0xffFEE1BF),
          margin: const EdgeInsets.all(5.5),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: <Widget>[
                    Text(title, style: AppFont.textStyle(16, color: AppColor.font333),),
                    Spacer(),
                    Text(detail, style: AppFont.textStyle(16, color: detailColor),),
                    SizedBox(width: 10,),
                    Visibility(
                      visible: showArrowIcon,
                      child: Image.asset("assets/icon_you.png")
                    )
                  ],
                ),
              ),
              SizedBox(height: 1, child: Divider(indent: 15, endIndent: 15,))
            ],
          ),
        ),
      ),
    );
  }
}