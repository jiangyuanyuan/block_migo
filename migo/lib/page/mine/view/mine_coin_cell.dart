import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';

class MineCoinCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset("assets/usdt.png"),
              SizedBox(width: 20,),
              Column(
                children: [
                  Text("USDT", style: AppFont.textStyle(14, color: Colors.black),),
                  SizedBox(height: 4,),
                  Text("Tether", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text("0.998", style: AppFont.textStyle(14, color: Colors.black),),
                  SizedBox(height: 4,),
                  Text("¥0.00", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
                ],
              ),
            ],
          ),
          SizedBox(height: 16,),
          Divider(height: 1,)
        ],
      ),
    );
  }
}