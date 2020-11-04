import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/home/view/get_shovel_view.dart';

class AlertShovelView extends StatelessWidget {
  final Function() onSure;

  const AlertShovelView({Key key, this.onSure}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset("assets/alert_shovel.png"),
            Positioned(
              top: 20,
              left: 21,
              bottom: 37,
              right: 21,
              child: Column(
                children: [
                  Text(I18n.of(context).congratulations, style: AppFont.textStyle(16, color: Colors.white),),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: const Color(0xffAB6E34),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ShovelCellView(number: 1, shovelType: 0,),
                            ShovelCellView(number: 1, shovelType: 0,),
                            ShovelCellView(number: 1, shovelType: 0,),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ),
          ],
        ),
        InkWell(
              onTap: () {
                Navigator.pop(context);
                if(onSure != null) onSure();
              },
              child: Container(
                height: 40,
                width: 138,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/home_btn_inactive.png"),
                    fit: BoxFit.fill
                  ),
                ),
                child: Text(I18n.of(context).gotopackage, style: AppFont.textStyle(14, color: Colors.white),),
              ),
            ),
      ],
    );
  }
}