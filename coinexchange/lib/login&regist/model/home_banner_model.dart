class HomeBannerResponse {
  int code;
  String msg;
  List<HomeBannerModel> data;

  HomeBannerResponse({this.code, this.msg, this.data});

  HomeBannerResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<HomeBannerModel>();
      json['data'].forEach((v) {
        data.add(new HomeBannerModel.fromJson(v));
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

class HomeBannerModel {
  int id;
  String title;
  int type;
  String cnImage;
  String enImage;
  String url;
  int status;
  int adminId;
  int sortNo;
  int isShow;

  HomeBannerModel(
      {this.id,
      this.title,
      this.type,
      this.cnImage,
      this.enImage,
      this.url,
      this.status,
      this.adminId,
      this.sortNo,
      this.isShow});

  HomeBannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    cnImage = json['cnImage'];
    enImage = json['enImage'];
    url = json['url'];
    status = json['status'];
    adminId = json['adminId'];
    sortNo = json['sortNo'];
    isShow = json['isShow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['cnImage'] = this.cnImage;
    data['enImage'] = this.enImage;
    data['url'] = this.url;
    data['status'] = this.status;
    data['adminId'] = this.adminId;
    data['sortNo'] = this.sortNo;
    data['isShow'] = this.isShow;
    return data;
  }
}
