import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/exchange/model/otc_order_model.dart';
import 'package:migo/page/exchange/model/sell_detail_model.dart';
import 'package:migo/page/exchange/view/exchange_record_cell.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ExchangeRecordPage extends StatefulWidget {
  @override
  _ExchangeRecordPageState createState() => _ExchangeRecordPageState();
}

class _ExchangeRecordPageState extends State<ExchangeRecordPage> {

  int selecttype = 0;
  int orderType = 1;
  int page = 0;
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  List<SellDetailModel> list = [];
  @override
  void initState() {
    super.initState();
  }
  
  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
  
  void _refresh() {
    page = 1;
    _request(true);
  }
  
  void _loading() {
    page += 1;
    _request();
  }
  
  void _request([bool refresh = false]) {
    // 1 买 2卖
    Networktool.request(API.orderList + "$orderType/$selecttype/$page/10", method: HTTPMETHOD.GET, params: {}, success: (data) {
      final temp = OtcOrderResponse.fromJson(data);
      if(refresh) list.clear();
      if(temp.data.length < 10) _refreshController.loadNoData();
      list.addAll(temp.data);
      if(mounted) setState(() {
        
      });
    }, fail: (msg) => EasyLoading.showToast(msg)
    , finaly: _endRefresh);
  }
  
  void _endRefresh() {
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }
  Widget _createHead() {
    List<String> list = [
      I18n.of(context).rnotpay, 
      I18n.of(context).rnotsure,
      I18n.of(context).rfinish, 
      I18n.of(context).rnotfinish,
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 24, right: 23, bottom: 8),
      child: Row(
        children: list.map((e) => _Item(
          index: list.indexOf(e), 
          titles: e, 
          isselect: selecttype == list.indexOf(e),
          onTap: () {
            setState(() {
              selecttype = list.indexOf(e);
            });
            _refreshController.requestRefresh();
          },
        )).toList(),
      ),
    );
  }

  void _changeStatus(String payid, String orderid, String aid) {
    EasyLoading.show(status: 'Loading...');
    Networktool.request(API.orderPay, params: {
      	"adId": aid,
        "orderId": orderid,
        "userPayId": payid
    }, success: (data) {
      EasyLoading.showToast(I18n.of(context).success);
      _refreshController.requestRefresh();
    }, fail: (msg) => EasyLoading.showToast(msg),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        // titles: I18n.of(context).rtitle,
        childTitle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  orderType = 1;
                });
                _refreshController.requestRefresh();
              },
              child: Container(
                height: 30,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(4)),
                  color: orderType == 1 ? Colors.white : Colors.transparent,
                  border: Border.all(width: 1, color: orderType == 1 ? Colors.white : const Color(0xffDBF0FF))
                ),
                child: Text(I18n.of(context).rbuytitle, style: AppFont.textStyle(12, color: orderType == 1 ? AppColor.back998 : Colors.white),),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  orderType = 2;
                });
                _refreshController.requestRefresh();
              },
              child: Container(
                height: 30,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(4)),
                  color: orderType == 2 ? Colors.white : Colors.transparent,
                  border: Border.all(width: 1, color: orderType == 2 ? Colors.white : const Color(0xffDBF0FF))
                ),
                child: Text(I18n.of(context).rselltitle, style: AppFont.textStyle(12, color: orderType == 2 ? AppColor.back998 : const Color(0xffDBF0FF)),),
              ),
            )
          ],
        ),
        onPop: () => Navigator.pop(context),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8))
          ),
          child: Column(
            children: [
              _createHead(),
              Expanded(
                child: RefreshWidget(
                  controller: _refreshController,
                  onLoading: _loading,
                  onRefresh: _refresh,
                  minPage: page,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return ExchangeRecordCell(model: list[index], orderType: orderType, onChangeStatus: (payid, orderid, adid) {
                          _changeStatus(payid, orderid, adid);
                        },
                        onRefresh: () => _refreshController.requestRefresh(),
                      );
                    }
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String titles;
  final Function onTap;
  final int index;
  final bool isselect;

  const _Item({Key key, this.titles, this.onTap, this.index, this.isselect = false}) : super(key: key);

  BorderRadius _createRaduis() {
    if(index == 0) {
      return BorderRadius.horizontal(left: Radius.circular(4));
    } else if(index == 3) {
      return BorderRadius.horizontal(right: Radius.circular(4));
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 34,
          margin: const EdgeInsets.only(right: 1),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isselect ? const Color(0xff7BA0B9) : const Color(0x1A7BA0B9),
            borderRadius: _createRaduis()
          ),
          child: Text(titles, textAlign: TextAlign.center, style: AppFont.textStyle(12, color: isselect ? Colors.white : AppColor.back998),),
        ),
      ),
    );
  }
}