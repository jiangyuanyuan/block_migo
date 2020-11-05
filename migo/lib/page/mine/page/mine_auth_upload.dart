import 'package:flutter/material.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';

class MineAuthUploadPage extends StatefulWidget {

  @override
  _MineAuthUploadPageState createState() => _MineAuthUploadPageState();
}

class _MineAuthUploadPageState extends State<MineAuthUploadPage> {

  void _chooseImage(bool isright) {
    Alert.showBottomDialog(context, ["拍摄", "从相册选择"]);
  }

  void _submit() {
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: "上传证件照",
        onPop: () => Navigator.pop(context),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Detail(title: "证件照正面", onTap: () => _chooseImage(true),),
              SizedBox(height: 20,),
              _Detail(title: "证件照反面", onTap: () => _chooseImage(false),),
              Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 46),
                  child: Row(
                    children: [
                      Image.asset("assets/sign_tip_arrow_right.png"),
                      SizedBox(width: 6,),
                      Text("提示", style: AppFont.textStyle(14, color: const Color(0xffDBF0FF), fontWeight: FontWeight.bold, showshadow: true),)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
                  child: Text(
                    '''1. 证件类型:身份证、护照或驾照。
2. 必须看清证件信息和脸，需要手持证件拍摄。
3. 证件文档不可超过500kb。
4. 照片内容真实有效，不得做任何修改。
5. 上传文档格式为pdf、jpg、 jpeg和png。''',
                    style: AppFont.textStyle(12, color: const Color(0xffDBF0FF)),
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: BtnImageBottomView(
                      title: "提交",
                      onTap: _submit,
                    ),
                  ),
                ),
                // SizedBox(height: 70,)
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

  const _Detail({Key key, this.title, this.onTap}) : super(key: key);
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
                Text("上传照片", style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}