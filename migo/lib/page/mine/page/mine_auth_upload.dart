import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_pickers/CropConfig.dart';
import 'package:image_pickers/Media.dart';
import 'package:image_pickers/UIConfig.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/event_bus.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/provider/user.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MineAuthUploadPage extends StatefulWidget {
  final Map params;

  const MineAuthUploadPage({Key key, this.params}) : super(key: key);
  @override
  _MineAuthUploadPageState createState() => _MineAuthUploadPageState();
}

class _MineAuthUploadPageState extends State<MineAuthUploadPage> {

  File imagefileA;
  File imagefileB;
  int uploadtag = 0;
  String imageUrlA = "";
  String imageUrlB = "";

  void _chooseImage(bool isright) {
    Alert.showBottomDialog(context, [I18n.of(context).takephoto, I18n.of(context).album], onTapIndex: (sender) => _choose(sender, isright));
  }

  void _choose(int sender, bool isright) async {
    var status = await Permission.photos.status;
      if (status.isUndetermined) {
        Map<Permission, PermissionStatus> _ = await [
          Permission.photos,
          Permission.camera,
        ].request();
      }
      String filepath;
      switch (sender) {
        case 0:
          filepath = await _photo();
          break;
        case 1:
          filepath = await _album();
          break;
      }

      setState(() {
        if(isright) {
          imagefileA = File(filepath);
        } else {
          imagefileB = File(filepath);
        }
      });
  }

  Future<String> _photo() async {
    List<Media> _listImagePaths = await ImagePickers.pickerPaths(
      galleryMode: GalleryMode.image,
      selectCount: 1,
      showCamera: true,
      uiConfig: UIConfig(uiThemeColor: AppColor.back998),
      cropConfig :CropConfig(enableCrop: true,height: 1,width: 1),
    );
    return _listImagePaths.first.path;
  }

  Future<String> _album() async {
    List<Media> _listImagePaths = await ImagePickers.pickerPaths(
      galleryMode: GalleryMode.image,
      selectCount: 1,
      showCamera: false,
      uiConfig: UIConfig(uiThemeColor: AppColor.back998),
      cropConfig :CropConfig(enableCrop: true,height: 1,width: 1),
    );
    return _listImagePaths.first.path;
  }

  void _submit() {
    print("abc");
  }

  void _upload() {
    if(uploadtag < 2) {
      /// 上传图片
      final tempArr = [imagefileA, imagefileB];
      Networktool.uploadImage(API.file, tempArr[uploadtag], success: (data){
        final url = data['data'];
        if(uploadtag == 0) {
          imageUrlA = url;
        } else if(uploadtag == 1) {
          imageUrlB = url;
        }
        uploadtag += 1;
        _upload();
      }, fail: (msg) => EasyLoading.showError(msg));
    } else {
      EasyLoading.show(status: "Loading...");
      /// 提交身份认证
      Networktool.request(API.identityAuthen, params: {
        	"cardBackUrl": imageUrlB,
          "cardFrontUrl": imageUrlA,
          "cardNo": widget.params["number"],
          "cardType": widget.params["type"],
          "userName": widget.params["name"]
      }, success: (data) {
        EasyLoading.dismiss();
        final temp = Provider.of<UserModel>(context, listen: false).data;
        /// 这里更改审核状态
        temp.status = 1;
        Provider.of<UserModel>(context, listen: false).setModel(temp);
        Navigator.pop(context);
        Navigator.pop(context);
        EventBus.instance.commit(EventKeys.RefreshAuth, null);
      }, fail: (msg) => EasyLoading.showError(msg),);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).uploadid,
        onPop: () => Navigator.pop(context),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Detail(image: imagefileA,title: I18n.of(context).idfront, onTap: () => _chooseImage(true),),
              SizedBox(height: 20,),
              _Detail(image: imagefileB, title: I18n.of(context).idback, onTap: () => _chooseImage(false),),
              Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 46),
                  child: Row(
                    children: [
                      Image.asset("assets/sign_tip_arrow_right.png"),
                      SizedBox(width: 6,),
                      Text(I18n.of(context).notice, style: AppFont.textStyle(14, color: const Color(0xffDBF0FF), fontWeight: FontWeight.bold, showshadow: true),)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
                  child: Text(
                    I18n.of(context).uploadnotice,
                    style: AppFont.textStyle(12, color: const Color(0xffDBF0FF)),
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: BtnImageBottomView(
                      title: I18n.of(context).submit,
                      img: (imagefileA != null && imagefileB != null) ? "btn_active.png" : "btn_inactive.png",
                      onTap: (imagefileA != null && imagefileB != null) ? _submit : null,
                    ),
                  ),
                ),
                SizedBox(height: 70,)
            ],
          ),
        ),
      ),
    );
  }
}


class _Detail extends StatelessWidget {
  final String title;
  final Function() onTap;
  final File image;
  const _Detail({Key key, this.image, this.title, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40.0, bottom: 14),
            child: Text(title, style: AppFont.textStyle(12, color: const Color(0xffDBF0FF), showshadow: true),),
          ),
          Stack(
            children: [
              Container(
                height: 184,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/banner_back.png"),
                    fit: BoxFit.fill
                  )
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: const Color(0xff654248),),
                    Text(I18n.of(context).uploadid, style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Positioned.fill(
                left: 35,
                right: 35,
                top: 5,
                bottom: 5,
                child: image == null ? SizedBox() : Image.file(image, fit: BoxFit.fill, width: double.infinity,)
              )
            ],
          ),
        ],
      ),
    );
  }
}