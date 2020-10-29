
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:migo/page/home/view/home_cell.dart';
import 'package:migo/page/home/view/home_head_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.back998,
      body: Column(
        children: [
          HomeHeadView(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                color: AppColor.divigrey,
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))
              ),
              child: ListView.builder(itemBuilder: (context, index){
                return HomeCell();
              }),
            ),
          )
        ],
      ),
    );
  }
}