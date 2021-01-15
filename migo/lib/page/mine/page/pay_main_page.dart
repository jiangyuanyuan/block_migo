import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/event_bus.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/model/mine_pay_model.dart';

class PayMainPage extends StatefulWidget {
  @override
  _PayMainPageState createState() => _PayMainPageState();
}

class _PayMainPageState extends State<PayMainPage> {
  Map<int, String> imgs = {
    3:"logo_colle_trc_def",
    1:"logo_colle_wechat_def备份",
    2:"logo_colle_bank_def"
};

  List<PaymethodModel> list = [];

  @override
  void initState() {
    super.initState();
    _request();
  }

  void _request() {
    Networktool.request(API.userPays, method: HTTPMETHOD.GET, success: (data) {
      final temp = MinePaymethodResponse.fromJson(data);
      list = temp.data;
      if(mounted) setState(() {
        
      });
    }, fail: (msg) => EasyLoading.showToast(msg),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).spaysetting,
        onPop: () => Navigator.pop(context),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 16),
              child: Column(
                children: list.map((e) => _Cell(
                  type: e.payWay, 
                  title: e.payName, 
                  val: e.payNo, 
                  img: imgs[e.payWay],
                  onTap: () async {
                    final res = await Navigator.pushNamed(context, "/paysetting", arguments: {"payways":[e.payWay], "model":e});
                    if(res != null) {
                      _request();
                    }
                  },
                )).toList(),
                // children: [
                //   // _Cell(type: 0, title: I18n.of(context).paybank, val: "1891289", img: imgs[0],),
                //   // _Cell(type: 1, title: I18n.of(context).payalipay, val: "1891289", img: imgs[1],),
                //   // _Cell(type: 2, title: I18n.of(context).paywx, val: "1891289", img: imgs[2],),
                // ],
              ),
            ),
            Spacer(),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Visibility(
                  visible: list.length != 3,
                  child: BtnImageBottomView(
                    title: I18n.of(context).addother,
                    onTap: () async {
                      List<int> temp = [1, 2,3];
                      list.forEach((element) { 
                        temp.remove(element.payWay);
                      });
                      final res = await Navigator.pushNamed(context, "/paysetting", arguments: {"payways":temp});
                      if(res != null) {
                        _request();
                      }
                    },
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


class _Cell extends StatelessWidget {
  final int type;
  final String title;
  final String val;
  final String img;
  final Function onTap;
  const _Cell({Key key, this.type, this.onTap, this.img, this.title, this.val}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg_list_sett_def.png"),
            fit: BoxFit.fill
          )
        ),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Image.asset("assets/$img.png"),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppFont.textStyle(14,),),
                SizedBox(height: 6,),
                Text(val, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

