
import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/contract/model/recharge_record_model.dart';
import 'package:migo/page/contract/model/reflect_record_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CoinsRecordPage extends StatefulWidget {
  final Map params;

  const CoinsRecordPage({Key key, this.params}) : super(key: key);
  @override
  _CoinsRecordPageState createState() => _CoinsRecordPageState();
}

class _CoinsRecordPageState extends State<CoinsRecordPage> {
  bool isrecharge = true;
  String coinName = "USDT";
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  List<RechargeRecordModel> rechargeList = [];
  List<ReflectRecordModel> reflectList = [];
  @override
  void initState() {
    super.initState();
    isrecharge = widget.params["isrecharge"];
    if(widget.params["coinName"] != null) coinName = widget.params["coinName"];
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _request() {
    String url = API.rechargeDetailList;
    HTTPMETHOD me = HTTPMETHOD.POST;
    if(!isrecharge) {
      url = API.getTransferOut + coinName;
      me = HTTPMETHOD.GET;
    }
    Networktool.request(url, method: me, success: (data) {
      if(isrecharge) {
        final temp = RechageRecordResponse.fromJson(data);
        rechargeList = temp.data;
      } else {
        final temp = ReflectRecordResponse.fromJson(data);
        reflectList = temp.data;
      }

      if(mounted) setState(() {
        
      });
    },finaly: _endrefresh);
  }

  void _refresh() {
    _request();
  }

  void _endrefresh() {
    _refreshController.refreshCompleted();
  }

  String _getRemark(int status) {
    List<String> list = [
      I18n.of(context).coinStatus0,
      I18n.of(context).coinStatus1,
      I18n.of(context).coinStatus2,
      I18n.of(context).coinStatus3,
      I18n.of(context).coinStatus4,
      I18n.of(context).coinStatus5,
      I18n.of(context).coinStatus6,
      I18n.of(context).coinStatus7,
    ];
    return list[status];
  }

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      body: CommbackView(
        onPop: () => Navigator.pop(context),
        // titles: isrecharge ? I18n.of(context).rechargerecord : I18n.of(context).relfectrecord,
        titles: I18n.of(context).rechargerecord,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            color: Colors.white
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Row(
                  children: [
                    Text(I18n.of(context).rechagerecordorder),
                    Spacer(),
                    _Button(
                      title: I18n.of(context).recharge, 
                      isselected: isrecharge,
                      onTap: () {
                        isrecharge = true;
                        _refreshController.requestRefresh();
                        setState(() {
                          
                        });
                      },
                    ),
                    _Button(
                      title: I18n.of(context).withdraw, 
                      isright: true, 
                      isselected: !isrecharge,
                      onTap: () {
                        isrecharge = false;
                        _refreshController.requestRefresh();
                        setState(() {
                          
                        });
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RefreshWidget(
                  controller: _refreshController,
                  onRefresh: _refresh,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: isrecharge ? rechargeList.length : reflectList.length,
                    itemBuilder: (context, index){
                      if(isrecharge) {
                        final m = rechargeList[index];
                        return _Cell(
                          coinName: m.coinName, 
                          status: m.status, 
                          createtie: m.createTime, 
                          amount: m.amount, 
                          chanFee: m.amount,
                          fee: 0,
                          remark: "--",
                        );
                      } else {
                        final m = reflectList[index];
                        return _Cell(
                          coinName: m.coinName, 
                          status: m.status, 
                          chanFee: m.amount,
                          createtie: m.createTime, 
                          amount: m.withdrawAmount, 
                          fee: m.fee,
                          remark: _getRemark(m.status)
                        );
                      }
                    }
                  ),
                ),
              ),
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
  final int createtie;
  final String remark;
  final num chanFee;
  final int status;
  final num fee;
  const _Cell({Key key, this.coinName, this.fee, this.chanFee = 0, this.status, this.amount, this.createtie, this.remark}) : super(key: key);@override

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
                SizedBox(width: 10,),
                Text(Tool.timeFormat("yyyy-MM-dd HH:mm", createtie), style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                Spacer(),
                Text(remark, style: AppFont.textStyle(12, color: _getColor()),),
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
                    Text(I18n.of(context).realnum + "($coinName)", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
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
                    Text(I18n.of(context).remark, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
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
  final String title;
  final bool isselected;
  final bool isright;
  final Function() onTap;
  const _Button({Key key, this.onTap, this.isright = false, this.title, this.isselected = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isselected ? AppColor.back998 : const Color(0xff7BA0B9).withOpacity(0.1),
          borderRadius: isright ? BorderRadius.horizontal(right: Radius.circular(4)) : BorderRadius.horizontal(left: Radius.circular(4))
        ),
        child: Text(title, style: AppFont.textStyle(12, color: isselected ?  Colors.white : AppColor.back998),),
      ),
    );
  }
}