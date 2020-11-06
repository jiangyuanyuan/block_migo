import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class CoinsDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: "USDT",
        onPop: () => Navigator.pop(context),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 9),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset("assets/usdt.png", width: 48, height: 48, fit: BoxFit.fill,),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("17372.40366816 USDT", style: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold),),
                          Text("≈17472.40(USD)", style: AppFont.textStyle(12, color: const Color(0xffDBF0FF)),)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(I18n.of(context).availablebalance, style: AppFont.textStyle(12, color: const Color(0xffDBF0FF)),),
                          SizedBox(height: 10,),
                          Text("17372.40366816", style: AppFont.textStyle(16, color: Colors.white, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      BtnAction(
                        backImg: "btn_team_join_def.png",
                        title: I18n.of(context).coinupdate,
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 24,),
                        Text(I18n.of(context).history, style: AppFont.textStyle(12, color: Colors.black),),
                        Spacer(),
                        IconButton(
                          icon: Image.asset("assets/ico_hist_filt-def.png"),
                          iconSize: 24,
                          onPressed: () {},
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 10,
                        itemBuilder: (context, index){
                          return _Cell(index: index,);
                        }
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  final int index;

  const _Cell({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 28,
          width: double.infinity,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 24),
          color: const Color(0x33C1CDD8),
          child: Text("2020/10/24", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Row(
            children: [
              Image.asset("assets/${index == 2 ? "ico_hist_in_def2" : "ico_hist_in_def"}.png"),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${index == 2 ? I18n.of(context).withdraw:I18n.of(context).recharge}", style: AppFont.textStyle(14, color: Colors.black),),
                  SizedBox(height: 4,),
                  Text("16:43",style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)))
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /// 提现为黑色
                  Text("+0.80355726", style: AppFont.textStyle(14, color: AppColor.green, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4,),
                  Text("≈0.804", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4))),
                ],
              ),
              SizedBox(width: 4,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("USDT", style: AppFont.textStyle(14, color: Colors.black)),
                  SizedBox(height: 4,),
                  Text("USD", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4))),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}