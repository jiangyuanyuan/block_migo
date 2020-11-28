import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/commview/refresh.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/model/reel_model.dart';
import 'package:migo/provider/user.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MineReelRecordPage extends StatefulWidget {
  @override
  _MineReelRecordPageState createState() => _MineReelRecordPageState();
}

class _MineReelRecordPageState extends State<MineReelRecordPage> {
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  int page = 1;
  List<ReelModel> list = [];

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _loading() {
    page += 1;
    _request();
  }

  void _refresh() {
    page = 1;
    _request(true);
  }

  void _endRefresh() {
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }

  void _request([bool isclear = false]) {
    Networktool.request(API.uUserTicketRecord + "$page/10", method: HTTPMETHOD.GET, success: (data) async {
      final tmep = ReelReponse.fromJson(data);
      if(isclear) list.clear();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.getString('languageCode') == "en") {
        tmep.data.forEach((element) {
          if(element.ticketTitleEn != null) element.ticketTitle = element.ticketTitleEn;
        });
      }
      list.addAll(tmep.data);
      if(tmep.data.length < 10) _refreshController.loadNoData();
      if(mounted) setState(() {
        
      });
    },finaly: _endRefresh);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).reelrecord,
        onPop: () => Navigator.pop(context),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 19.0),
                child: Text(I18n.of(context).reelrecordhead),
              ),
              SizedBox(height: 18,),
              Divider(height: 1,),
              Expanded(
                child: RefreshWidget(
                  onLoading: _loading,
                  onRefresh: _refresh,
                  minPage: page,
                  controller: _refreshController,
                  child: ListView.separated(
                    itemCount: list.length,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    separatorBuilder: (context, index) {
                      return Divider(height: 1,);
                    },
                    itemBuilder: (context, index) {
                      return _Cell(model: list[index],);
                    }
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  final ReelModel model;

  const _Cell({Key key, this.model}) : super(key: key);

  String _getadd(String minaccount) {
    return minaccount == model.fromUser ? "-" : "+";
  }

  String _getStatus(BuildContext context) {
    switch (model.ticketType) {
      case 1:
        return I18n.of(context).reelstatus1;
        break;
      case 2: 
        return I18n.of(context).reelstatus2;
        break;
      case 3:
        return I18n.of(context).reelstatus3;
        break;
      case 4:
        return I18n.of(context).reelstatus4;
        break;
      default:
        return "--";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Consumer<UserModel>(builder: (context, value, child) {
        return Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${_getadd(value.data.mobile ?? value.data.email)}${model.ticketNumber} "+model.ticketTitle, style: AppFont.textStyle(12, color: AppColor.back998),),
                  Text(_getStatus(context), style: AppFont.textStyle(12, color: AppColor.back998),),
                ],
            ),
            SizedBox(height: 4,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Tool.timeFormat("yyyy/MM/dd HH:mm", model.createTime), style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),),
                Text(_getadd(value.data.mobile ?? value.data.email) == "+" ? model.fromUser : model.toUser, style: AppFont.textStyle(12, color: AppColor.back998),),
              ],
            ),
          ],
        );
      },)
    );
  }
}