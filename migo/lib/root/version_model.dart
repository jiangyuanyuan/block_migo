class VersionResponse {
  int code;
  String msg;
  VersionModel data;

  VersionResponse({this.code, this.msg, this.data});

  VersionResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new VersionModel.fromJson(json['data']) : null;
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

class VersionModel {
  String id;
  int type;
  String content;
  int isForce;
  int versionNumber;
  String url;
  int createTime;
  int status;
  String version;

  VersionModel(
      {this.id,
      this.type,
      this.content,
      this.isForce,
      this.versionNumber,
      this.url,
      this.createTime,
      this.status,
      this.version});

  VersionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    content = json['content'] ?? "";
    isForce = json['isForce'];
    versionNumber = json['versionNumber'];
    url = json['downloadUrl'];
    createTime = json['createTime'];
    status = json['status'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['content'] = this.content;
    data['isForce'] = this.isForce;
    data['versionNumber'] = this.versionNumber;
    data['url'] = this.url;
    data['createTime'] = this.createTime;
    data['status'] = this.status;
    return data;
  }
}
