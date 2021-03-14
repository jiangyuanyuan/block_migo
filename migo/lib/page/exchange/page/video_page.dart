import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/exchange/model/Video_model.dart';
import 'package:migo/page/exchange/model/exchange_model.dart';
import 'package:migo/page/exchange/model/sell_detail_model.dart';
import 'package:migo/page/mine/model/mine_pay_model.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoApp extends StatefulWidget {
  final Map params;
  const VideoApp({Key key, this.params}) : super(key: key);
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;
  ExhangeModel model;
  List videoList ;

  @override
  void initState() {
    super.initState();
    model = widget.params["model"];
    videoList = widget.params["video"];
    // String url = 'https://migo-file.s3.ap-east-1.amazonaws.com/video/lv_0_20210301110918.mp4';
    // // videoList.add("https://migo-file.s3.ap-east-1.amazonaws.com/video/lv_0_20210301110918.mp4");
    // videoList.clear();
    // videoList.add("https://v-cdn.zjol.com.cn/276985.mp4");
    // videoList.add("https://v-cdn.zjol.com.cn/276982.mp4");
    // videoList.add("https://v-cdn.zjol.com.cn/276985.mp4");
    // _play( videoList[0]);
    if (videoList.isNotEmpty){
      _play( videoList[0]);
    }

  }

  void _play(String url) {
    _controller = VideoPlayerController.network(
        url)
      ..initialize().then((_) {
        _controller.play();
        if (_timer?.isActive == true){
          _timer.cancel();
        }
        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
          setState(() {});
        });
        setState(() {});
      })
      ..addListener(() {
        if(_controller.value.position == _controller.value.duration ){
          videoList.removeAt(0);
          if (videoList.isEmpty){
            Networktool.request(API.userPays, method: HTTPMETHOD.GET, success: (data) {
              final temp = MinePaymethodResponse.fromJson(data);
              if(temp.data.length == 0) {
                EasyLoading.dismiss();
                Alert.showMsgDialog(context, title: I18n.of(context).notice, msg: I18n.of(context).addpaymethod, callback: () {
                  // Navigator.pushNamed(context, "/login", arguments: {'modtype': 2});
                  Navigator.popAndPushNamed(context, "/paysetting", arguments: {"payways":[1,2,3]});
                });
              } else {
                _jumppage(context);
              }
            }, fail: (msg) =>{
              EasyLoading.showToast(msg),
              Navigator.pop(context),
            } );
          }else {
            _play(videoList[0]);
          }



    
        }
    
      });
  }

  Timer _timer;

  void _jumppage(BuildContext context) {
    EasyLoading.show(status: 'Loading...');
    Networktool.request(API.buildOrder, params: {
      "adId":model.id,
    }, success: (data) async {
      EasyLoading.dismiss();
      final temp = SellDetailResponse.fromJson(data);
      temp.data.sellMobile = "--";
      final res = await Navigator.popAndPushNamed(context, "/sell", arguments: {"model": temp.data, "issell": true});
    }, fail: (msg) => {
      // Navigator.popAndPushNamed(context,"/root"),
      EasyLoading.showToast(msg),
      Navigator.pop(context),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 38.0,
              right: 28.0,
              child: Text(_controller.value.initialized
                ? _controller.value.position.toString().substring(2,7)+" / "+_controller.value.duration.toString().substring(2,7):"0/0", style: AppFont.textStyle(16, color: Colors.black),)
          ),
          Center(
            child: _controller.value.initialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : Container(),
          ),

        ],


      )
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
    _controller.dispose();
  }
}
