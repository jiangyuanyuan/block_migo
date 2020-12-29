import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';

class ExchangeRecordCell extends StatelessWidget {

  Color _getColor() {
    switch (0) {
      case 0:
        return AppColor.back998;
        break;
      case 3:
        return AppColor.green;
        break;
      default:
        return AppColor.red;
    }
  }
  Color _getBackColor() {
    switch (0) {
      case 0:
        return const Color(0xffF4F7FA);
        break;
      case 3:
        return const Color(0xffF2FBF4);
        break;
      default:
        return const Color(0xffFCF2F3);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            height: 40,
            color: _getBackColor(),
            child: Row(
              children: [
                Text(I18n.of(context).rsell, style: AppFont.textStyle(14, color: _getColor(), fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                Text(Tool.timeFormat("yyyy-MM-dd HH:mm", 0), style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                Spacer(),
                Text(I18n.of(context).rnotpay, style: AppFont.textStyle(12, color: _getColor()),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(I18n.of(context).number + "(MIGO)", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                    Text(I18n.of(context).totalprice + "(MIGO)", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                    // Text(Tool.number(amount, 2), style: AppFont.textStyle(12, color: Colors.black),)
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Tool.number(100, 2), style: AppFont.textStyle(12, color: AppColor.back998),),
                    Text(Tool.number(100, 2), style: AppFont.textStyle(12, color: AppColor.back998),),
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(I18n.of(context).exorderno + "(USDT)", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                    Text(I18n.of(context).subtime, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                    // Text(Tool.number(amount, 2), style: AppFont.textStyle(12, color: Colors.black),)
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("asdjlfkjaslk", style: AppFont.textStyle(12, color: AppColor.back998),),
                    Text("2019-09-09", style: AppFont.textStyle(12, color: AppColor.back998),),
                  ],
                ),
                BtnImageBottomView(
                  title: I18n.of(context).rsurepay,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}