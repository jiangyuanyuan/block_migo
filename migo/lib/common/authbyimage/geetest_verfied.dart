import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_geetest_plugin/flutter_geetest_plugin.dart';
import 'package:migo/common/network/network.dart';

class GeetestResult {
  String geetestChallenge;
  String geetestSeccode;
  String geetestValidate;

  GeetestResult(
      {this.geetestChallenge, this.geetestSeccode, this.geetestValidate});

  GeetestResult.fromJson(Map<String, dynamic> json) {
    geetestChallenge = json['geetest_challenge'];
    geetestSeccode = json['geetest_seccode'];
    geetestValidate = json['geetest_validate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['geetest_challenge'] = this.geetestChallenge;
    data['geetest_seccode'] = this.geetestSeccode;
    data['geetest_validate'] = this.geetestValidate;
    return data;
  }
}

class GeetestVerfied {
  GeetestVerfied._privateConstructor();

  static final GeetestVerfied _instance = GeetestVerfied._privateConstructor();

  factory GeetestVerfied(){
    return _instance;
  }

   Future<void> show(Function(GeetestResult geetestResult) onfinish) async {
    String result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await FlutterGeetestPlugin.getGeetest("http://93.179.126.85:8079/"+API.gtRegister, "http://93.179.126.85:8079/"+API.gtValidate);
    } on Exception {
//      platformVersion = 'Failed to get platform version.';
    }
    print("极验："+result);
    // EasyLoading.showToast("极验："+result,duration: Duration(milliseconds: 100000));
    GeetestResult geetestResult;
    if (result !=null && result!=""){
       geetestResult = GeetestResult.fromJson(json.decode(result));
    }
    if(onfinish !=null&&geetestResult!=null) {
      // EasyLoading.showToast("极验："+geetestResult.geetestValidate,duration: Duration(milliseconds: 100000));
      onfinish(geetestResult);
    }
  }


}

