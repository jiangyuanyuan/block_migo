import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:migo/common/commview/bottom_buttom.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';
import 'package:migo/login&regist/view/sms_counter.dart';

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
  bool showerror = false;
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
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      NormalTextfield(
                          controller: _emailController,
                          focusNode: _emailNode,
                          backgroundColor: Colors.transparent,
                          hintText: I18n.of(context).pleaseinputemail,
                          keyboardType: TextInputType.emailAddress,
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
                      Visibility(
                        visible: showerror,
                        child: Positioned.fill(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                showerror = false;
                                _emailNode.requestFocus();
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(4.5),
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 10),
                              color: const Color(0xffFFE7E7),
                              child: Text("用户名或密码错误", style: AppFont.textStyle(12, color: AppColor.red),),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: widget.modtype == 0,
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
                  visible: widget.modtype != 0,
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
                          child: Center(child: SmsCounterView(phone: phone, isemail: true,)),
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
                      if(widget.onLogin != null)widget.onLogin(_emailController.text, _pwdController.text);
                    },
                    title: widget.modtype == 0 ? I18n.of(context).login : I18n.of(context).next,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Visibility(
                    visible: widget.modtype == 0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pushNamed(context, "/login", arguments: {'modtype': 3}),
                            child: Text(I18n.of(context).forgetpwd, style: AppFont.textStyle(12, color: Colors.black54),)
                          ),
                          Container(
                            height: 10,
                            width: 1.5,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            color: const Color(0xffD8D8D8),
                          ),
                          Text(I18n.of(context).register, style: AppFont.textStyle(12, color: AppColor.back998),)
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