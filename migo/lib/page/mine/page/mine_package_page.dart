import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/contract/view/alert_password_view.dart';
import 'package:migo/page/home/model/home_box_model.dart';
import 'package:migo/page/home/view/alert_shovelview.dart';
import 'package:migo/page/mine/model/mine_package_model.dart';
import 'package:migo/page/mine/view/package_cell.dart';
import 'package:migo/page/mine/view/package_head_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MinePackagePage extends StatefulWidget {
  @override
  _MinePackagePageState createState() => _MinePackagePageState();
}

class _MinePackagePageState extends State<MinePackagePage> {

  List<MineShovelModel> list = [];
  RefreshController _refreshController = RefreshController();
  MinePackageHeadModel headmodel;
  @override
  void initState() {
    super.initState();
    // _request();
    _requestDetail();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _requestDetail() {
    Networktool.request(API.getMyKnapsack, success: (data) async {
      final temp = MinePackageHeadResponse.fromJson(data);
      headmodel = temp.data;
      if(temp.data.shovelList != null) list = temp.data.shovelList;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final isen = prefs.getString('languageCode') == "en";
      if(isen) list.forEach((e) { 
        if(e.toolbox.enToolName != null) e.toolbox.toolName = e.toolbox.enToolName;
      });
      if(mounted) setState(() {
        
      });
    }, finaly: _endrefresh);
  }

  void _refresh() {
    _requestDetail();
  }

  void _endrefresh() {
    _refreshController.refreshCompleted();
  }

  void _userShovel(MineShovelModel model) {
    
    EasyLoading.show(status: "Loading...");
    Networktool.request(API.miningBeltShovel + model.id, success: (data) {
      EasyLoading.dismiss();
      EasyLoading.showToast(I18n.of(context).success);
      _refreshController.requestRefresh();
    }, fail: (msg) => EasyLoading.showError(msg),);
    
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.back998,
      body: CommbackView(
        titles: I18n.of(context).mypackage,
        onPop: () => Navigator.pop(context),
        actions: [
          IconButton(
            icon: Image.asset("assets/ico_incom_hist_def.png"),
            onPressed: () {
              Navigator.pushNamed(context, "/mineshovelrecord");
            },
          )
        ],
        child: Column(
          children: [
            PackageHeadView(model: headmodel),
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
                          onSure: () => _userShovel(list[index]),
                          list: [HomeShovelModel(count: 1, name: list[index].toolbox.toolName)],
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