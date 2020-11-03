import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class ReflectSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).withdrawsuccess,
        onPop: () => Navigator.pop(context),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8, 
                    color: Colors.black.withOpacity(0.3), 
                    spreadRadius: 0,
                    offset: Offset(0, 2)
                  )
                ]
              ),
              child: Column(
                children: [
                  Image.asset("assets/pull_next.png"),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 20.0),
                    child: Text(I18n.of(context).withdrawsuccess, style: AppFont.textStyle(14, color: AppColor.back998, fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xffE5F0FA),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _Row(titles: I18n.of(context).arrivalquantity, val: "500 MIGO",),
                        SizedBox(height: 14,),
                        _Row(titles: I18n.of(context).withdrawnum, val: "500 MIGO",),
                        SizedBox(height: 14,),
                        _Row(titles: I18n.of(context).handlingfee, val: "500 MIGO",),
                        SizedBox(height: 14,),
                        _Row(titles: I18n.of(context).date, val: "2020-19-20",),
                        SizedBox(height: 14,),
                        _Row(titles: I18n.of(context).time, val: "19:54:00",),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  BtnAction(
                    title: I18n.of(context).finish,
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60,)
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String titles;
  final String val;
  final double padding;
  const _Row({Key key, this.padding, this.titles, this.val}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titles, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
        Text(val, style: AppFont.textStyle(12, color: AppColor.back998,)),
      ],
    );
  }
}