import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/custom_menu_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';
class MineAuthPage extends StatefulWidget {
  @override
  _MineAuthPageState createState() => _MineAuthPageState();
}

class _MineAuthPageState extends State<MineAuthPage> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  TextEditingController _numcontroller = TextEditingController();
  FocusNode _numfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    _numcontroller.dispose();
    super.dispose();
  }

  List<String> _createtitle(BuildContext context) {
    return [
      I18n.of(context).idcard,
      I18n.of(context).iddrive,
      I18n.of(context).idprotect,
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).verified,
        onPop: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 18,),
              Stack(
                children: [
                  NormalTextfield(
                    hintText: I18n.of(context).pleaseinputname,
                    align: TextAlign.right,
                    controller: _controller,
                    focusNode: _focusNode,
                  ),
                  Positioned(
                    left: 5,
                    top: 8,
                    bottom: 8,
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.only(left: 12),
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                      child: Text(I18n.of(context).name, style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),),

                    ),
                  )
                ],
              ),
              SizedBox(height: 14,),
              Stack(
                children: [
                  Container(
                    height: 51,
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/input_back.png"),
                        fit: BoxFit.fill
                      )
                    ),
                  ),
                  Positioned(
                    left: 5,
                    top: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.only(left: 12),
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                      child: Text(I18n.of(context).idtype, style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Positioned(
                    right: 15,
                    top: 8,
                    left: 100,
                    bottom: 8,
                    child: Container(
                      height: 28,
                      color: Colors.white,
                      alignment: Alignment.centerRight,
                      child: CustiomMenuView(
                        backgroundColor: Colors.white,
                        titles: _createtitle(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(I18n.of(context).idcard, style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),),
                            SizedBox(width: 6,),
                            Image.asset("assets/sign_choos_arrow_down.png")
                          ],
                        ),
                      ),
                    )
                  ),
                ],
              ),
              SizedBox(height: 14,),
              Stack(
                children: [
                  NormalTextfield(
                    hintText: I18n.of(context).pleaseinputid,
                    align: TextAlign.right,
                    controller: _numcontroller,
                    focusNode: _numfocusNode,
                  ),
                  Positioned(
                    left: 5,
                    top: 8,
                    bottom: 8,
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.only(left: 12),
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                      child: Text(I18n.of(context).idnumber, style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),),
                    ),
                  )
                ],
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Row(
                  children: [
                    Image.asset("assets/sign_tip_arrow_right.png"),
                    SizedBox(width: 6,),
                    Text(I18n.of(context).notice, style: AppFont.textStyle(14, color: const Color(0xffDBF0FF), fontWeight: FontWeight.bold, showshadow: true),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Text(
                  I18n.of(context).authnotice,
                  style: AppFont.textStyle(12, color: const Color(0xffDBF0FF)),
                ),
              ),
              Spacer(),
              SafeArea(
                child: BtnImageBottomView(
                  title: "下一步",
                  onTap: () => Navigator.pushNamed(context, "/authupload"),
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