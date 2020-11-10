import 'package:flutter/material.dart';
import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/model/mine_invite_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InviteRecordPage extends StatefulWidget {
  @override
  _InviteRecordPageState createState() => _InviteRecordPageState();
}

class _InviteRecordPageState extends State<InviteRecordPage> {
  
  RefreshController _refreshController = RefreshController();
  List<MineInviteModel> list = [];
  @override
  void initState() {
    super.initState();

    _request();
  }

  void _request(){
    Networktool.request(API.myInviteDetail, success: (data){
      final temp = MineInviteResponse.fromJson(data);
      list = temp.data;
      if(mounted) setState(() {
        
      });
    }, finaly: _endrefresh);
  }

  void _refresh() {
    _request();
  }

  void _endrefresh() {
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).inviterecord,
        onPop: () => Navigator.pop(context),
        child: RefreshWidget(
          controller: _refreshController,
          onRefresh: _refresh,
          child: ListView.builder(
            itemCount: list.length,
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
            itemBuilder: (context, index) {
              return _Cell(model: list[index],);
            }
          ),
        ),
      )
    );
  }
}

class _Cell extends StatelessWidget {
  final MineInviteModel model;

  const _Cell({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg_list_invite_def.png"),
          fit: BoxFit.fill
        )
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(model.userNumber, style: AppFont.textStyle(20, color: Colors.white, showshadow: true, fontWeight: FontWeight.bold),),
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Tool.timeFormat("yyyy-MM-dd HH:mm", model.createTime), style: AppFont.textStyle(14, color: const Color(0xffDBF0FF), showshadow: true),),
              Text(model.authStatus == 0 ? I18n.of(context).notinviteverified : I18n.of(context).inviteverified, style: AppFont.textStyle(14, color: const Color(0xff654248), fontWeight: FontWeight.bold),)
            ],
          )
        ],
      ),
    );
  }
}

