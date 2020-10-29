import 'package:migo/common/textstyle/textstyle.dart';
import 'package:flutter/material.dart';

class HomeCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      color: Colors.red,
      child: Row(
        children: [
          Column(
            children: [
              Text("赚取MIGO", style: AppFont.textStyle(12, color: AppColor.yellowMain),),
              SizedBox(height: 30,),
              Text("MIGO乐乡", style: AppFont.textStyle(12),)
            ],
          ),
          SizedBox(width: 36,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("抵押：4000 MIGO-USDT", style: AppFont.textStyle(12, color: Colors.white),),
              Text("日产量：165", style: AppFont.textStyle(12, color: Colors.white),),
              Text("挖矿周期：45天", style: AppFont.textStyle(12, color: Colors.white),),
              Text("挖矿量：0", style: AppFont.textStyle(12, color: Colors.white),),
            ],
          )
        ],
      ),
    );
  }
}