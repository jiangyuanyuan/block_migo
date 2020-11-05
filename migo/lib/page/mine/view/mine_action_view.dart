import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class MineActionView extends StatelessWidget {
  // static const List<String> titles = [
  //   "我的背包",
  //   "充值",
  //   "提现",
  //   "邀请好友"
  // ];
  static const List<String> imgs = [
    "home_package.png",
    "mine_recharge.png",
    "home_reflect.png",
    "home_mine.png"
  ];
  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      I18n.of(context).mypackage,
      I18n.of(context).recharge,
      I18n.of(context).withdraw,
      I18n.of(context).invite,
    ];
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: const Color(0xff23496E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(8))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: titles.map((e) => InkWell(
          onTap: () => _jump(context, titles.indexOf(e)),
          child: _DetailView(img: imgs[titles.indexOf(e)], titles: e,))).toList(),
      ),
    );
  }

  void _jump(BuildContext context, int status) {
    switch (status) {
      case 0:
        Navigator.pushNamed(context, "/package");
        break;
      case 1:
        Navigator.pushNamed(context, '/recharge');
        break;
      case 2: 
        Navigator.pushNamed(context, '/reflect');
        break;
      default:
        Navigator.pushNamed(context, "/invite");
    }
  }
}

class _DetailView extends StatelessWidget {
  final String img;
  final String titles;

  const _DetailView({Key key, this.img, this.titles}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/$img"),
        SizedBox(height: 8,),
        Text(titles, style: AppFont.textStyle(10, color: Colors.white),)
      ],
    );
  }
}