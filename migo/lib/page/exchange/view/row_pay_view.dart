import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';

class RowPaySelectItem extends StatelessWidget {
  final bool isselect;
  final Function onTap;
  final String titles;

  const RowPaySelectItem({Key key, this.isselect, this.onTap, this.titles}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset("assets/${isselect ? "choos_pay_sel_sel" : "choos_pay_unsel_unsel"}.png"),
          SizedBox(width: 6,),
          Text(titles, style: AppFont.textStyle(14, color: isselect ? AppColor.back998 : const Color(0xff7BA0B9)),),
        ],
      ),
    );
  }
}