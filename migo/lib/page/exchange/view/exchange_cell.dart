import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class ExchangeCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 40,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 24),
            color: const Color(0xffF4F7FA),
            child: Row(
              children: [
                Text(I18n.of(context).exorderno, style: AppFont.textStyle(14, color: AppColor.back998, fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                Text("028475889493", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Item(title: "${I18n.of(context).exordernoNum}(MIGO)", val: "100",),
                _Item(title: "${I18n.of(context).exsingleprice}(USDT)", val: "1",),
                _Item(title: "${I18n.of(context).expreamount}(USDT)", val: "100",),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            child: BtnImageBottomView(
              onTap: () => Navigator.pushNamed(context, "/sell"),
              title: I18n.of(context).exsellnow,
            ),
          ),
          SizedBox(height: 16,)
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String title;
  final String val;

  const _Item({Key key, this.title, this.val}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
        SizedBox(height: 8,),
        Text(val, style: AppFont.textStyle(12, color: AppColor.back998),)
      ],
    );
  }
}