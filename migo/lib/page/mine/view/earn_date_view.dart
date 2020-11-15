import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class EarnDateView extends StatelessWidget {
  final String datetime;
  final Function onSelected;
  final Function(bool ispay) onChoosed;
  final bool ispay;
  const EarnDateView({Key key, this.onChoosed, this.ispay, this.datetime = "--", this.onSelected}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _Button(
            title: I18n.of(context).miningpaymentrecord, 
            isselected: ispay,
            onTap: () {
              onChoosed(true);
            },
          ),
          _Button(
            title: I18n.of(context).miningrevenuerecord, 
            isright: true, 
            isselected: !ispay,
            onTap: () {
              onChoosed(false);
            },
          ),
          Spacer(),
          InkWell(
            onTap: onSelected,
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color(0x1A7BA0B9),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(datetime, style: AppFont.textStyle(12, color: AppColor.back998),),
                  Container(
                    height: 14,
                    width: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 9),
                    decoration: BoxDecoration(
                      color: AppColor.back998.withOpacity(0.2)
                    ),
                  ),
                  Image.asset("assets/earndate.png")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String title;
  final bool isselected;
  final bool isright;
  final Function() onTap;
  const _Button({Key key, this.onTap, this.isright = false, this.title, this.isselected = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isselected ? AppColor.back998 : const Color(0xff7BA0B9).withOpacity(0.1),
          borderRadius: isright ? BorderRadius.horizontal(right: Radius.circular(4)) : BorderRadius.horizontal(left: Radius.circular(4))
        ),
        child: Text(title, style: AppFont.textStyle(12, color: isselected ?  Colors.white : AppColor.back998),),
      ),
    );
  }
}