import 'package:migo/common/textstyle/textstyle.dart';
import 'package:flutter/material.dart';

class HomeCell extends StatelessWidget {
  final int index;

  const HomeCell({Key key, this.index}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Stack(
        children: [
          Image.asset("assets/Panel.png"),
          Positioned.fill(
            child: Container(
            margin: const EdgeInsets.all(20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: [
                      Container(
                        width: 85,
                        height: 25,
                        margin: const EdgeInsets.only(bottom: 20),
                        alignment: Alignment.center,
                        child: Text("赚取MIGO", style: AppFont.textStyle(12, color: AppColor.yellowMain),)
                      ),
                      Text("MIGO${index == 0 ? "乐乡" : "乐屋"}", style: AppFont.textStyle(12, color: Colors.white, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                SizedBox(width: 24,),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("抵押：4000 MIGO-USDT", style: AppFont.textStyle(12, color: Colors.white),),
                      Text("日产量：165", style: AppFont.textStyle(12, color: Colors.white),),
                      Text("挖矿周期：45天", style: AppFont.textStyle(12, color: Colors.white),),
                      Text("挖矿量：0", style: AppFont.textStyle(12, color: Colors.white),),
                    ],
                  ),
                )
              ],
            ),
          ),
          )
        ],
      ),
    );
  }
}