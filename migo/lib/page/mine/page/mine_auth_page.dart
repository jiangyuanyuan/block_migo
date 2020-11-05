import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: "实名认证",
        onPop: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 18,),
              Stack(
                children: [
                  NormalTextfield(
                    hintText: "请填写身份证上的姓名",
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
                      child: Text("姓名", style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),),

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
                      child: Text("证件类型", style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.only(right: 12),
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text("证件类型", style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),),
                          SizedBox(width: 6,),
                          Image.asset("assets/sign_choos_arrow_down.png")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14,),
              Stack(
                children: [
                  NormalTextfield(
                    hintText: "请填写证件号",
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
                      child: Text("证件号", style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),),
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
                    Text("提示", style: AppFont.textStyle(14, color: const Color(0xffDBF0FF), fontWeight: FontWeight.bold, showshadow: true),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Text(
                  "姓名、证件号首次提交后无法更改，为避免填写虚假信息导致充值、提现无法审核通过，请您慎重填写真实信息。",
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