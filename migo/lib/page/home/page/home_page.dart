
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:migo/common/util/event_bus.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/home/model/banner_model.dart';
import 'package:migo/page/home/model/home_box_model.dart';
import 'package:migo/page/home/model/home_list_model.dart';
import 'package:migo/page/home/page/home_box.dart';
import 'package:migo/page/home/page/web_page.dart';
import 'package:migo/page/home/view/alert_shovelview.dart';
import 'package:migo/page/home/view/home_action.dart';
import 'package:migo/page/home/view/home_cell.dart';
import 'package:migo/page/home/view/home_head_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

  bool isnewer = false;
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  List<HomeBannerModel> banners = [];
  List<HomeModel> list = [];
  bool showbox = false;
  List<HomeShovelModel> shoveList = [];
  num candy = 0;
  final _shakeAnimationController = ShakeAnimationController();
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _onRefresh();
    EventBus.instance.addListener(EventKeys.RereshHome, (arg) {
      _onRefresh();
    });
  }

  void _requestBanner() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final isen = prefs.getString('languageCode') == "en";
    Networktool.request(API.banner+"1/${isen ? 2 : 1}", method: HTTPMETHOD.GET, success: (data){
      final temp = HomeBannerResponse.fromJson(data);
      banners = temp.data;
      if(prefs.getString('languageCode') == "en") {
        banners.forEach((element) { 
          if(element.enBannerUrl != null) element.bannerUrl = element.enBannerUrl;
          if(element.enParam != null) element.param = element.enParam;
        });
      }
      if(mounted) setState(() {
        
      });
    });
  }

  void _requestList() {
    Networktool.request(API.getMineBaseList + "${isnewer ? "1":"2"}", method: HTTPMETHOD.GET, success: (data) async {
      final temp = HomeListReponse.fromJson(data);
      list = temp.data;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.getString('languageCode') == "en") {
        list.forEach((element) { 
          if(element.enMineTitle != null) element.mineTitle = element.enMineTitle;
        });
      }
      if(mounted) setState(() {
        
      });
    },finaly: _endRefresh);
  }

  /// 查询盲盒
  void _requestBox() {
    Networktool.request(API.getMyNotOpenBox, success: (data) {
      final temp = HomeBoxReponse.fromJson(data);
      if(temp.data.length > 0) {
        setState(() {
          showbox = true;
        });
        ///判断抖动动画是否正在执行
        if (_shakeAnimationController.animationRunging) {
          ///停止抖动动画
          _shakeAnimationController.stop();
        } else {
          ///开启抖动动画
          ///参数shakeCount 用来配置抖动次数
          ///通过 controller start 方法默认为 1
          _shakeAnimationController.start(shakeCount: 10000);
        }
      } else {
        _shakeAnimationController.stop();
        setState(() {
          showbox = false;
        });
      }
    });
  }

  void _changehome(bool sender) {
    setState(() {
      isnewer = sender;
    });
    _refreshController.requestRefresh();
  }

  void _cellAction(HomeModel model) {
    Navigator.pushNamed(context, "/homedetail", arguments: {"model": model});
    // Navigator.push(context, CupertinoPageRoute(builder: (context) => WebPage(),));
  }

  /// 打开盲盒
  void _floatingAction() {
    EasyLoading.show(status: "Loading...");
    
    Networktool.request(API.openBox, success: (data){
      EasyLoading.dismiss();
      final temp = HomeBoxRespose.fromJson(data).data;
      setState(() {
        shoveList = temp.shovelList;
      });
      setState(() {
        showbox = false;
      });
      Alert.showViewDialog(context, AlertShovelView(onSure: () {
        Navigator.pushNamed(context, "/package");
        _shakeAnimationController.stop();
      }, list: temp.shovelList, candy: temp.totalCandy,));
    }, fail: (msg) => EasyLoading.showToast(msg),);
    
  }

  void _onRefresh() {
    _requestList();
    _requestBanner();
    _requestBox();
  }

  void _onLoading() {

  }

  void _endRefresh() {
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Widget buildShakeAnimationWidget() {
    return Visibility(
      visible: showbox,
      child: ShakeAnimationWidget(
        //抖动控制器
        shakeAnimationController: _shakeAnimationController,
        //微旋转的抖动
        shakeAnimationType: ShakeAnimationType.RoateShake,
        //设置不开启抖动
        isForward: true,
        //默认为 0 无限执行
        shakeCount: 0,
        //抖动的幅度 取值范围为[0,1]
        shakeRange: 0.2,
        child: Image.asset("assets/icon.png", width: 70, height: 70, fit: BoxFit.cover,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          if(!_shakeAnimationController.animationRunging) {
            _shakeAnimationController.start(shakeCount: 1);
          }
          Future.delayed(const Duration(milliseconds: 500)).then((value) => _floatingAction());
        },
        child: buildShakeAnimationWidget(),
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
            HomeHeadView(banners: banners,),
            Container(
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
                  HomeActionView(
                    onTap: () => Navigator.pushNamed(context, "/mineearn"),
                    title: I18n.of(context).myearn, img: "home_earn.png"),
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
                        onRefresh: _onRefresh,
                        onLoading: _onLoading,
                        controller: _refreshController,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                          itemCount: list.length,
                          itemBuilder: (context, index){
                            return InkWell(
                              onTap: () => _cellAction(list[index]),
                              child: HomeCell(index: index, model: list[index],)
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