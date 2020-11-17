import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/custom_menu_view.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';
import 'package:migo/login&regist/view/sms_counter.dart';
import 'package:migo/page/contract/view/alert_password_view.dart';
import 'package:migo/provider/user.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class MineExchangeBindPage extends StatefulWidget {
  @override
  _MineExchangeBindPageState createState() => _MineExchangeBindPageState();
}

class _MineExchangeBindPageState extends State<MineExchangeBindPage> {
  TextEditingController _editingController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  FocusNode _codefocusNode = FocusNode();
  String phone = "";
  /// 手机号
  int type = 1;

  String contryCode = "--";
  
  @override
  void dispose() {
    _editingController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100)).then((value){
      if(mounted) setState(() {
        type = Provider.of<UserModel>(context, listen: false).data.registerType;
      });
    });
    _initCode();
  }

  void _submit() {
    if(_editingController.text.isEmpty) {
      EasyLoading.showToast(type == 1 ? I18n.of(context).pleaseinputphone : I18n.of(context).pleaseinputemail);
      return;
    }
    if(_codeController.text.isEmpty) {
      EasyLoading.showToast(I18n.of(context).verificationcode);
      return;
    }

    Alert.showBottomViewDialog(context, AlertPasswordView(onSure: (pwd) {
      EasyLoading.show(status: "Loading...");
      Networktool.request(API.changeBinding, params: {
        	"txPwd": Tool.generateMd5(pwd),
          "userCode": _codeController.text,
          "userNumber": _editingController.text
      }, success: (data) {
        EasyLoading.showToast(I18n.of(context).success);
        final temp = Provider.of<UserModel>(context, listen: false);
        final curr = temp.data;
        if(type == 1) {
          curr.mobile = _editingController.text;
        } else {
          curr.email = _editingController.text;
        }
        temp.setModel(curr);
        Navigator.pop(context);
      }, fail: (msg) => EasyLoading.showToast(msg),);
    },));
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
                child: Consumer<UserModel>(builder: (context, value, child) => Text(value.data.mobile ?? value.data.email, style: AppFont.textStyle(14, color: Colors.white, showshadow: true),),)
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 14, top: 24),
                child: Text(I18n.of(context).changebind, style: AppFont.textStyle(16, color: const Color(0xffDBF0FF), fontWeight: FontWeight.bold, showshadow: true),),
              ),
              Stack(
                children: [
                  NormalTextfield(
                    hintText: type == 1 ? I18n.of(context).pleaseinputphone : I18n.of(context).pleaseinputemail,
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
                        onTap: type == 1 ? _createBuild : null,
                        child: Row(
                          children: [
                            Text(type == 1  ? (I18n.of(context).phone + contryCode) : I18n.of(context).email, style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),),
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
                    child: Center(child: SmsCounterView(phone: type == 1 ? (contryCode.replaceFirst("+", "") + "_" + phone) : phone, isemail: type != 1,)),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(left: 6.0, top: 10),
                child: Row(
                  children: [
                    Image.asset("assets/sign_tip_arrow_right.png"),
                    SizedBox(width: 6,),
                    Expanded(child: Text(I18n.of(context).bindrule, style: AppFont.textStyle(14, color: const Color(0xffDBF0FF), fontWeight: FontWeight.bold, showshadow: true),))
                  ],
                ),
              ),
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