import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';

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
                Text("${I18n.of(context).pay} MIGO", style: AppFont.textStyle(14,color: AppColor.back998, fontWeight: FontWeight.bold),),
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
            SizedBox(height: 25,),
            _InputView(title: "MIGO", bannce: "12",),
            _InputView(title: "USDT", bannce: "11",),
            SizedBox(height: 20,),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset("assets/coin_icon.png"),
              SizedBox(width: 4,),
              Text(title, style: AppFont.textStyle(12, color: AppColor.back998),)
            ],
          ),
          SizedBox(height: 9,),
          NormalTextfield(
            hintText: I18n.of(context).pleaseinputonumber,
          ),
          SizedBox(height: 10,),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(I18n.of(context).balance + ":" + bannce, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
          )
        ],
      ),
    );
  }
}