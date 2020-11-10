import 'package:flutter/material.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/home/view/alert_shovelview.dart';
import 'package:migo/page/mine/model/mine_package_model.dart';
import 'package:migo/page/mine/view/package_cell.dart';
import 'package:migo/page/mine/view/package_head_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MinePackagePage extends StatefulWidget {
  @override
  _MinePackagePageState createState() => _MinePackagePageState();
}

class _MinePackagePageState extends State<MinePackagePage> {

  List<MineShovelModel> list = [];
  RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    super.initState();
    _request();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _request() {
    Networktool.request(API.getMyNotUseShovel, success: (data){
      final temp = MinepageageResponse.fromJson(data);
      list = temp.data;
      if(mounted) setState(() {
        
      });
    }, finaly: _endrefresh);
  }

  void _refresh() {
    _request();
  }

  void _endrefresh() {
    _refreshController.refreshCompleted();
  }

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
                child: RefreshWidget(
                  controller: _refreshController,
                  onRefresh: _refresh,
                  child: ListView.builder(
                    itemCount: list.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return PackageCell(
                        model: list[index],
                        onUserAction: () {
                        Alert.showViewDialog(context, AlertShovelView(
                          titles: I18n.of(context).usernotice,
                          btntitles: I18n.of(context).sure,
                          showclose: true,
                        ));
                      },);
                    }
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}