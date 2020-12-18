import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/event_bus.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';
import 'package:migo/login&regist/view/sms_counter.dart';
import 'package:migo/provider/user.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MineExchangeBindPage extends StatefulWidget {
  @override
  _MineExchangeBindPageState createState() => _MineExchangeBindPageState();
}

class _MineExchangeBindPageState extends State<MineExchangeBindPage> {
  TextEditingController _editingController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _oldcodeController = TextEditingController();
  FocusNode _oldFocunode = FocusNode();
  FocusNode _focusNode = FocusNode();
  FocusNode _codefocusNode = FocusNode();
  String phone = "";
  /// 手机号
  int type = 1;
  String oldphone = "";
  String contryCode = "--";
  String oldContryCode = "";
  @override
  void dispose() {
    _editingController.dispose();
    _codeController.dispose();
    _oldcodeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100)).then((value){
      if(mounted) setState(() {
        final data = Provider.of<UserModel>(context, listen: false).data;
        type = data.registerType;
        if(data.registerType == 1) {
          oldphone = data.internationalCode + "_" + data.mobile;
        } else {
          oldphone = data.email;
        }
      });
    });
    _initCode();
  }

  void _submit() {
    if(_oldcodeController.text.isEmpty) {
      EasyLoading.showToast(I18n.of(context).pleaseinput);
      return;
    }

    if(_editingController.text.isEmpty) {
      EasyLoading.showToast(I18n.of(context).pleaseinputphone);
      return;
    }
    if(_codeController.text.isEmpty) {
      EasyLoading.showToast(I18n.of(context).verificationcode);
      return;
    }

    EasyLoading.show(status: "Loading...");
    final temp = Provider.of<UserModel>(context, listen: false);
      Networktool.request(API.changeBinding2, params: {
          "userCode": _codeController.text,
          "userNumber": _editingController.text,
          "userOldCode": _oldcodeController.text,
          "userOldNumber": temp.data.registerType == 1 ? temp.data.mobile : temp.data.email,
          "internationalCode":contryCode.replaceFirst("+", "")
      }, success: (data) {
        EasyLoading.showToast(I18n.of(context).success);
        // final temp = Provider.of<UserModel>(context, listen: false);
        // final curr = temp.data;
        // curr.mobile = _editingController.text;
        // curr.registerType = 1;
        // temp.setModel(curr);
        // SharedPreferences.getInstance().then((value) => value.clear());// 清楚用户数据
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }, fail: (msg) => EasyLoading.showToast(msg),);
  }

  void _initCode() async {
    final country = await getDefaultCountry(context);
    setState(() {
      contryCode = country.callingCode;
    });
  }

  void _createBuild() async {
    final country = await showCountryPickerSheet(context,);
    if (country != null) {
      setState(() {
        contryCode = country.callingCode;
      });
    }
  }

  String _getuserAccount() {
    final temp = Provider.of<UserModel>(context, listen: false);
    if(temp.data.registerType == 1) {
      return "+"+temp.data.internationalCode + temp.data.mobile;
    } else {
      return temp.data.email;
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).changebind,
        onPop: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 14),
                child: Text(I18n.of(context).currbind, style: AppFont.textStyle(16, color: const Color(0xffDBF0FF), fontWeight: FontWeight.bold, showshadow: true),),
              ),
              Container(
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.only(left: 14),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/bg_list_bound_def.png"),
                    fit: BoxFit.fill
                  )
                ),
                alignment: Alignment.centerLeft,
                child: Consumer<UserModel>(builder: (context, value, child) => Text(_getuserAccount(), style: AppFont.textStyle(14, color: Colors.white, showshadow: true),),)
              ),
              SizedBox(height: 16,),
              Stack(
                children: [
                  NormalTextfield(
                    hintText: I18n.of(context).verificationcode,
                    backgroundColor: Colors.white,
                    maxLength: 6,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    focusNode: _oldFocunode,
                    controller: _oldcodeController,
                  ),
                  Positioned(
                    right: 12,
                    top: 0,
                    bottom: 0,
                    child: Center(child: SmsCounterView(phone: oldphone, isemail: type != 1,)),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 14, top: 16),
                child: Text(I18n.of(context).changebind, style: AppFont.textStyle(16, color: const Color(0xffDBF0FF), fontWeight: FontWeight.bold, showshadow: true),),
              ),
              Stack(
                children: [
                  NormalTextfield(
                    hintText: I18n.of(context).pleaseinputphone,
                    align: TextAlign.right,
                    controller: _editingController,
                    focusNode: _focusNode,
                    onChanged: (val) {
                      setState(() {
                        phone = val;
                      });
                    },
                    onSubmited: (val) {
                      setState(() {
                        phone = val;
                      });
                    },
                  ),
                  Positioned(
                    left: 5,
                    top: 8,
                    bottom: 8,
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.only(left: 12),
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: _createBuild,
                        child: Row(
                          children: [
                            Text(I18n.of(context).phone + contryCode, style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),),
                            SizedBox(width: 6,),
                            Image.asset("assets/sign_choos_arrow_down.png"),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Stack(
                children: [
                  NormalTextfield(
                    hintText: I18n.of(context).verificationcode,
                    backgroundColor: Colors.white,
                    maxLength: 6,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    focusNode: _codefocusNode,
                    controller: _codeController,
                  ),
                  Positioned(
                    right: 12,
                    top: 0,
                    bottom: 0,
                    child: Center(child: SmsCounterView(phone: contryCode.replaceFirst("+", "") + "_" + phone, isemail: false,)),
                  )
                ],
              ),

              // Padding(
              //   padding: const EdgeInsets.only(left: 6.0, top: 10),
              //   child: Row(
              //     children: [
              //       Image.asset("assets/sign_tip_arrow_right.png"),
              //       SizedBox(width: 6,),
              //       Expanded(child: Text(I18n.of(context).bindrule, style: AppFont.textStyle(14, color: const Color(0xffDBF0FF), fontWeight: FontWeight.bold, showshadow: true),))
              //     ],
              //   ),
              // ),
              SizedBox(height: 46,),
              BtnImageBottomView(
                title: I18n.of(context).submit,
                onTap: _submit,
              )
            ],
          ),
        ),
      ),
    );
  }
}