import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/alert.dart';
import 'package:migo/common/commview/bottom_buttom.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/event_bus.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';
import 'package:migo/page/contract/view/alert_password_view.dart';
import 'package:migo/page/contract/view/choose_coin_view.dart';
import 'package:migo/page/mine/page/alert_auth_view.dart';
import 'package:migo/page/mine/view/mine_auth_success.dart';
import 'package:migo/provider/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MineReelPage extends StatefulWidget {
  @override
  _MineReelPageState createState() => _MineReelPageState();
}

class _MineReelPageState extends State<MineReelPage> {

  List<String> list = [];
  List<_Item> children = [];
  String tick = "--";
  num number = 0;
  /// 是否验证用户
  List<int> listVerfied = [];
  List<int> listCount = [];
  List<String> listAccount = [];
  @override
  void initState() {
    super.initState();

    _addAction();
    _getUser();
  }

  void _addAction() {
    if(children.length == 5) {
      EasyLoading.showToast(I18n.of(context).reelnumbertomax);
      return;
    }
    children.add(_Item(onUpdateAccount: _updateNumber,amount: number,onVerfied: _onChange, onAccount: _addAccount, status: 0, index: listVerfied.length,));
    listVerfied.add(0);
    listCount.add(0);
    listAccount.add("");
    if(mounted) {
      setState(() {
        
      });
    }
    Future.delayed(const Duration(milliseconds: 100)).then((value) => _updateNumber());
  }

  void _addAccount(int index,String val) {
    listAccount[index] = val;
  }

  void _updateNumber() {
    int alllcount = 0;
    for(int i = 0; i<listCount.length; i++) {
      alllcount += listCount[i];
    }
    int minenumber = number - alllcount;
    children.forEach((element) { 
      element.updateAmount(minenumber < 0 ? 0 : minenumber);
    });
  }

  void _sure() {
    final user = Provider.of<UserModel>(context, listen: false).data;
    if(user.txPassword == null || user.txPassword == "") {
      Alert.showMsgDialog(context, title: I18n.of(context).notice, msg: I18n.of(context).nottxpwd, callback: () {
        Navigator.pushNamed(context, "/login", arguments: {'modtype': 2});
      });
      return;
    }
    children.forEach((element) { 
      int statu = listVerfied[children.indexOf(element)];
      element.status = statu == 0 ? 3 : statu;
      element.update();
    });
    int res = listVerfied.reduce((value, element) => value + element);
    bool isinputnumber = true;
    List params = [];
    int alllcount = 0;
    for(int i = 0; i<listCount.length; i++) {
      if(listCount[i] == 0) {
        isinputnumber = false;
      }
      alllcount += listCount[i];
      params.add({
        "sendNumber":listCount[i],
        "userMsg": listAccount[i]
      });
    }

    if(res == listVerfied.length && isinputnumber) {
      if(alllcount > number) {
        EasyLoading.showToast(I18n.of(context).reelnumbertonotenough);
        return;
      } else {
        _requestAdd(params, number - alllcount);
      }
    }
  }

  void _onChange(int sender, int count, int index) {
    listVerfied[index] = sender;
    listCount[index] = count;
  }

   void _getUser() {
    Networktool.request(API.getUserTicket, method: HTTPMETHOD.GET, success: (data) async {
      final tmep = data["data"];
      if(tmep != null) {
        tick = tmep["ticketTitle"];
        number = tmep["ticketNumber"];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if(prefs.getString('languageCode') == "en") {
          tick = tmep["ticketTitleEn"];
        }
        list = [tick];
        _updateNumber();
      }
      if(mounted) setState(() {
        
      });
    });
  }

  void _requestAdd(List params, int currnum) {
    Alert.showBottomViewDialog(context, AlertPasswordView(onSure: (pwd){
        EasyLoading.show(status: "Loading...");
        Networktool.request(API.sendUserTicket, params: {
          "sendUserTicketFormList": params,
          "txPassword": Tool.generateMd5(pwd),
        }, success: (data) {
          EasyLoading.dismiss();
          int createtime = DateTime.now().millisecondsSinceEpoch;
          Alert.showViewDialog(context, AlertMineAuthView(
            createtime: createtime,
            currNum: currnum,
            onTap: () {
              EventBus.instance.commit(EventKeys.RefreshMine, null);
              Navigator.pop(context);
          },));
        }, fail: (e) => EasyLoading.showToast(e));
      },));
  }

