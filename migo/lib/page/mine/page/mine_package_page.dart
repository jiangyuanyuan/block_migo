import 'package:flutter/material.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/home/view/alert_shovelview.dart';
import 'package:migo/page/mine/view/package_cell.dart';
import 'package:migo/page/mine/view/package_head_view.dart';

class MinePackagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.back998,
      body: CommbackView(
        titles: I18n.of(context).mypackage,
        onPop: () => Navigator.pop(context),
        child: Column(
          children: [
            PackageHeadView(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 90),
                decoration: BoxDecoration(
                  // color: AppColor.divigrey,
                  // borderRadius: BorderRadius.vertical(top: Radius.circular(8))
                  image: DecorationImage(
                    image: AssetImage("assets/backgrond.png"),
                    fit: BoxFit.fill
                  )
                ),
                child: ListView.builder(
                  itemCount: 6,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return PackageCell(onUserAction: () {
                      Alert.showViewDialog(context, AlertShovelView(
                        titles: I18n.of(context).usernotice,
                        btntitles: I18n.of(context).sure,
                        showclose: true,
                      ));
                    },);
                  }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}