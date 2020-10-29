import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';

class PackageCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
      color: Colors.green,
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.cached),
              SizedBox(width: 25,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("金铲", style: AppFont.textStyle(12, color: Colors.white),),
                  Text("规格：8500", style: AppFont.textStyle(12, color: Colors.white),),
                  Text("生产量：1.35", style: AppFont.textStyle(12, color: Colors.white),),
                ],
              ),
              SizedBox(width: 45,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(" ", style: AppFont.textStyle(12, color: Colors.white),),
                  Text("规格：8500", style: AppFont.textStyle(12, color: Colors.white),),
                  Text("生产量：1.35", style: AppFont.textStyle(12, color: Colors.white),),
                ],
              )
            ],
          ),
          Container(
            color: Colors.red,
            width: double.infinity,
            height: 40,
            alignment: Alignment.center,
            child: Text("使用"),
          )
        ],
      ),
    );
  }
}