import 'package:migo/login&regist/model/user_model.dart';
import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  
  String _nickname;
  String _avatar;
  String _label;

  String _id;
  String _mobile;
  String _salt;
  String _inviteCode;
  /// 会员到期时间
  int _endTime;
  /// 用户等级 0 未点亮用户 1普通用户 2代理商 3合伙人
  int _userLevel;
  /// userType 0未加入用户 1普通用户, 交易权限为0时不可操作策略
  int _userType;

  UserModel() {
    _nickname = "币小贝";
    _label = "一个懂交易的币小贝";
    _avatar = "";
    _userType = 0;
    _userLevel = 0;
    _initData();
  }

  void _initData() {
    UserInfoModel.data().then((value) {
      if(value != null) setModel(value);
    });
  }

  String get nickname => _nickname;
  String get avatar => _avatar;
  String get label => _label;
  String get mobile => _mobile;
  String get id => _id;
  String get inviteCode => _inviteCode; // 邀请码
  String get salt => _salt;
  int get userLevel => _userLevel;
  int get endTime => _endTime;
  int get userType => _userType;

  void setNickname(String val) {
    _nickname = val;
    notifyListeners();
  }

  void setModel(UserInfoModel model) {
    _id = model.id;
    _mobile = model.mobile;
    _salt = model.salt;
    _label = model.userSign ?? "一个懂交易的币小贝";
    _nickname = model.nickName ?? "币小贝";
    _inviteCode = model.inviteCode;
    _avatar = model.logo ?? "";
    _endTime = model.endTime;
    _userLevel = model.userLevel;
    _userType = model.userType;
    // 缓存用户信息
    UserInfoModel.saveData(model.toJson());
    notifyListeners();
  }

  void setAvatar(String val) {
    _avatar = val;
    notifyListeners();
  }

  void setLabel(String val) {
    _label = val;
    notifyListeners();
  }

  void setLevel(int val) {
    _userLevel = val;
    notifyListeners();
  }

  void setEndTime(int val) {
    _endTime = val;
    notifyListeners();
  }
}