
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/home/view/home_cell.dart';
import 'package:migo/page/home/view/home_head_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isnewer = false;


  void _changehome(bool sender) {
    setState(() {
      isnewer = sender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/背景图.png"),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          children: [
            HomeHeadView(),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: AppColor.divigrey,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8))
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 20, right: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10),
                              child: _DetailBtn(
                                title: "MIGO", 
                                img: isnewer ? "home_btn_inactive.png" : "home_btn.png",
                                onTap: () => _changehome(false),
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 70,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10, top: 10),
                                    child: _DetailBtn(
                                      title: "MIGOS", 
                                      img: isnewer ? "home_btn.png" : "home_btn_inactive.png",
                                      onTap: () => _changehome(true),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      width: 50,
                                      height: 24,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage("assets/new.png"),
                                          fit: BoxFit.fill
                                        )
                                      ),
                                      child: Text(I18n.of(context).newer, style: AppFont.textStyle(12, fontWeight: FontWeight.bold, color: Colors.white),),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        itemCount: 10,
                        itemBuilder: (context, index){
                          return HomeCell();
                      }),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DetailBtn extends StatelessWidget {
  final String img;
  final String title;
  final Function() onTap;

  const _DetailBtn({Key key, this.img, this.title, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/$img"),
            fit: BoxFit.fill
          ),
        ),
        child: Text(title, style: AppFont.textStyle(14, color: Colors.white),),
      ),
    );
  }
}