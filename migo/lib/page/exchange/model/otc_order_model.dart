import 'package:migo/page/exchange/model/sell_detail_model.dart';

class OtcOrderResponse {
  int code;
  String msg;
  List<SellDetailModel> data;

  OtcOrderResponse({this.code, this.msg, this.data});

  OtcOrderResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<SellDetailModel>();
      json['data'].forEach((v) {
        data.add(new SellDetailModel.fromJson(v));
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