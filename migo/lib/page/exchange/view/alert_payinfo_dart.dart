import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/screen_tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/model/banner_model.dart';
import 'package:migo/page/mine/model/mine_pay_model.dart';

class AlertPayInfoView extends StatelessWidget {
  final List<PaymethodModel> list;
  final Function(PaymethodModel sender) onSelect;
  const AlertPayInfoView({Key key, this.list, this.onSelect}) : super(key: key);
  
  Widget _creatBank(BuildContext context, PaymethodModel bankmodel) {
    if(bankmodel == null) return SizedBox();
    return InkWell(
      onTap: () {
        if(onSelect != null) onSelect(bankmodel);
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(I18n.of(context).bankpay, style: AppFont.textStyle(14, color: Colors.black, fontWeight: FontWeight.bold),),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffE5F0FA),
                borderRadius: BorderRadius.circular(4)
              ),
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 2),
              child: Column(
                children: [
                  _ItemLabel(title: I18n.of(context).susername, val: bankmodel.payName,),
                  _ItemLabel(title: I18n.of(context).banknumber, showIcon: true, val: bankmodel.payNo, onTap: () {
                    ScreenTool.copy(bankmodel.payNo);
                  },),
                  _ItemLabel(title: I18n.of(context).bankename, val: bankmodel.openBank,),
                  _ItemLabel(title: I18n.of(context).bankbranch, val: bankmodel.openBranchBank ?? "--",),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createAli(BuildContext context, PaymethodModel alimodel) {
    if(alimodel == null) return SizedBox();
    return InkWell(
              onTap: () {
                if(onSelect != null) onSelect(alimodel);
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(I18n.of(context).alipaypay, style: AppFont.textStyle(14, color: Colors.black, fontWeight: FontWeight.bold),),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffE5F0FA),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 2),
                      child: Column(
                        children: [
                          _ItemLabel(title: I18n.of(context).susername, val: alimodel.payName,),
                          _ItemLabel(title: I18n.of(context).alipayaccount, val: alimodel.payNo, onTap: () {
                            ScreenTool.copy(alimodel.payNo);
                          }, showIcon: true,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
  }

  Widget _createErc(BuildContext context, PaymethodModel ercmodel) {
    if(ercmodel == null) return SizedBox();
    return InkWell(
              onTap: () {
                if(onSelect != null) onSelect(ercmodel);
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(I18n.of(context).trcpay, style: AppFont.textStyle(14, color: Colors.black, fontWeight: FontWeight.bold),),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffE5F0FA),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 2),
                      child: Column(
                        children: [
                          _ItemLabel(title: I18n.of(context).susername, val: ercmodel.payName,),
                          _ItemLabel(title: I18n.of(context).saccountaddress, val: ercmodel.payNo, onTap: () {
                            ScreenTool.copy(ercmodel.payNo);
                          }, showIcon: true,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
  }

  @override
  Widget build(BuildContext context) {
    final bankmodel = list.firstWhere((element) => element.payWay == 2, orElse: () => null);
    final alimodel = list.firstWhere((element) => element.payWay == 1, orElse: () => null);
    final ercmodel = list.firstWhere((element) => element.payWay == 3, orElse: () => null);
    return Container(
      width: MediaQuery.of(context).size.width - 32,
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 40,),
              Text(I18n.of(context).alertpaynotice, style: AppFont.textStyle(14, color: AppColor.back998),),
              IconButton(
                  icon: Icon(Icons.cancel, color: Colors.black12,),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                  },
              )
            ],
          ),
          Divider(height: 1,),
          _creatBank(context,bankmodel),
          _createAli(context, alimodel),
          _createErc(context, ercmodel)
        ],
      ),
    );
  }
}

class _ItemLabel extends StatelessWidget {
  final String title;
  final String val;
  final Color color;
  final bool showIcon;
  final Function onTap;
  const _ItemLabel({Key key, this.title, this.onTap, this.showIcon = false, this.val, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
          Expanded(child: Text(val, style: AppFont.textStyle(12, color: color ?? AppColor.back998),)),
          Visibility(
            visible: showIcon,
            child: InkWell(
              onTap: onTap,
              child: Image.asset("assets/copy.png"))
            )
        ],
      ),
    );
  }
}