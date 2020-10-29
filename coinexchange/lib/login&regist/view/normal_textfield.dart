import 'package:coinexchange/common/const/cosnt.dart';
import 'package:coinexchange/common/textstyle/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NormalTextfield extends StatelessWidget {
  final String hintText;
  final EdgeInsets margin;
  final bool obscureText;
  final int maxLength;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final List<TextInputFormatter> inputFormatters;
  final TextEditingController controller;
  final Color backgroundColor;
  final double borderRadius;

  const NormalTextfield({
    Key key, 
    this.hintText, 
    this.margin,
    this.obscureText = false,
    this.maxLength,
    this.focusNode,
    this.keyboardType,
    this.inputFormatters,
    this.controller,
    this.borderRadius = 3,
    this.backgroundColor = AppColor.grey
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51,
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius)
      ),
      child: TextField(
        obscureText: obscureText,
        maxLength: maxLength,
        keyboardType: keyboardType,
        focusNode: focusNode,
        controller: controller,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelStyle: AppFont.textStyle(15, color: AppColor.font333),
          hintText: hintText,
          prefix: SizedBox(width: 15,),
          counterText: "",
          hintStyle: AppFont.textStyle(15, color: AppColor.fontgrey),
          suffix: SizedBox(width: 15,)
        ),
      ),
    );
  }
}