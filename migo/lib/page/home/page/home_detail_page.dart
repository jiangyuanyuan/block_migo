import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/page/contract/view/alert_password_view.dart';
import 'package:migo/page/home/model/home_list_model.dart';
import 'package:migo/page/home/view/alert_pay_view.dart';
import 'package:migo/page/home/view/home_detail_cell.dart';
import 'package:migo/page/home/view/home_detail_head.dart';
import 'package:migo/page/home/view/home_detail_tabbar.dart';
import 'package:migo/page/home/view/home_detail_use.dart';
import 'package:migo/page/home/view/home_gradient_text.dart';

class HomeDetailPage extends StatefulWidget {
  final Map params;

  const HomeDetailPage({Key key, this.params}) : super(key: key);
  @override
  _HomeDetailPageState createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {

  int tabindex = 0;
  HomeModel model;

  @override
  void initState() {
    super.initState();
    model = widget.params["model"];
  }
  /// 立即挖矿
  void _getAction() {
    Alert.showBottomViewDialog(context, AlertHomePayView(
      onSure: () {
        Future.delayed(const Duration(milliseconds: 100)).then((value) => _inputPwd());    
      },
    ));
  }

  void _inputPwd() {
    Alert.showBottomViewDialog(context, AlertPasswordView(onSure: (pwd){
      EasyLoading.showToast("支付成功");
    }));
  }

  /// 请求挖矿列表详情
  void _request() {
    Networktool.request(API.banner, success: (data) {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: model.mineTitle,
        onPop: () => Navigator.pop(context),
        child: Column(
          children: [
            HomeDetailHeadView(model: model),
            SizedBox(height: 20,),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    top: 120,
                    child: Image.asset("assets/migo_back.png", width: double.infinity, height: double.infinity, fit: BoxFit.fill,)
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: HomeDetailUserView(onTap: _getAction,),
                  ),
                  Positioned.fill(
                    top: 215,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffFDFEFF),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(8))
                      ),
                      child: Column(
                        children: [
                          HomeDetailBarView(onTabIndex: (sender) {
                            setState(() {
                              tabindex = sender;
                            });
                          },),
                          Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              itemBuilder: (context, index) {
                                return HomeDetailCell(tabindex: tabindex,);
                              }, 
                              separatorBuilder: (context, index) => Divider(height: 1,), 
                              itemCount: 10
                            ),
                          )
                        ],
                      ),
                    )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}