import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';

class AlertMineAuthView extends StatelessWidget {
  final int currNum;
  final int createtime;
  final Function onTap;
  const AlertMineAuthView({Key key, this.currNum, this.onTap, this.createtime}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 32,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/auth_success.png"),
          Padding(
            padding: const EdgeInsets.only(top: 14, bottom: 20.0),
            child: Text(I18n.of(context).reelrequestSuccess, style: AppFont.textStyle(14, color: AppColor.back998),),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xffE5F0FA),
              borderRadius: BorderRadius.circular(4)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(I18n.of(context).reelrequestcurrnumber, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                    Text("$currNum", style: AppFont.textStyle(12, color: AppColor.back998),),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(I18n.of(context).date, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5))),
                      Text(Tool.timeFormat("yyyy-MM-dd", createtime), style: AppFont.textStyle(12, color: AppColor.back998),),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(I18n.of(context).time, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5))),
                    Text(Tool.timeFormat("HH:mm:ss", createtime), style: AppFont.textStyle(12, color: AppColor.back998),),
                  ],
                ),
              ],
            ),
          ),
          BtnImageBottomView(
            title: I18n.of(context).sure,
            onTap: () {
              onTap();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}