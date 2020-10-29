import 'package:migo/main.dart' show FreeLocalizations;
import 'package:flutter/material.dart';
import 'package:migo/common/language/i18n.dart';
import 'package:migo/common/util/t_event_bus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  _setCurrentDeviceLocale(Locale deviceLocale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', deviceLocale.languageCode);
    prefs.setString('countryCode', deviceLocale.countryCode);

    teventBus.fire(deviceLocale);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).app_lan),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
              onPressed: () {
                _setCurrentDeviceLocale(Locale("en", ""));
              },
              child: Text(S.of(context).app_en)),
          FlatButton(
              onPressed: () {
                _setCurrentDeviceLocale(Locale("zh", "CN"));

              },
              child: Text(S.of(context).app_cn)),
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).app_auto)),
        ],
      )),
    );
  }
}
