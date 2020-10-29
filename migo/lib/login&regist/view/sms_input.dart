import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class SmsInputView extends StatefulWidget {

  final Function(String code) onChanged;

  const SmsInputView({Key key, this.onChanged}) : super(key: key);

  @override
  _SmsInputViewState createState() => _SmsInputViewState();
}

class _SmsInputViewState extends State<SmsInputView> {

  final _pinEditingController = TextEditingController();
  final PinDecoration _pinDecoration = UnderlineDecoration(
    enteredColor: AppColor.font333,
    color: AppColor.fontgrey,
    textStyle: AppFont.textStyle(35, color: AppColor.font333),
    lineHeight: 2
  );

  @override
  void dispose() {
    _pinEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: PinInputTextField(
        pinLength: 6,
        decoration: _pinDecoration,
        controller: _pinEditingController,
        inputFormatter: [WhitelistingTextInputFormatter.digitsOnly],
        textInputAction: TextInputAction.go,
        enabled: true,
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