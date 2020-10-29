import 'package:flutter/material.dart';

import 'package:coinexchange/common/const/cosnt.dart';
import 'package:coinexchange/common/textstyle/textstyle.dart';
import 'package:flutter/services.dart';

class PhoneTextFieldView extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  const PhoneTextFieldView({Key key, this.hintText, this.controller, this.focusNode}) : super(key: key);

  @override
  _MineTextFieldViewState createState() => _MineTextFieldViewState();
}

class _MineTextFieldViewState extends State<PhoneTextFieldView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51,
      decoration: BoxDecoration(
        color: AppColor.grey,
        borderRadius: BorderRadius.circular(3)
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        maxLength: 11,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelStyle: AppFont.textStyle(15, color: AppColor.font333),
          hintText: widget.hintText,
          counterText: "",
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("+86", style: AppFont.textStyle(15, color: AppColor.font333),),
                Icon(Icons.arrow_drop_down, color: AppColor.font333,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 15, 15, 15),
                  child: VerticalDivider(width: 1.5, color: const Color(0xffcccccc),),
                ) ],
            ),
          ),
          hintStyle: AppFont.textStyle(15, color: AppColor.fontgrey),
          suffixIcon: SizedBox(width: 15,)
        ),
      ),
    );
  }
}