  void _clear() {
    children.forEach((element) { 
      element.clear();
    });
    _updateNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: GestureDetector(
        onTap: _clear,
        behavior: HitTestBehavior.translucent,
        child: CommbackView(
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
                              child: Text(tick, style: AppFont.textStyle(12, color: Colors.black), textAlign: TextAlign.center,)
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
                                  img: "home_btn.png",
                                  onTap: _addAction,
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(
                                child: BtnImageBottomView(
                                  title: I18n.of(context).sure,
                                  img: "home_btn_inactive.png",
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
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Item extends StatefulWidget {
  final Function(int status, int count, int index) onVerfied;
  final Function(int index, String account) onAccount;
  final Function() onUpdateAccount;
  int index;
  int status;
  final int amount;
  __ItemState _state = __ItemState();
  void update() {
    _state._update();
  }

  void updateAmount(int sender) {
    _state._updateAmount(sender);
  }

  void clear() {
    _state._clear();
  }
  _Item({Key key, this.amount, this.onUpdateAccount, this.onVerfied, this.onAccount, this.index, this.status}) : super(key: key);

  @override
  __ItemState createState() => _state;
}

class __ItemState extends State<_Item> {

  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  TextEditingController controller1 = TextEditingController();
  FocusNode focusNode1 = FocusNode();
  int amount = 0;

  @override
  void initState() {
    super.initState();
    amount = widget.amount;
    focusNode1.addListener(() {
      if(widget.onUpdateAccount != null) {
        widget.onUpdateAccount();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    controller1.dispose();
    super.dispose();
  }

  void _clear() {
    focusNode.unfocus();
    focusNode1.unfocus();
  }

  void _check() {
    if(controller.text.isEmpty) {
      EasyLoading.showToast(I18n.of(context).pleaseinputuserid);
      return;
    }
    EasyLoading.show(status: "Loading...");
    Networktool.request(API.checkUser, params: {
      "userMsg": controller.text
    }, success: (data) {
      EasyLoading.dismiss();
      setState(() {
        widget.status = 1;
      });
      if(widget.onVerfied != null) {
        widget.onVerfied(1, num.parse(controller1.text, (e) => 0), widget.index);
      }
    }, fail: (msg) {
      EasyLoading.dismiss();
      setState(() {
        widget.status = 2;
      });
      if(widget.onVerfied != null) {
        widget.onVerfied(2, num.parse(controller1.text, (e) => 0), widget.index);
      }
    });
  }

  String _getString(BuildContext context) {
    if(widget.status == 1) {
      return I18n.of(context).reelsuccess;
    } else if(widget.status == 2) {
      return I18n.of(context).reelerror;
    } else {
      return I18n.of(context).pleasereelverified;
    }
  }

  void _update() {
    setState(() {
    });
  }

  void _updateAmount(int sender) {
    amount = sender;
    if(mounted) setState(() {
      
    });
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
                onChanged: (val) {
                  setState(() {
                    widget.status = 0;
                  });
                  if(widget.onVerfied != null) {
                    widget.onVerfied(0, num.parse(controller1.text, (e) => 0), widget.index);
                  }
                  if(widget.onAccount != null) {
                    widget.onAccount(widget.index, val);
                  }
                },
                padding: const EdgeInsets.only(right: 30),
                hintText: I18n.of(context).pleaseinputuserid,
              ),
              Positioned(
                right: 0,
                child: InkWell(
                  onTap: _check,
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
                ),
              )
            ],
          ),
          Visibility(
            visible: widget.status != 0,
            child: Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text(_getString(context), style: AppFont.textStyle(12, color: widget.status == 1 ? AppColor.green : AppColor.red),),
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
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  setState(() {
                    
                  });
                  if(widget.onVerfied != null) {
                    widget.onVerfied(widget.status, num.parse(controller1.text, (e) => 0), widget.index);
                  }
                },
                padding: const EdgeInsets.only(right: 30),
                hintText: I18n.of(context).pleaseinputreelnumber,
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
                  child: Text(I18n.of(context).reelmaxcount("$amount"), style: AppFont.textStyle(12, color: AppColor.back998)),
                ),
              )
            ],
          ),
          Visibility(
            visible: num.parse(controller1.text, (e) => null) == 0,
            child: Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text(I18n.of(context).pleaseinputreelnumber, style: AppFont.textStyle(12, color: AppColor.red),),
            ),
          ),
        ]
      )
    );
  }
}