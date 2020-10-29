import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:migo/provider/user.dart';
import 'package:migo/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/const/cosnt.dart';
import 'common/language/i18n.dart';
import 'common/util/t_event_bus.dart';
import 'login&regist/page/guide_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MyApp()
    )
  );
}

GlobalKey<_FreeLocalizations> freeLocalizationStateKey1 =
new GlobalKey<_FreeLocalizations>(); //

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MIGO',
      theme: ThemeData(
        primaryColor: const Color(0xff5C96EA),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(elevation: 0, brightness: Brightness.light),
        primaryTextTheme: TextTheme(headline6: TextStyle(fontSize:17, fontFamily: "PingFang-Medium", color: AppColor.font333)),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      home: GuidePage(),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      builder: (context, child) {
        ScreenUtil.init(context, width: 375, height: 667, allowFontScaling: true);
        FlutterStatusbarcolor.setStatusBarColor(Colors.transparent, animate: true);
        return Material(
          type: MaterialType.transparency,
          child: FreeLocalizations(
            key: freeLocalizationStateKey1,
            child: FlutterEasyLoading(
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class FreeLocalizations extends StatefulWidget {
  final Widget child;

  FreeLocalizations({Key key, this.child}) : super(key: key);

  @override
  State<FreeLocalizations> createState() {
    return new _FreeLocalizations();
  }
}

class _FreeLocalizations extends State<FreeLocalizations> {
  Locale _locale = const Locale('en', '');

  Future<Locale> getDeviceLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageStr = prefs.getString('languageCode');
    String country = prefs.getString('countryCode');
    return Locale(languageStr, country);
  }

  //监听bus
  void listen(){
    teventBus.on<Locale>().listen((locale){
      changeLocale(locale);
    });
  }

  changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    Future<Locale> locale = getDeviceLocale();
    locale.then((locales) {
      changeLocale(locales);
    });
  }

  @override
  Widget build(BuildContext context) {
    freeLocalizationStateKey1.currentState.listen();
    return new Localizations.override(
      context: context,
      locale: _locale,
      child: widget.child,
    );
  }
}
