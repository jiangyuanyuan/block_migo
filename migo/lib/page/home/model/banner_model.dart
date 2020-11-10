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
  String id;
  int createTime;
  String bannerUrl;
  String bannerPage;
  Null param;
  String title;
  String type;
  String url;
  int isShow;

  HomeBannerModel(
      {this.id,
      this.createTime,
      this.bannerUrl,
      this.bannerPage,
      this.param,
      this.title,
      this.type,
      this.url,
      this.isShow});

  HomeBannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['createTime'];
    bannerUrl = json['bannerUrl'];
    bannerPage = json['bannerPage'];
    param = json['param'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
    isShow = json['isShow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createTime'] = this.createTime;
    data['bannerUrl'] = this.bannerUrl;
    data['bannerPage'] = this.bannerPage;
    data['param'] = this.param;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    data['isShow'] = this.isShow;
    return data;
  }
}
