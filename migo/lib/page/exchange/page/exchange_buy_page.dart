import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';

class ExchangeBuyPage extends StatelessWidget {
  final Map params;

  const ExchangeBuyPage({Key key, this.params}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: "发布购买MIGO",
        onPop: () => Navigator.pop(context),
        actions: [
          IconButton(
            icon: Image.asset("assets/coins_record.png"),
            onPressed: () {
              // Navigator.pushNamed(context, "/coinsrecord", arguments: {"isrecharge" : false});
            },
          )
        ],
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    spreadRadius: 0,
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(0, 2)
                  )
                ]
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("数额：", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                  SizedBox(height: 10,),
                  Stack(
                    children: [
                      NormalTextfield(
                        hintText: "请输入购买数额",
                        padding: const EdgeInsets.only(right: 100),
                        // controller: _controller,
                        // focusNode: _focusNode,
                      ),
                      Positioned(
                        right: 15,
                        top: 8,
                        bottom: 8,
                        child: Center(
                          child: Text("MIGO", style: AppFont.textStyle(14, color: Colors.black.withOpacity(0.5)),)
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10.0),
                    child: Text("单价：", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 51,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/input_back.png"),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                      Positioned.fill(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("同步参考价", style: AppFont.textStyle(14, color: AppColor.back998),),
                            Text("同步参考价", style: AppFont.textStyle(14, color: AppColor.back998),),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Stack(
                    children: [
                      NormalTextfield(
                        hintText: "",
                        padding: const EdgeInsets.only(right: 100),
                        textStyle: AppFont.textStyle(16, color: AppColor.back998, fontWeight: FontWeight.bold),
                        // controller: _controller,
                        // focusNode: _focusNode,
                      ),
                      Positioned(
                        right: 15,
                        top: 8,
                        bottom: 8,
                        child: Center(
                          child: Text("MIGO", style: AppFont.textStyle(14, color: Colors.black.withOpacity(0.5)),)
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10.0),
                    child: Text("涨价比例(-5%~5%)：", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 51,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/input_back.png"),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                      Positioned.fill(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _Item(img: "btn_price_minus_def",),
                            Expanded(
                              child: Center(
                                child: Text("1%", style: AppFont.textStyle(16, color: AppColor.back998, fontWeight: FontWeight.bold),)
                              ),
                            ),
                            _Item(img: "btn_price_plus_def",),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10.0),
                    child: Text("支付方式：", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 51,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/input_back.png"),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                      Positioned.fill(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("微信", style: AppFont.textStyle(14, color: AppColor.back998),),
                            Text("支付宝", style: AppFont.textStyle(14, color: AppColor.back998),),
                            Text("银行卡", style: AppFont.textStyle(14, color: AppColor.back998),),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16,),
                  BtnImageBottomView(
                    title: '确认发布',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _Item extends StatelessWidget {
  final String img;

  const _Item({Key key, this.img}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 44,
      color: const Color(0x1A7BA0B9),
      child: Image.asset("assets/$img.png"),
    );
  }
}