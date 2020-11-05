import 'package:flutter/material.dart';
import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/screen_tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/contract/view/recharge_head_view.dart';

class RechagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).recharge,
        onPop: () => Navigator.pop(context),
        actions: [
          IconButton(
            icon: Image.asset("assets/coins_record.png"),
            onPressed: () {

            },
          )
        ],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Stack(
                  children: [
                    Image.asset("assets/input_back.png", fit: BoxFit.fill, width: double.infinity,),
                    Positioned(
                      left: 10,
                      height: 42,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text("选择币种", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.2)), textAlign: TextAlign.center,)
                      ),
                    ),
                    Positioned(
                      right: 10,
                      height: 42,
                      child: Image.asset("assets/coin_select.png"),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    RechargeHeadView(),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 20),
                      child: Text(I18n.of(context).scanqrtorecharge, style: AppFont.textStyle(14, color: AppColor.back998, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      width: 180,
                      height: 180,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(I18n.of(context).copyaddress, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xffE5F0FA),
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("color: const Color(0xffE5F0FA),", style: AppFont.textStyle(12, color: AppColor.back998),),
                          IconButton(
                            icon: Image.asset("assets/coin_copy.png"),
                            onPressed: () {
                              ScreenTool.copy("bb");
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("温馨提示：", style: AppFont.textStyle(14, color: Colors.white),),
                    SizedBox(height: 20,),
                    Text(I18n.of(context).notice1, style: AppFont.textStyle(14, color: Colors.white.withOpacity(0.5)),),
                    SizedBox(height: 10,),
                    Text(I18n.of(context).notice2, style: AppFont.textStyle(14, color: Colors.white.withOpacity(0.5)),),
                    SizedBox(height: 10,),
                    Text(I18n.of(context).notice3, style: AppFont.textStyle(14, color: Colors.white.withOpacity(0.5)),),
                    SizedBox(height: 10,),
                    Text(I18n.of(context).notice4, style: AppFont.textStyle(14, color: Colors.white.withOpacity(0.5)),),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}