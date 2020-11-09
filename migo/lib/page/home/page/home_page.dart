
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:migo/common/util/event_bus.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/home/view/alert_shovelview.dart';
import 'package:migo/page/home/view/home_action.dart';
import 'package:migo/page/home/view/home_cell.dart';
import 'package:migo/page/home/view/home_head_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isnewer = false;
  RefreshController _refreshController = RefreshController();
  void _changehome(bool sender) {
    setState(() {
      isnewer = sender;
    });
  }

  void _cellAction() {
    // Alert.showViewDialog(context, AlertShovelView(onSure: () {
    //   Navigator.pushNamed(context, "/package");
    // },));
    Navigator.pushNamed(context, "/homedetail");
  }

  void _floatingAction() {
    Alert.showViewDialog(context, AlertShovelView(onSure: () {
      Navigator.pushNamed(context, "/package");
    },));
  }

  void _endRefresh() {
    Future.delayed(const Duration(milliseconds: 2000)).then((value) => _refreshController.refreshCompleted());
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          _floatingAction();
        },
        child: Image.asset("assets/icon.png")
      ),
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
            Visibility(
              visible: isnewer,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 34),
                padding: const EdgeInsets.only(top: 23),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomeActionView(
                      title: I18n.of(context).mypackage, 
                      img: "home_package.png",
                      onTap: () => Navigator.pushNamed(context, "/package"),
                    ),
                    HomeActionView(title: I18n.of(context).myearn, img: "home_earn.png"),
                    HomeActionView(
                      title: I18n.of(context).myteam, 
                      img: "home_team.png",
                      onTap: () => EventBus.instance.commit(EventKeys.JumtoTeam, null),
                    ),
                    HomeActionView(
                      title: I18n.of(context).invite, 
                      img: "home_mine.png",
                      onTap: () => Navigator.pushNamed(context, "/invite"),
                    ),
                  ],
                ),
              ),
            ),
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
                      child: RefreshWidget(
                        onRefresh: _endRefresh,
                        onLoading: _endRefresh,
                        controller: _refreshController,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                          itemCount: 2,
                          itemBuilder: (context, index){
                            return InkWell(
                              onTap: _cellAction,
                              child: HomeCell(index: index,)
                            );
                        }),
                      ),
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