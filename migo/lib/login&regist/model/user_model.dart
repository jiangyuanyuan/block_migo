import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const String KEY_USER_INFO = "KEY_USER_INFO";

class UserInfoModel {
  String id;
  String logo;
  String mobile;
  String nickName;
  String password;
  String salt;
  String inviteCode;
  String userSign;
  int isSetPassword;
  /// 会员到期时间
  int endTime;
  /// 用户等级 0 未点亮用户 1普通用户 2代理商 3合伙人
  int userLevel;
  /// userType 0未加入用户 1普通用户, 交易权限为0时不可操作策略
  int userType;

  UserInfoModel(
      {this.id,
      this.logo,
      this.mobile,
      this.nickName,
      this.password,
      this.salt,
      this.endTime,
      this.userLevel,
      this.userSign,
      this.userType,
      this.inviteCode,
      this.isSetPassword});
  
  static void saveData(Map<String, dynamic> val) {
    SharedPreferences.getInstance().then((value) => value.setString(KEY_USER_INFO, json.encode(val)));
  }

  static Future<UserInfoModel> data() async {
    final share = await SharedPreferences.getInstance();
    final str = share.getString(KEY_USER_INFO);
    if(str == null) return null;
    return UserInfoModel.fromJson(json.decode(str));
  }

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
    mobile = json['mobile'];
    nickName = json['nickName'];
    userType = json['userType'] ?? 0;
    password = json['password'];
    salt = json['salt'];
    userLevel = json['userLevel'] ?? 0;
    endTime = json['endTime'];
    userSign = json['userSign'];
    inviteCode = json['inviteCode'];
    isSetPassword = json['isSetPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['endTime'] = this.endTime;
    data['logo'] = this.logo;
    data['mobile'] = this.mobile;
    data['nickName'] = this.nickName;
    data['password'] = this.password;
    data['salt'] = this.salt;
    data['userLevel'] = this.userLevel;
    data['inviteCode'] = this.inviteCode;
    data['isSetPassword'] = this.isSetPassword;
    data['userSign'] = this.userSign;
    data['userType'] = this.userType;
    return data;
  }
}
