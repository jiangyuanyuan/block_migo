class ReelReponse {
  int code;
  String msg;
  List<ReelModel> data;

  ReelReponse({this.code, this.msg, this.data});

  ReelReponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<ReelModel>();
      json['data'].forEach((v) {
        data.add(new ReelModel.fromJson(v));
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

class ReelModel {
  String id;
  String fromUser;
  String toUser;
  String ticketTitle;
  String ticketTitleEn;
  int ticketType;
  int createTime;
  int ticketNumber;
  String fromUserId;
  String toUserId;

  ReelModel(
      {this.id,
      this.fromUser,
      this.toUser,
      this.ticketTitle,
      this.ticketTitleEn,
      this.ticketType,
      this.createTime,
      this.ticketNumber,
      this.fromUserId,
      this.toUserId});

  ReelModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromUser = json['fromUser'];
    toUser = json['toUser'];
    ticketTitle = json['ticketTitle'];
    ticketTitleEn = json['ticketTitleEn'];
    ticketType = json['ticketType'];
    createTime = json['createTime'];
    ticketNumber = json['ticketNumber'];
    fromUserId = json['fromUserId'];
    toUserId = json['toUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fromUser'] = this.fromUser;
    data['toUser'] = this.toUser;
    data['ticketTitle'] = this.ticketTitle;
    data['ticketTitleEn'] = this.ticketTitleEn;
    data['ticketType'] = this.ticketType;
    data['createTime'] = this.createTime;
    data['ticketNumber'] = this.ticketNumber;
    data['fromUserId'] = this.fromUserId;
    data['toUserId'] = this.toUserId;
    return data;
  }
}
