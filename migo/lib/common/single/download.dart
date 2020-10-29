import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/network/network.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedDownloadInstance {
  // 单例公开访问点
  factory SharedDownloadInstance() =>_sharedInstance();
  
  // 静态私有成员，没有初始化
  static SharedDownloadInstance _instance;
  static SharedDownloadInstance get instance => _sharedInstance();
  // 私有构造函数
  SharedDownloadInstance._() {
    // 具体初始化代码
  }
  // 
  Map<String,String> localImgPath = {};
  // download
  List<String> _imgUrls = [];

  // 静态、同步、私有访问点
  static SharedDownloadInstance _sharedInstance() {
    if (_instance == null) {
      _instance = SharedDownloadInstance._();
    }
    // 请求权限
    _instance._storage();
    return _instance;
  }

  void _storage() async {
    final status = await Permission.storage.status;
    if(status.isUndetermined) {
      final _ = await Permission.storage.request();
    }
  }

  void cacheImage(List<String> sender) {
    _imgUrls = sender;
    _download(_imgUrls.first);
  }

  void _download(String url) {
    getApplicationDocumentsDirectory().then((value) async {
      String imgname = url.split("/").last;
      String localpath = value.path + "/AnyBanners" + imgname;
      var file = File(localpath);
      bool exits = await file.exists();
      if(exits) {
        _imgUrls.remove(url);
        if(_imgUrls.length > 0) {
          _download(_imgUrls.first);
        } else {
          Uint8List data = await file.readAsBytes();
          localImgPath[imgname] = base64.encode(data);
          _saveBanners();
        }
        return;
      }
      Networktool.downloadImage(url, success: (data) async {
        file.writeAsBytes(data).then((value) async {
          _imgUrls.remove(url);
          print("保存banner成功===> $localpath");
          Uint8List data = await file.readAsBytes();
          localImgPath[imgname] = base64.encode(data);
          if(_imgUrls.length > 0) {
            _download(_imgUrls.first);
          } else {
            _saveBanners();
          }
        });
      });
    });
  }

  void _saveBanners() async {
    SharedPreferences share = await SharedPreferences.getInstance();
    share.setString(AppConst.APP_BANNERS_KEY, json.encode(localImgPath));
  }
}