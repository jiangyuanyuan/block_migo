import 'dart:io';

import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/model/user_model.dart';
import 'package:migo/page/mine/view/setting_cell.dart';
import 'package:migo/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_pickers/CropConfig.dart';
import 'package:image_pickers/Media.dart';
import 'package:image_pickers/UIConfig.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MineModPage extends StatelessWidget {

  void _alert(BuildContext context) {
    Alert.showBottomDialog(context, [I18n.of(context).takephoto, I18n.of(context).album,], onTapIndex: (index) async{
      var status = await Permission.photos.status;
      if (status.isUndetermined) {
        Map<Permission, PermissionStatus> _ = await [
          Permission.photos,
          Permission.camera,
        ].request();
      }
      switch (index) {
        case 0:
          _photo(context);
          break;
        case 1:
          _album(context);
          break;
      }
    });
  }

  _photo(BuildContext context) async {
    List<Media> _listImagePaths = await ImagePickers.pickerPaths(
      galleryMode: GalleryMode.image,
      selectCount: 1,
      showCamera: true,
      cropConfig :CropConfig(enableCrop: true,height: 1,width: 1),
    );
    if(_listImagePaths != null) {
      _uploadImage(context,File(_listImagePaths.first.path));
    }
  }

  _album(BuildContext context) async {
    List<Media> _listImagePaths = await ImagePickers.pickerPaths(
      galleryMode: GalleryMode.image,
      selectCount: 1,
      showCamera: false,
      uiConfig: UIConfig(uiThemeColor: AppColor.blue),
      cropConfig :CropConfig(enableCrop: true,height: 1,width: 1),
    );

    if(_listImagePaths != null) {
      _uploadImage(context,File(_listImagePaths.first.path));
    }
  }

  void _uploadImage(BuildContext context,File image) {
    EasyLoading.show(status: "Loading...");
    Networktool.uploadImage(API.file, image, success: (data){
      if(data != null) {
        String url =  data["data"] ?? "";
        _requestMod(context, url);
      }
    }, fail: (msg) => EasyLoading.showError(msg)
    ,finaly: () => EasyLoading.dismiss());
  }

  void _requestMod(BuildContext context,String url) {
    Networktool.request(API.mod, params: {"userImage": url,"userName":""}, success: (data){
      EasyLoading.showSuccess("????????????");
      // ????????????????????????
      final temp = Provider.of<UserModel>(context, listen: false);
      final curr = temp.data;
      curr.logo = url;
      temp.setModel(curr);
    }, fail: (e) => EasyLoading.showError(e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).setting,
        onPop: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Consumer<UserModel>(builder: (context, user,child){
          return Column(
            children: <Widget>[
              InkWell(
                onTap: () => _alert(context),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/bg_list_sett_def.png"),
                      fit: BoxFit.fill
                    )
                  ),
                  child: Row(
                    children: <Widget>[
                      Text("??????", style: AppFont.textStyle(15, color: AppColor.font333),),
                      Spacer(),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: PhysicalModel(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          clipBehavior: Clip.antiAlias,
                          child: user.data?.logo == null ? Image.asset("assets/default.png") : Image.network(user.data?.logo, fit: BoxFit.cover,),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Image.asset("assets/icon_you.png", color: const Color(0xff654248),)
                    ],
                  ),
                ),
              ),
              Divider(indent: 15, endIndent: 15,),
              SettingCell(
                title: "??????", 
                detail: user.data?.nickName ?? "",
                detailColor: AppColor.font333,
                onTap: () => Navigator.pushNamed(context, "/modname", arguments: {"modname": true, 'val':""}),
              ),
            ],
          );
      }),
        ),
      )
    );
  }
}