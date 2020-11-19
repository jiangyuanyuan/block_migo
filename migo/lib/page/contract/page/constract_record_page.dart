import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/contract/model/exchange_reocrd_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ConstractRecordPage extends StatefulWidget {
  @override
  _ConstractRecordPageState createState() => _ConstractRecordPageState();
}

class _ConstractRecordPageState extends State<ConstractRecordPage> {

  List<String> headers = [];
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  List<ExchangeRecordModel> list = [];
  String type = "-1";
  int selectIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  void _requestHeader() {
    Networktool.request(API.myExchangeRecordPage, success: (data) {
      if(data["data"] != null) {
        headers = data["data"].cast<String>();
        headers.insert(0, I18n.of(context).all);
      }
      if(mounted) setState(() {
        
      });
    });
  }

  void _request() {
    Networktool.request(API.myExchangeRecord + type, success: (data) {
      final tmep = ExchangeRecordResponse.fromJson(data);
      if(tmep.data != null) list = tmep.data;
      if(mounted) setState(() {
        
      });
    }, finaly: _endrefresh);
  }

  void _refresh() {
    _request();
    _requestHeader();
  }

  void _endrefresh() {
    _refreshController.refreshCompleted();
  }

  List<Widget> _createList(double width) {
    return headers.map((e) {
      String temp = e;
      if(e.contains("_")) {
        temp = e.replaceFirst("_", "-");
      }
      return _Button(titles: temp, isselect: selectIndex == headers.indexOf(e), width: width, onTap: () {
        if(headers.indexOf(e) == 0) {
          type = "-1";
        } else {
          type = e;
        }
        setState(() {
          selectIndex = headers.indexOf(e);
        });
        _refreshController.requestRefresh();
      },);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = (size.width - 48) / 3.0;
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).exchangehistory,
        onPop: () => Navigator.pop(context),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            color: Colors.white
          ),
          child: Column(
            children: [
              SizedBox(height: 8,),
              Row(
                children: [
                  SizedBox(width: 24,),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _createList(width),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: headers.length > 3,
                    child: Image.asset("assets/right.png", color: AppColor.back998, width: 30, height: 15,)
                  ),
                ],
              ),
              Expanded(
                child: RefreshWidget(
                  controller: _refreshController,
                  onRefresh: _refresh,
                  child: ListView.builder(
                    itemCount: list.length,
                    padding: const EdgeInsets.only(top: 16),
                    itemBuilder: (context, index) {
                      final e = list[index];
                      return _Cell(
                        coinName: e.coinName,
                        toCoinName: e.toCoinName,
                        amount: e.toNum,
                        chanFee: e.inputnum,
                        createtie: e.createTime,
                        remark: "${e.price}",
                        status: 3,
                        fee: e.fee
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

class _Cell extends StatelessWidget {
  final String coinName;
  final num amount;
  final String toCoinName;
  final int createtie;
  final String remark;
  final num chanFee;
  final int status;
  final num fee;
  const _Cell({Key key, this.coinName, this.toCoinName, this.fee, this.chanFee = 0, this.status, this.amount, this.createtie, this.remark}) : super(key: key);@override

  // 0待审核 1转账中 2确认中 3转账成功 4审批拒绝 5转账失败 6发送交易中 7打包中
  Color _getColor() {
    switch (status) {
      case 0:
        return AppColor.back998;
        break;
      case 3:
        return AppColor.green;
        break;
      default:
        return AppColor.red;
    }
  }
  Color _getBackColor() {
    switch (status) {
      case 0:
        return const Color(0xffF4F7FA);
        break;
      case 3:
        return const Color(0xffF2FBF4);
        break;
      default:
        return const Color(0xffFCF2F3);
    }
  }
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            height: 40,
            color: _getBackColor(),
            child: Row(
              children: [
                Text(coinName, style: AppFont.textStyle(14, color: _getColor(), fontWeight: FontWeight.bold),),
                Image.asset("assets/icons_arr_right.png"),
                Text(toCoinName, style: AppFont.textStyle(14, color: _getColor(), fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                Text(Tool.timeFormat("yyyy-MM-dd HH:mm", createtie), style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                Spacer(),
                Text(I18n.of(context).alfinish, style: AppFont.textStyle(12, color: _getColor()),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(I18n.of(context).number + "($coinName)", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                    Text(I18n.of(context).realnum + "($toCoinName)", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                    // Text(Tool.number(amount, 2), style: AppFont.textStyle(12, color: Colors.black),)
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Tool.number(chanFee, 2), style: AppFont.textStyle(12, color: AppColor.back998),),
                    Text(Tool.number(amount, 2), style: AppFont.textStyle(12, color: AppColor.back998),),
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(I18n.of(context).feereduction2 + "($coinName)", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                    Text(I18n.of(context).price + "($coinName/$toCoinName)", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                    // Text(Tool.number(amount, 2), style: AppFont.textStyle(12, color: Colors.black),)
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Tool.number(fee, 4), style: AppFont.textStyle(12, color: AppColor.back998),),
                    Text(remark, style: AppFont.textStyle(12, color: AppColor.back998),),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String titles;
  final Function() onTap;
  final double width;
  final bool isselect;
  const _Button({Key key, this.isselect = false, this.width = 50, this.titles, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: 34,
        margin: const EdgeInsets.only(right: 1),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isselect ? AppColor.back998 : const Color(0x1a7BA0B9),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(titles, style: AppFont.textStyle(12, color: isselect ? Colors.white : AppColor.back998),),
      ),
    );
  }
}