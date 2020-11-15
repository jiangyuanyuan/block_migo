class MinesTypeResponse {
  int code;
  String msg;
  List<MinesTypeModel> data;

  MinesTypeResponse({this.code, this.msg, this.data});

  MinesTypeResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<MinesTypeModel>();
      json['data'].forEach((v) {
        data.add(new MinesTypeModel.fromJson(v));
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

class MinesTypeModel {
  String name;
  String enName;
  int id;

  MinesTypeModel({this.name, this.enName, this.id});

  MinesTypeModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    enName = json['enName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['enName'] = this.enName;
    data['id'] = this.id;
    return data;
  }
}
