import 'package:flutter/material.dart';
import 'package:migo/common/commview/bottom_buttom.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';
import 'package:migo/page/contract/view/choose_coin_view.dart';

class MineReelPage extends StatefulWidget {
  @override
  _MineReelPageState createState() => _MineReelPageState();
}

class _MineReelPageState extends State<MineReelPage> {

  String name = "";
  List<String> list = ["abc"];
  List<Widget> children = [];

  @override
  void initState() {
    super.initState();

    children.add(_Item());
  }

  void _addAction() {
    children.add(_Item());
    if(mounted) {
      setState(() {
        
      });
    }
  }

  void _sure() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: CommbackView(
        titles: I18n.of(context).reeltitle,
        onPop: () => Navigator.pop(context),
        actions: [
          IconButton(
            icon: Image.asset("assets/coins_record.png"),
            onPressed: () {
              Navigator.pushNamed(context, "/reelcord",);
            },
          )
        ],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ChooseCoinView(
                  iscoupon: true,
                  onSelected: (selectindex, sender) {
                  },
                  child: Container(
                    height: 42,
                    child: Stack(
                      children: [
                        Image.asset("assets/input_back.png", fit: BoxFit.fill, width: double.infinity,),
                        Positioned(
                          left: 10,
                          height: 42,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(name, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.2)), textAlign: TextAlign.center,)
                          ),
                        ),
                        Positioned(
                          right: 10,
                          height: 42,
                          child: Image.asset("assets/coin_select.png"),
                        )
                      ],
                    ),
                  ),
                  titles: list.map((e) => e).toList(),
                ),
              ),

              Container(
                padding: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(0, 2)
                    )
                  ]
                ),
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: List.generate(children.length + 1, (index) {
                    if(index == children.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: BtnImageBottomView(
                                title: I18n.of(context).addone,
                                onTap: _addAction,
                              ),
                            ),
                            SizedBox(width: 20,),
                            Expanded(
                              child: BtnImageBottomView(
                                title: I18n.of(context).sure,
                                img: "btn_inactive.png",
                                onTap: _sure,
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return children[index];
                    }
                  }).toList(),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(I18n.of(context).reealnotice, style: AppFont.textStyle(14, color: Colors.white),),
                    SizedBox(height: 20,),
                    Text(I18n.of(context).reealnotice1, style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.5)),),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(I18n.of(context).reealnotice2, style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.5)),),
                    ),
                    Text(I18n.of(context).reealnotice3, style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.5)),),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(I18n.of(context).reealnotice4, style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.5)),),
                    ),
                    Text(I18n.of(context).reealnotice5, style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.5)),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatefulWidget {
  const _Item({Key key}) : super(key: key);

  @override
  __ItemState createState() => __ItemState();
}

class __ItemState extends State<_Item> {

  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  TextEditingController controller1 = TextEditingController();
  FocusNode focusNode1 = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(I18n.of(context).coupontouser, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
          SizedBox(height: 12,),
          Stack(
            children: [
              NormalTextfield(
                controller: controller,
                focusNode: focusNode,
                padding: const EdgeInsets.only(right: 30),
                hintText: I18n.of(context).pleaseinputorcopy,
              ),
              Positioned(
                right: 0,
                child: Container(
                  width: 86,
                  height: 30,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xffE5F0FA),
                    borderRadius: BorderRadius.circular(4)
                  ),
                  alignment: Alignment.center,
                  child: Text(I18n.of(context).reelverified, style: AppFont.textStyle(12, color: AppColor.back998)),
                ),
              )
            ],
          ),
          Visibility(
            visible: true,
            child: Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text(I18n.of(context).reelerror, style: AppFont.textStyle(12, color: AppColor.red),),
            ),
          ),
          SizedBox(height: 20,),
          Text(I18n.of(context).coupontousercount, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
          SizedBox(height: 12,),
          Stack(
            children: [
              NormalTextfield(
                controller: controller1,
                focusNode: focusNode1,
                padding: const EdgeInsets.only(right: 30),
                hintText: I18n.of(context).pleaseinputorcopy,
              ),
              Positioned(
                right: 0,
                child: Container(
                  width: 86,
                  height: 30,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xffE5F0FA),
                    borderRadius: BorderRadius.circular(4)
                  ),
                  alignment: Alignment.center,
                  child: Text(I18n.of(context).reelmaxcount("505"), style: AppFont.textStyle(12, color: AppColor.back998)),
                ),
              )
            ],
          ),
        ]
      )
    );
  }
}