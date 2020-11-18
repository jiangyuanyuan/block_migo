import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/const/const_html.dart';
import 'package:migo/common/util/local_file.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/view/setting_cell.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackPage extends StatelessWidget {

  void _pushname(BuildContext context, String content, String encontent, String title) async {
    String sufix = content;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageStr = prefs.getString('languageCode');
    if(languageStr == "en" || languageStr == null) sufix = encontent;
    Navigator.pushNamed(context, "/file", arguments: {"title":title, "content":sufix});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).feedback,
        onPop: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: Column(
            children: [
              SizedBox(height: 30,),
              SettingCell(title: I18n.of(context).feedinvite, onTap: () {
                _pushname(context, ConstHTML.invite, ConstHTML.invite_en, I18n.of(context).feedinvite);
              },),
              SettingCell(title: I18n.of(context).feedaccount, onTap: () {
                _pushname(context, ConstHTML.account, ConstHTML.account_en, I18n.of(context).feedaccount);
              },),
              SettingCell(title: I18n.of(context).feedmines, onTap: () {
                _pushname(context, ConstHTML.minesexpla, ConstHTML.minesexpla_en, I18n.of(context).feedmines);
              },),
              SettingCell(title: I18n.of(context).feeduse, onTap: () {
                _pushname(context, ConstHTML.desc, ConstHTML.desc_en, I18n.of(context).feedmines);
              },),
              SettingCell(
                title: I18n.of(context).feed,
                onTap: () => Navigator.pushNamed(context, "/feedpost"),
              ),
              // SettingCell(title: I18n.of(context).feeddel,),
            ],
          ),
        ),
      ),
    );
  }
}