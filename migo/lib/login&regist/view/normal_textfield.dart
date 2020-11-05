import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/textstyle/textstyle.dart';
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
  final Function(String val) onSubmited;
  final Function(String val) onChanged;
  final TextAlign align;

  const NormalTextfield({
    Key key, 
    this.hintText, 
    this.margin,
    this.obscureText = false,
    this.maxLength,
    this.focusNode,
    this.align = TextAlign.left,
    this.keyboardType,
    this.inputFormatters,
    this.controller,
    this.borderRadius = 3,
    this.onChanged,
    this.onSubmited,
    this.backgroundColor = AppColor.grey
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51,
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        // color: backgroundColor,
        // borderRadius: BorderRadius.circular(borderRadius)
        image: DecorationImage(
          image: AssetImage("assets/input_back.png"),
          fit: BoxFit.fill
        )
      ),
      child: TextField(
        obscureText: obscureText,
        maxLength: maxLength,
        keyboardType: keyboardType,
        focusNode: focusNode,
        controller: controller,
        textAlign: align,
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