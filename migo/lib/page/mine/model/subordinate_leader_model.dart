import 'package:migo/page/mine/model/mine_team_model.dart';

class SubordinateLeaderModel {
  int code;
  String msg;
  List<SubordinateLeaderDTOModel> data;

  SubordinateLeaderModel({this.code, this.msg, this.data});

  SubordinateLeaderModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<SubordinateLeaderDTOModel>();
      json['data'].forEach((v) {
        data.add(new SubordinateLeaderDTOModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

