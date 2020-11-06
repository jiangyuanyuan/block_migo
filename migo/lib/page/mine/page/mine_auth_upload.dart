import 'package:flutter/material.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class MineAuthUploadPage extends StatefulWidget {

  @override
  _MineAuthUploadPageState createState() => _MineAuthUploadPageState();
}

class _MineAuthUploadPageState extends State<MineAuthUploadPage> {

  void _chooseImage(bool isright) {
    Alert.showBottomDialog(context, [I18n.of(context).takephoto, I18n.of(context).album]);
  }

  void _submit() {
    
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
              _Detail(title: I18n.of(context).idfront, onTap: () => _chooseImage(true),),
              SizedBox(height: 20,),
              _Detail(title: I18n.of(context).idback, onTap: () => _chooseImage(false),),
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
                Text(I18n.of(context).uploadid, style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}