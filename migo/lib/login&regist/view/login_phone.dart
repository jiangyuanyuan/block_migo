import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:migo/common/commview/bottom_buttom.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';
import 'package:migo/login&regist/view/sms_counter.dart';

class LoginPhoneView extends StatefulWidget {
  final Function(String phone, String pwd, String phoneCode) onLogin;
  final int modetype;
  const LoginPhoneView({Key key, this.modetype, this.onLogin}) : super(key: key);
  @override
  _LoginPhoneViewState createState() => _LoginPhoneViewState();
}

class _LoginPhoneViewState extends State<LoginPhoneView> {

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  FocusNode _codefocusNode = FocusNode();
  FocusNode _phoneNode = FocusNode();
  FocusNode _pwdNode = FocusNode();
  bool ispwd = true;
  String phone = "";
  String contryCode = "+86";
  bool showerror = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _initCode();
  }

  void _clear() {
    _phoneNode.unfocus();
    _pwdNode.unfocus();
    _codefocusNode.unfocus();
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
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _clear();
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 24, right: 24, bottom: 10),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Stack(
                        children: [
                          NormalTextfield(
                              controller: _phoneController,
                              focusNode: _phoneNode,
                              backgroundColor: Colors.transparent,
                              hintText: I18n.of(context).pleaseinputphone,
                              keyboardType: TextInputType.number,
                              padding: const EdgeInsets.only(left: 50),
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              onSubmited: (val) {
                                setState(() {
                                  phone = val;
                                });
                                print(val);
                              },
                              onChanged: (val) {
                                setState(() {
                                  phone = val;
                                });
                                print(val);
                              },
                            ),
                          Positioned(
                            left: 10,
                            top: 0,
                            bottom: 0,
                            width: 50,
                            child: InkWell(
                              onTap: _createBuild,
                              child: Row(
                                children: [
                                  Text(contryCode, style: AppFont.textStyle(12, color: Colors.black),),
                                  SizedBox(width: 4,),
                                  Image.asset("assets/sign_choos_arrow_down.png")
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Visibility(
                        visible: showerror,
                        child: Positioned.fill(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                showerror = false;
                                _phoneNode.requestFocus();
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(4.5),
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 10),
                              color: const Color(0xffFFE7E7),
                              child: Text(I18n.of(context).erroraccount, style: AppFont.textStyle(12, color: AppColor.red),),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: widget.modetype == 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Stack(
                      children: [
                        NormalTextfield(
                          focusNode: _pwdNode,
                          controller: _pwdController,
                          hintText: I18n.of(context).pleaseinputpwd,
                          obscureText: ispwd,
                        ),
                        Positioned(
                          right: 0,
                          child: IconButton(
                            icon: Image.asset("assets/${ispwd ? "ico_passw_eye_show" : "ico_passw_eye_hide"}.png"),
                            onPressed: () {
                              setState(() {
                                ispwd = !ispwd;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.modetype != 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Stack(
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
                          child: Center(child: SmsCounterView(phone: contryCode + phone,)),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 22,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: BtnAction(
                    onTap: () {
                      _clear();
                      if(widget.onLogin != null)widget.onLogin(_phoneController.text, _pwdController.text, _codeController.text);
                    },
                    title: widget.modetype == 0 ? I18n.of(context).login : I18n.of(context).next,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Visibility(
                    visible: widget.modetype == 0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pushNamed(context, "/login", arguments: {'modtype': 3}),
                            child: Text(I18n.of(context).forgetpwd, style: AppFont.textStyle(12, color: Colors.black54),)
                          ),
                          // Container(
                          //   height: 10,
                          //   width: 1.5,
                          //   margin: const EdgeInsets.symmetric(horizontal: 10),
                          //   color: const Color(0xffD8D8D8),
                          // ),
                          // Text(I18n.of(context).register, style: AppFont.textStyle(12, color: AppColor.back998),)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}