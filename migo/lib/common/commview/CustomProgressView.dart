import 'dart:math';

import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';

import 'btn_image_bottom.dart';

class CustomProgressView extends StatelessWidget {
  final String backImage;
  final double progress;
  final String titles;

  const CustomProgressView({Key key, this.backImage = "btn_active.png", this.progress, this.titles}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset("assets/btn_active.png", width: double.infinity, fit: BoxFit.fill,),
        Positioned.fill(
          child: Container(
            padding: const EdgeInsets.all(9.0),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Positioned.fill(
                  child: Transform.rotate(
                    angle: pi,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.transparent,
                      value: 0.3,
                      valueColor: AlwaysStoppedAnimation(const Color(0xff3F1E1B)),
                      semanticsValue: "asdf",
                    ),
                  ),
                ),
                Positioned.fill(child: Center(
                  child: Text(titles, style: AppFont.textStyle(14, color: Colors.white, showshadow: true, fontWeight: FontWeight.bold)))
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}