import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/page/home/view/home_gradient_text.dart';

class HeadDetailView extends StatelessWidget {
  final String title;
  final String detail;
  final bool isright;
  const HeadDetailView({Key key, this.isright = false, this.title, this.detail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isright ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(title, style: AppFont.textStyle(
            12, 
            color: const Color(0xffDBF0FF),
            showshadow: true
          ),
        ),
        SizedBox(height: 8,),
        HomeGradientText(
          data: detail ?? "--",
          fontstyle: AppFont.textStyle(
            16, 
            fontWeight: FontWeight.bold,
            showshadow: true
          ),
        )
      ],
    );
  }
}