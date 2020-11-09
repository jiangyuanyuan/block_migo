import 'dart:math';

import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';


class CustomProgressView extends StatelessWidget {
  final double progress;
  final String titles;
  final bool issmall;

  const CustomProgressView({Key key, this.issmall = false, this.progress = 0, this.titles}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset("assets/${issmall ? "slider_small.png" : "slider_big.png"}", width: double.infinity, fit: BoxFit.fill,),
        Positioned.fill(
          child: Container(
            padding: issmall ? const EdgeInsets.all(4) : const EdgeInsets.all(6.5),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Positioned.fill(
                  child: Transform.rotate(
                    angle: pi,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.transparent,
                      value: 1 - progress,
                      valueColor: AlwaysStoppedAnimation(const Color(0xff3F1E1B)),
                    ),
                  ),
                ),
                Positioned.fill(child: Center(
                  child: Text(titles, style: AppFont.textStyle(issmall ? 8 : 14, color: Colors.white, showshadow: true, fontWeight: FontWeight.bold)))
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}