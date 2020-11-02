import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:migo/common/commview/bottom_buttom.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';
import 'package:migo/login&regist/view/sms_counter.dart';
import 'package:migo/login&regist/view/sms_input.dart';

class LoginEmailView extends StatefulWidget {
  final Function(String phone, String pwd) onLogin;
  final int modtype;
  const LoginEmailView({Key key, this.modtype, this.onLogin}) : super(key: key);
  @override
  _LoginPhoneViewState createState() => _LoginPhoneViewState();
}

class _LoginPhoneViewState extends State<LoginEmailView> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  FocusNode _codefocusNode = FocusNode();
  FocusNode _emailNode = FocusNode();
  FocusNode _pwdNode = FocusNode();
  bool ispwd = true;
  String phone = "";
  @override
  void dispose() {
    _emailController.dispose();
    _pwdController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _clear() {
    _emailNode.unfocus();
    _pwdNode.unfocus();
    _codefocusNode.unfocus();
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
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 24, right: 24, bottom: 10),
                  child: NormalTextfield(
                    controller: _emailController,
                    focusNode: _emailNode,
                    hintText: I18n.of(context).pleaseinputemail,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    onSubmited: (val) {
                      setState(() {
                        phone = val;
                      });
                    },
                    onChanged: (val) {
                      setState(() {
                        phone = val;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
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
                Visibility(
                  visible: widget.modtype != 0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: NormalTextfield(
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
                        ),
                        SmsCounterView(phone: phone, isemail: true,)
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
                      if(widget.onLogin != null)widget.onLogin(_emailController.text, _pwdController.text);
                    },
                    title: widget.modtype == 0 ? I18n.of(context).confirmlogin : I18n.of(context).save,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("忘记密码", style: AppFont.textStyle(12, color: Colors.black54),),
                      Container(
                        height: 10,
                        width: 1.5,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        color: const Color(0xffD8D8D8),
                      ),
                      Text("注册新账号", style: AppFont.textStyle(12, color: AppColor.back998),)
                    ],
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