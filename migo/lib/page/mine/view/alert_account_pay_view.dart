import 'package:flutter/material.dart';

import '../../../common/commview/btn_image_bottom.dart';
import '../../../common/textstyle/textstyle.dart';
import '../../../common/textstyle/textstyle.dart';
import '../../../generated/i18n.dart';
import '../../../generated/i18n.dart';
import '../../../generated/i18n.dart';

class AlertAccountPayView extends StatelessWidget {
  
  final Function onTap;

  const AlertAccountPayView({Key key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(8))
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 24,),
                Text(I18n.of(context).unlockaccount, style: AppFont.textStyle(14,color: AppColor.back998, fontWeight: FontWeight.bold),),
                IconButton(
                  icon: Icon(Icons.cancel, color: const Color(0xffdedede),),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 42, bottom: 10.0),
              child: Image.asset("assets/img_unlock_money_def.png"),
            ),
            Text("${I18n.of(context).balance}：108.55 MIGO", style: AppFont.textStyle(12),),
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 40, left: 20, right: 20),
              child: BtnImageBottomView(
                onTap: onTap,
                title: "${I18n.of(context).pay} 3MIGO ${I18n.of(context).unlockaccount}",
              ),
            ),
          ]
        )
      )
    );
  }
}