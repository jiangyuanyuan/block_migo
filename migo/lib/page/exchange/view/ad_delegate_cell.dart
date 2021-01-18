import 'package:flutter/material.dart';

import '../../../common/textstyle/textstyle.dart';

import '../../../common/const/cosnt.dart';
import '../../../common/util/tool.dart';
import '../../../generated/i18n.dart';
import '../model/otc_order_model.dart';

class AdDelegateCell extends StatelessWidget {
  final MyAdDelegateModel model;
  final int orderType;
  const AdDelegateCell({Key key, this.model, this.orderType}) : super(key: key);
  Color _getColor() {
    switch (model.status) {
      case 1:
        return AppColor.red;
        break;
      case 2:
        return AppColor.back998;
      case 3:
        return AppColor.green;
      default:
        return AppColor.fontgrey;
    }
  }
  Color _getBackColor() {
    switch (model.status) {
      case 1:
        return const Color(0xffFCF2F3);
        break;
      case 2:
        return const Color(0xffF4F7FA);
        break;
      case 3:
        return const Color(0xffF2FBF4);
      case 4:
        return Colors.black.withOpacity(0.05);
        break;
      default:
        return Colors.black12;
    }
  }

  Widget _createStatus(BuildContext context) {
    switch (model.status) {
      case 1:
        return Text(I18n.of(context).waitbuy, style: AppFont.textStyle(12, color: _getColor()),);
        break;
      case 2:
        return Text(I18n.of(context).buying, style: AppFont.textStyle(12, color: _getColor()),);
        break;
      case 3:
        return Text(I18n.of(context).rfinish, style: AppFont.textStyle(12, color: _getColor()),);
        break;
      default:
        return Text(I18n.of(context).rnotfinish, style: AppFont.textStyle(12, color: _getColor()),);
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
                Text(orderType == 1 ? I18n.of(context).rbuy : I18n.of(context).rsell, style: AppFont.textStyle(14, color: _getColor(), fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                Text(Tool.timeFormat("yyyy-MM-dd HH:mm", model.createTime), style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                Spacer(),
                _createStatus(context)
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
                    Text((orderType == 1 ? I18n.of(context).buynumber : I18n.of(context).sellnumber) + " (MIGO)", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                    Text((orderType == 1 ? I18n.of(context).buyamout : I18n.of(context).sellamount)  + "(USDT)", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                    // Text(Tool.number(amount, 2), style: AppFont.textStyle(12, color: Colors.black),)
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Tool.number(model.orderNumber, 2), style: AppFont.textStyle(12, color: AppColor.back998),),
                    Text(Tool.number(model.orderNumber * model.orderPrice, 2), style: AppFont.textStyle(12, color: AppColor.back998),),
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(I18n.of(context).exorderno, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                    Text(I18n.of(context).subtime, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                    // Text(Tool.number(amount, 2), style: AppFont.textStyle(12, color: Colors.black),)
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(model.adNo, style: AppFont.textStyle(12, color: AppColor.back998),),
                    Text(Tool.timeFormat("yyyy-MM-dd HH:mm", model.createTime), style: AppFont.textStyle(12, color: AppColor.back998),),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}