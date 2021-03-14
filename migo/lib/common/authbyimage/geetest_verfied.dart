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


