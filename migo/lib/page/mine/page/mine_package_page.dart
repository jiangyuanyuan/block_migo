import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/page/mine/view/package_cell.dart';
import 'package:migo/page/mine/view/package_head_view.dart';

class MinePackagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.back998,
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            title: Text("我的钱包", style: AppFont.textStyle(14, color: Colors.white),),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Image.asset("assets/icon_zuo.png", color: Colors.white,),
            ),
          ),
          PackageHeadView(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.divigrey,
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))
              ),
              child: ListView.builder(
                itemCount: 6,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return PackageCell();
                }
              ),
            ),
          )
        ],
      ),
    );
  }
}