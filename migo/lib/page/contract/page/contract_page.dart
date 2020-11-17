import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/contract/model/exchange_model.dart';
import 'package:migo/page/contract/view/alert_exchange_view.dart';
import 'package:migo/page/contract/view/alert_password_view.dart';
import 'package:migo/page/contract/view/exchange_bottom_view.dart';
import 'package:migo/page/contract/view/exchange_cell.dart';

class ContractPage extends StatefulWidget {
  @override
  _ContractPageState createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  Animation<double> _animation;
  ExhangeModel exchangeCoinModel;
  List<String> outputTitles = [];
  String outputAmount = "0.0";
  String currCoinName = "";
  String price = "";
  String outcoinname = "";
  String inputAmout = "";
  // String outputAmout = "0.0";

  num inputnumber = 1.0;
  num outputnumber = 1.0;
  num computeFee = 0.0;
  /// 当前手续费
  num currfee = 0;
  /// 下一级别手续费
  num nextfee = 0;
  TextEditingController _precontroller = TextEditingController();
  TextEditingController _sufcontroller = TextEditingController();
  FocusNode _preFocusNode = FocusNode();
  FocusNode _sufFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.addListener(() { 
      setState(() {
        
      });
    });

    _request();
  }

  @override
  void dispose() {
    _precontroller.dispose();
    _sufcontroller.dispose();
    super.dispose();
  }

  void _submit() {
    if(_animation.value == 1) {
      if(outcoinname == "") {
        EasyLoading.showToast("请选择兑换币种");
        return;
      }
      if(inputAmout == "") {
        EasyLoading.showToast("请输入数量");
        return;
      }
      Alert.showBottomViewDialog(context, AlertExhangeView(
        currCoinName: currCoinName,
        price: price,
        outCoinName: outcoinname,
        inputAmout: inputAmout,
        outputAmount: outputAmount,
        fee: "${Tool.number(currfee * 100, 2)}%",
        level: "${exchangeCoinModel?.level}",
        onSure: () {
        Future.delayed(const Duration(milliseconds: 100)).then((value) => _jump());
      },));
    } else {
      _animationController.forward();
    }
  }

  void _request() {
    Networktool.request(API.exchangePage, method: HTTPMETHOD.GET, success: (data){
      final temp = ExchangeResponse.fromJson(data);
      exchangeCoinModel = temp.data;
      if(exchangeCoinModel.canUseInputCoinNames != null && exchangeCoinModel.canUseInputCoinNames.length > 0) currCoinName = exchangeCoinModel.canUseInputCoinNames.first;
      if(exchangeCoinModel?.canUseInputCoinNames != null && exchangeCoinModel.canUseInputCoinNames.length > 0) {
        _onselectedCoin(exchangeCoinModel.canUseInputCoinNames.first, 0);
      }
      
      if(mounted) setState(() {
        
      });
    });
  }

  void _jump() {
    Alert.showBottomViewDialog(context, AlertPasswordView(onSure: (sender) {
        EasyLoading.show(status: "Loading...");
        Networktool.request(API.exchangePagePost, params: {
          	"inputCoinAmount": inputAmout,
            "ntn": "$currCoinName/$outcoinname",
            "oneInToOutAmount": Tool.number(computeFee, 4),
            "outputCoinAmount": outputAmount,
            "txPwd": Tool.generateMd5(sender)
        }, success: (data) {
          EasyLoading.showSuccess(I18n.of(context).success);
          
          Navigator.pushNamed(context, "/exchangesuccess", arguments: {"time":DateTime.now().millisecondsSinceEpoch, "count":outputAmount, "coinName":outcoinname});
          Future.delayed(const Duration(milliseconds: 500)).then((value) {
            _precontroller.clear();
            _sufcontroller.clear();
            outputAmount = "0";
            _clear();
            _request();
          });
        },fail: (msg) => EasyLoading.showError(msg),);
    }));
  }

  void _onselectedCoin(String val, int index) {
    if(currCoinName == val && outcoinname != "") return;
    outputTitles.clear();
    currCoinName = val;
    outputAmount = "0";
    _precontroller.clear();
    _sufcontroller.clear();
    _clear();
    exchangeCoinModel.tradings.forEach((element) { 
      if(element.ntn.startsWith(val)){
        outputTitles.add(element.ntn.split("/").last);
      }
    });
    _onselectedCoin2(outputTitles.first, 0);
    setState(() {
      
    });
  }

  void _clear() {
    _preFocusNode.unfocus();
    _sufFocusNode.unfocus();
  }

  void _onselectedCoin2(String val, int index) {
    outcoinname = val;
    final e = exchangeCoinModel.tradings.firstWhere((element) => element.ntn == "$currCoinName/$val");
    price = e.oneInToOutAmount.toString();
    currfee = e.levelReduction;
    nextfee = e.levelReduction - e.nextLevelReduction;
    inputnumber = e.inputCoinAmount;
    outputnumber = e.outputCoinAmount;
    setState(() {
      
    });
  }

  void _inputAmout(String val) {
    final e = exchangeCoinModel.tradings.firstWhere((element) => element.ntn.startsWith(currCoinName), orElse: () => null,);
    inputAmout = val;
    if(e != null) {
      num percent = outputnumber / (inputnumber + double.parse(inputAmout));
      num res = percent / (1 + currfee);
      computeFee = res;
      outputAmount = Tool.number(res * num.parse(val), 2);
    }
    setState(() {
      
    });
  }

  String _computeString() {
    num res = currfee - nextfee;
    return Tool.number(res * 100, 4);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: _clear,
        behavior: HitTestBehavior.translucent,
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/背景图.png"),
              fit: BoxFit.cover
            )
          ),
          child: SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 390 + _animation.value * 180,
                    child: ExchangeBottomView(
                      getAmount: outputAmount,
                      level: "${exchangeCoinModel?.level ?? 0}",
                      fee: "${Tool.number(currfee * 100, 2)}%",
                    ),
                  ),
                  Positioned.fill(
                    child: Column(
                      children: [
                        NormalAppbar.normal(
                          color: Colors.transparent,
                          title: Text(I18n.of(context).exchange,style: AppFont.textStyle(14, color: Colors.white),),
                          leading: SizedBox()
                        ),
                        SizedBox(height: 18,),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 19),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8, 
                                color: Colors.black.withOpacity(0.3), 
                                spreadRadius: 0,
                                offset: Offset(0, 2)
                              )
                            ]
                          ),
                          child: Column(
                            children: [
                              Text(I18n.of(context).exchange, style: AppFont.textStyle(14, color: AppColor.back998, fontWeight: FontWeight.bold),),
                              Padding(
                                padding: const EdgeInsets.only(top:19.0, bottom: 17),
                                child: ExchangeCell(
                                  titles: exchangeCoinModel?.canUseInputCoinNames ?? [], 
                                  onSelected: _onselectedCoin,
                                  tradings: exchangeCoinModel?.tradings,
                                  onChanged: _inputAmout,
                                  controller: _precontroller,
                                  focusNode: _preFocusNode,
                                ),
                              ),
                              Image.asset("assets/pull_next.png"),
                              Padding(
                                padding: const EdgeInsets.only(top:19.0),
                                child: ExchangeCell(
                                  ispre: false, 
                                  titles: outputTitles,
                                  onSelected: _onselectedCoin2,
                                  outputAmount: outputAmount,
                                  currCoinsName: outcoinname,
                                  controller: _sufcontroller,
                                  focusNode: _sufFocusNode,
                                  tradings: exchangeCoinModel?.tradings,
                                ),
                              ),
                              SizedBox(height: 32,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Text(I18n.of(context).price, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        child: Text(I18n.of(context).currlevel("M${exchangeCoinModel?.level ?? 0}"), style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                                      ),
                                      Text(I18n.of(context).nextlevel("M${exchangeCoinModel?.nextLevel ?? 0}"), style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // Row(
                                      //   children: [
                                      //     Text("$price ", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                                      //     Image.asset("assets/change_icon.png")
                                      //   ],
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        child: Text("${I18n.of(context).feereduction2}${Tool.number(currfee * 100, 2)}%", style: AppFont.textStyle(12, color: AppColor.back998),),
                                      ),
                                      Text("${I18n.of(context).feereduction}${Tool.number(nextfee * 100, 2)}%", style: AppFont.textStyle(12, color: AppColor.red),),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 30,),
                              BtnAction(
                                title: I18n.of(context).redeemnow,
                                onTap: _submit,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}