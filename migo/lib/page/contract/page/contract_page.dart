import 'package:flutter/material.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.addListener(() { 
      setState(() {
        
      });
    });
  }

  void _submit() {
    
    if(_animation.value == 1) {
      Alert.showBottomViewDialog(context, AlertExhangeView(onSure: () {
        Future.delayed(const Duration(milliseconds: 100)).then((value) => _jump());
      },));
    } else {
      _animationController.forward();
    }
  }

  void _jump() {
    Alert.showBottomViewDialog(context, AlertPasswordView(onSure: (sender) {
        Navigator.pushNamed(context, "/exchangesuccess");
      },));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
                  top: 390 + _animation.value * 200,
                  child: ExchangeBottomView(),
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
                              child: ExchangeCell(),
                            ),
                            Image.asset("assets/pull_next.png"),
                            Padding(
                              padding: const EdgeInsets.only(top:19.0),
                              child: ExchangeCell(ispre: false,),
                            ),
                            SizedBox(height: 32,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(I18n.of(context).price, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      child: Text(I18n.of(context).currlevel("M5"), style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                                    ),
                                    Text(I18n.of(context).nextlevel("M6"), style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Text("1.343747 / MICO", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                                        Icon(Icons.change_history)
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      child: Text("${I18n.of(context).feereduction}10%", style: AppFont.textStyle(12, color: AppColor.back998),),
                                    ),
                                    Text("${I18n.of(context).feereduction}20%", style: AppFont.textStyle(12, color: AppColor.red),),
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
    );
  }
}