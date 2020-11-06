import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/main.dart' show FreeLocalizations;
import 'package:flutter/material.dart';
import 'package:migo/common/util/t_event_bus.dart';
import 'package:migo/page/mine/view/setting_cell.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {

  String lang = "zh";

  _setCurrentDeviceLocale(Locale deviceLocale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', deviceLocale.languageCode);
    prefs.setString('countryCode', deviceLocale.countryCode);
    I18n.locale = deviceLocale;
    teventBus.fire(deviceLocale);
    setState(() {
      lang = deviceLocale.languageCode;
    });
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _getlanguage();
  }

  void _getlanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageStr = prefs.getString('languageCode');
    if(mounted) setState(() {
      lang = languageStr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: CommbackView(
        titles: I18n.of(context).language,
        onPop: () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SettingCell(title: "English", rightIconName: "ico_langu_yes_def.png", showArrowIcon: lang == "en", onTap: () => _setCurrentDeviceLocale(Locale("en", "")),),
            SettingCell(title: "中文", rightIconName: "ico_langu_yes_def.png", showArrowIcon: lang == "zh", onTap: () => _setCurrentDeviceLocale(Locale("zh", "CN")))
          ],
      ),
        ),
      )
    );
  }
}
