class HomeBoxRespose {
  int code;
  String msg;
  Data data;

  HomeBoxRespose({this.code, this.msg, this.data});

  HomeBoxRespose.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int totalCandy;
  List<HomeShovelModel> shovelList;

  Data({this.totalCandy, this.shovelList});

  Data.fromJson(Map<String, dynamic> json) {
    totalCandy = json['totalCandy'];
    if (json['shovelList'] != null) {
      shovelList = new List<HomeShovelModel>();
      json['shovelList'].forEach((v) {
        shovelList.add(new HomeShovelModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCandy'] = this.totalCandy;
    if (this.shovelList != null) {
      data['shovelList'] = this.shovelList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeShovelModel {
  String name;
  int count;

  HomeShovelModel({this.name, this.count});

  HomeShovelModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}
