import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:migo/common/commview/bottom_buttom.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';
import 'package:migo/login&regist/view/sms_counter.dart';

class LoginPhoneView extends StatefulWidget {
  final Function(String phone, String pwd) onLogin;
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
  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  void _clear() {
    _phoneNode.unfocus();
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
      child: Container(
        margin: const EdgeInsets.only(top: 42, left: 27, right: 27),
        child: Column(
          children: [
            NormalTextfield(
              controller: _phoneController,
              focusNode: _phoneNode,
              hintText: I18n.of(context).pleaseinputphone,
              keyboardType: TextInputType.number,
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
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: NormalTextfield(
                      focusNode: _pwdNode,
                      controller: _pwdController,
                      hintText: I18n.of(context).pleaseinputpwd,
                      obscureText: ispwd,
                    ),
                  ),
                  IconButton(
                    icon: Image.asset("assets/${ispwd ? "ico_passw_eye_show" : "ico_passw_eye_hide"}.png"),
                    onPressed: () {
                      setState(() {
                        ispwd = !ispwd;
                      });
                    },
                  )
                ],
              ),
            ),
            Visibility(
              visible: widget.modetype != 0,
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
                    SmsCounterView(phone: phone,)
                  ],
                ),
              ),
            ),
            SizedBox(height: 46,),
            BottomButton(
              margin: EdgeInsets.zero,
              onTap: () {
                _clear();
                if(widget.onLogin != null)widget.onLogin(_phoneController.text, _pwdController.text);
              },
              title: widget.modetype == 0 ? I18n.of(context).confirmlogin : I18n.of(context).save,
            )
          ],
        ),
      ),
    );
  }
}