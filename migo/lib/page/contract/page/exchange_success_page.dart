import 'package:flutter/material.dart';
import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';

class ExchangeSuccessPage extends StatelessWidget {
  final Map params;
  const ExchangeSuccessPage({Key key, this.params}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/背景图.png"),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: NormalAppbar.normal(
                color: Colors.transparent,
                title: Text(I18n.of(context).exchagesuccess,style: AppFont.textStyle(14, color: Colors.white),),
                onPress: () => Navigator.pop(context)
              ),
            ),
            Expanded(
              child: Column(
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
                        Image.asset("assets/success_icon.png"),
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 20.0),
                          child: Text(I18n.of(context).exchagesuccess, style: AppFont.textStyle(14, color: AppColor.back998, fontWeight: FontWeight.bold),),
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
                              _Row(titles: I18n.of(context).number,val: "${params["count"]} ${params["coinName"]}",),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                child: _Row(titles: I18n.of(context).date,val: Tool.timeFormat("yyyy-MM-dd", params["time"]),),
                              ),
                              _Row(titles: I18n.of(context).time,val: Tool.timeFormat("HH:mm:ss", params["time"]),),
                              SizedBox(height: 14,),
                              _Row(titles: I18n.of(context).total,val: "${params["count"]} ${params["coinName"]}",),
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        BtnAction(
                          title: I18n.of(context).finish,
                          onTap: () => Navigator.pop(context),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 60,)
                ],
              ),
            )
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