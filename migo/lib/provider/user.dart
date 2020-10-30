import 'package:migo/login&regist/model/user_model.dart';
import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  
  UserInfoModel data;

  UserModel() {
    _initData();
  }

  void _initData() {
    UserInfoModel.data().then((value) {
      if(value != null) setModel(value);
    });
  }

  void setModel(UserInfoModel model) {
    // 缓存用户信息
    data = model;
    UserInfoModel.saveData(model.toJson());
    notifyListeners();
  }
}