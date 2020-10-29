import 'package:flutter/material.dart';

import 'captcha/block_puzzle_captcha.dart';
import 'captcha/click_word_captcha.dart';
class AuthManager {
   //点选拼图
  static void loadingClickWord(BuildContext context, {barrierDismissible = true}) {
    showDialog<Null>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return ClickWordCaptcha(
          onSuccess: (v){

          },
          onFail: (){

          },
        );
      },
    );
  }

  //滑动拼图
  static void loadingBlockPuzzle(BuildContext context, {barrierDismissible = true}) {
    showDialog<Null>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return BlockPuzzleCaptchaPage(
          onSuccess: (v){

          },
          onFail: (){

          },
        );
      },
    );
  }
}