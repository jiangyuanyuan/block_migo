import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/mine/view/setting_cell.dart';

class FeedbackPage extends StatelessWidget {
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
              SettingCell(title: I18n.of(context).feedinvite,),
              SettingCell(title: I18n.of(context).feedaccount,),
              SettingCell(title: I18n.of(context).feedmines,),
              SettingCell(title: I18n.of(context).feeduse,),
              SettingCell(
                title: I18n.of(context).feed,
                onTap: () => Navigator.pushNamed(context, "/feedpost"),
              ),
              SettingCell(title: I18n.of(context).feeddel,),
            ],
          ),
        ),
      ),
    );
  }
}