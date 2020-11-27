import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class MineReelRecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).reelrecord,
        onPop: () => Navigator.pop(context),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 19.0),
                child: Text(I18n.of(context).reelrecordhead),
              ),
              SizedBox(height: 18,),
              Divider(height: 1,),
              Expanded(
                child: ListView.separated(
                  itemCount: 10,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  separatorBuilder: (context, index) {
                    return Divider(height: 1,);
                  },
                  itemBuilder: (context, index) {
                    return _Cell();
                  }
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("5 实名认证卷", style: AppFont.textStyle(12, color: AppColor.back998),),
              Text(I18n.of(context).reeledfinish, style: AppFont.textStyle(12, color: AppColor.back998),),
              
            ],
          ),
          SizedBox(height: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("2020/10/09 23:35", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
              Text("normanmartin2018@gmail.com", style: AppFont.textStyle(12, color: AppColor.back998),),
            ],
          ),
        ],
      ),
    );
  }
}