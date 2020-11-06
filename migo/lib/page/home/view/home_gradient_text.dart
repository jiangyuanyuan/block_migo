import 'package:flutter/material.dart';
import 'package:migo/common/commview/gradient_text.dart';

class HomeGradientText extends StatelessWidget {
  final TextStyle fontstyle;
  final String data;

  const HomeGradientText({Key key, this.fontstyle, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GradientText(
      data,
      gradient: LinearGradient(
        colors: [
          Color(0xffFFD765),
          Color(0xffFFD765),
          Color(0xffFF9C00),
          Color(0xffFFF5BE),
          Color(0xffFFF5BE)
        ],
        begin: Alignment.topCenter, 
        end: Alignment.bottomCenter,
        // stops: [
        //   1,
        //   0.5,
        //   0.1
        // ]
      ),
      style: fontstyle,
    );
  }
}