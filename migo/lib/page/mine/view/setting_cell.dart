import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:flutter/material.dart';

class SettingCell extends StatelessWidget {
  
  final String title;
  final String detail;
  final Function onTap;
  final Color detailColor;
  final bool showArrowIcon;
  final String rightIconName;
  const SettingCell({
    Key key, 
    this.title, 
    this.detail = "", 
    this.onTap,
    this.rightIconName = "ico_list_arrow_def.png",
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
            image: AssetImage("assets/bg_list_sett_def.png"),
            fit: BoxFit.fill
          )
        ),
        margin: const EdgeInsets.only(bottom: 10),
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
                    child: Image.asset("assets/$rightIconName")
                  )
                ],
              ),
            ),
            SizedBox(height: 1, child: Divider(indent: 15, endIndent: 15,))
          ],
        ),
      ),
    );
  }
}