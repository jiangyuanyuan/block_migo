import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/util/local_file.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/view/setting_cell.dart';

class FeedbackPage extends StatelessWidget {

  void _pushname(BuildContext context, String name, String title) async {
    String path = await LocalFile.filepath("docx", "assets/file/$name.docx");
    Navigator.pushNamed(context, "/file", arguments: {"title":title, "path":path});
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
                _pushname(context, "invite", I18n.of(context).feedinvite);
              },),
              SettingCell(title: I18n.of(context).feedaccount, onTap: () {
                _pushname(context, "account", I18n.of(context).feedaccount);
              },),
              SettingCell(title: I18n.of(context).feedmines, onTap: () {
                _pushname(context, "minesexpla", I18n.of(context).feedmines);
              },),
              // SettingCell(title: I18n.of(context).feeduse,),
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