import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class AlertPasswordView extends StatelessWidget {
  final Function(String pwd) onSure;
  String pwd;
  AlertPasswordView({Key key, this.onSure}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(8))
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 24,),
                Text(I18n.of(context).pleasetxpassword, style: AppFont.textStyle(14,color: AppColor.back998, fontWeight: FontWeight.bold),),
                IconButton(
                  icon: Icon(Icons.cancel, color: const Color(0xffdedede),),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            Divider(height: 1,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: _InputPwdView(onChanged: (sender) => pwd = sender,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 27.0, right: 27, bottom: 40),
              child: BtnAction(
                title: I18n.of(context).sure,
                onTap: () {
                  if(pwd.length < 6) {
                    return;
                  } else {
                    Navigator.pop(context);
                    if(onSure != null) onSure(pwd);
                  }
                },
              ),
            )
          ]
        )
      )
    );
  }
}

class _InputPwdView extends StatefulWidget {
  final Function(String sender) onChanged;

  const _InputPwdView({Key key, this.onChanged}) : super(key: key);
  @override
  __InputPwdViewState createState() => __InputPwdViewState();
}

class __InputPwdViewState extends State<_InputPwdView> {
  final _pinEditingController = TextEditingController();
  final PinDecoration _pinDecoration = BoxLooseDecoration(
    textStyle: AppFont.textStyle(35, color: AppColor.font333),
    // bgColorBuilder: PinListenColorBuilder(Colors.grey, Colors.grey[400]),
    strokeColorBuilder: PinListenColorBuilder(const Color(0xffEDEDED), const Color(0xffEDEDED)),
    strokeWidth: 1.0,
    gapSpace: 6,
    obscureStyle: ObscureStyle(
      isTextObscure: true,
      obscureText: '●',
    ),
  );

  @override
  void dispose() {
    _pinEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 27),
      child: PinInputTextField(
        pinLength: 6,
        decoration: _pinDecoration,
        controller: _pinEditingController,
        inputFormatter: [WhitelistingTextInputFormatter.digitsOnly],
        textInputAction: TextInputAction.done,
        enabled: true,
        autoFocus: true,
        keyboardType: TextInputType.number,
        textCapitalization: TextCapitalization.characters,
        onSubmit: (pin) {
          debugPrint('submit pin:$pin');
        },
        onChanged: (pin) {
          if(widget.onChanged != null) widget.onChanged(pin);
        },
        enableInteractiveSelection: true,
      ),
    );
  }
}