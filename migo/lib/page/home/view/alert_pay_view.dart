import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class AlertHomePayView extends StatelessWidget {
  final Function() onSure;

  const AlertHomePayView({Key key, this.onSure}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
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
                Text("支付 MIGO", style: AppFont.textStyle(14,color: AppColor.back998, fontWeight: FontWeight.bold),),
                IconButton(
                  icon: Icon(Icons.cancel, color: const Color(0xffdedede),),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: AppColor.divigrey,
            ),
            _InputView(),
            BtnAction(
              title: I18n.of(context).sure,
              onTap: () {
                if(onSure != null) onSure();
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}


class _InputView extends StatelessWidget {
  final String title;
  final String bannce;

  const _InputView({Key key, this.title, this.bannce}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/coin_icon.png")
      ],
    );
  }
}