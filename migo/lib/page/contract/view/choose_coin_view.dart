import 'package:flutter/material.dart';
import 'package:menu_button/menu_button.dart';
import 'package:migo/common/textstyle/textstyle.dart';

class ChooseCoinView extends StatelessWidget {
  final Widget child;
  final List<String> titles;
  final bool iscoupon;
  final Function(int selectindex, String sender) onSelected;

  const ChooseCoinView({Key key, this.titles, this.iscoupon = false, this.onSelected, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MenuButton(
      child: child,
      items: [""]..addAll(titles),
      dontShowTheSameItemSelected: false,
      topDivider: false,
      edgeMargin: 0,
      itemBuilder: (value) {
        if(value == "") {
          return Container(
            height: 10,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10))
            ),
          );
        } else {
          if(iscoupon) {
            return Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(value)
              ],)
            );
          }
         return Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset("assets/usdt.png"),
                    SizedBox(width: 10,),
                    Column(
                      children: [
                        Text(value, style: AppFont.textStyle(14, color: Colors.black),),
                        SizedBox(height: 4,),
                        Text(value.toLowerCase(), style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),)
                      ],
                    )
                  ],
                ),
                SizedBox(height: 16,),
                Divider(height: 1,)
              ],
            )
          );
        }
      },
      toggledChild: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(top: 40),
      ),
      divider: SizedBox(),
      onItemSelected: (value) {
        if(onSelected != null) {
          onSelected(titles.indexOf(value), value);
        }
      },
      decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
      ),
      onMenuButtonToggle: (isToggle) {
      },
    );
  }
}