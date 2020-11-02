import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class AlertExitView extends StatelessWidget {
  final Function() onSure;

  const AlertExitView({Key key, this.onSure}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset("assets/img_popup_quit_def.png"),
            Text(I18n.of(context).canyouexit, style: AppFont.textStyle(16, color: Colors.white),)
          ],
        ),
        SizedBox(height: 32,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/home_btn_inactive.png"),
                    fit: BoxFit.fill
                  ),
                ),
                child: Text(I18n.of(context).cancel, style: AppFont.textStyle(14, color: Colors.white),),
              ),
            ),
            SizedBox(width: 76,),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                if(onSure != null) onSure();
              },
              child: Container(
                height: 40,
                width: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/home_btn.png"),
                    fit: BoxFit.fill
                  ),
                ),
                child: Text(I18n.of(context).sure, style: AppFont.textStyle(14, color: Colors.white),),
              ),
            ),
          ],
        )
      ],
    );
  }
}