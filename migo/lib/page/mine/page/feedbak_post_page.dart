import 'dart:io';
import 'dart:math';

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
import 'package:migo/generated/i18n.dart';
import 'package:permission_handler/permission_handler.dart';

class FeedbackPosePage extends StatefulWidget {
  @override
  _FeedbackPosePageState createState() => _FeedbackPosePageState();
}

class _FeedbackPosePageState extends State<FeedbackPosePage> {

  final focusnode = FocusNode();
  final _controller = TextEditingController();
  String _string = "";
  File file;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      // _uploadImage(context,File(_listImagePaths.first.path));
      // setState(() {
      //   _string = "(1)";
      // });
      setState(() {
        file = File(_listImagePaths.first.path);  
      });
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
      // _uploadImage(context,File(_listImagePaths.first.path));
      // setState(() {
      //   _string = "(1)";
      // });
      setState(() {
        file = File(_listImagePaths.first.path);
      });
    }
  }

  void _uploadImage(BuildContext context,File image) {
    EasyLoading.show(status: "Loading...");
    Networktool.uploadImage(API.file, image, success: (data){
      if(data != null) {
        String url =  data["data"] ?? "";
        _reqeust(_controller.text, url);
      }
    }, fail: (msg) => EasyLoading.showError(msg)
    ,finaly: () => EasyLoading.dismiss());
  }

  void _reqeust(String content, String url) {
    Networktool.request(API.uUserFeedback, params: {
      	"content": content,
        "url": url
    },success: (data) {
      EasyLoading.showToast(I18n.of(context).success);
      Navigator.pop(context);
    }, fail: (e) => EasyLoading.showError(e));
  }

  void _onSubmit() {
    if(_controller.text.isEmpty) {
      EasyLoading.showError(I18n.of(context).pleaseinput);
      return;
    }
    if(file != null) {
      _uploadImage(context, file);
    } else {
      _reqeust(_controller.text, "");
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => focusnode.unfocus(),
        child: CommbackView(
          titles: I18n.of(context).feed,
          onPop: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SizedBox(height: 40,),
                Stack(
                  children: [
                    Image.asset("assets/banner_back.png", height: 222, width: MediaQuery.of(context).size.width, fit: BoxFit.fill,),
                    TextField(
                      maxLines: 10,
                      controller: _controller,
                      focusNode: focusnode,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: I18n.of(context).pleaseinput,
                        contentPadding: EdgeInsets.all(10),
                        hintStyle: AppFont.textStyle(12, color: Colors.black.withOpacity(0.2))
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Text(I18n.of(context).feennotice, style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.5)),),
                SizedBox(height: 10,),
                file != null ? Image.file(file, width:double.infinity, height: 150, fit: BoxFit.fill,) : SizedBox(),
                Spacer(),
                SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: BtnImageBottomView(
                          img: "home_btn.png",
                          title: I18n.of(context).feedchoose + _string,
                          onTap: () {
                            _alert(context);
                          },
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        flex: 1,
                        child: BtnImageBottomView(
                          img: "home_btn_inactive.png",
                          title: I18n.of(context).submit,
                          onTap: _onSubmit,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 70,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}