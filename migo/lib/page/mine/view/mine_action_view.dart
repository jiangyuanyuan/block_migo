import 'package:flutter/material.dart';

class MineActionView extends StatelessWidget {
  static const List<String> titles = [
    "我的背包",
    "充值",
    "提现",
    "邀请好友"
  ];
  static const List<String> imgs = [
    "我的背包",
    "充值",
    "提现",
    "邀请好友"
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
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
        break;
      case 2: 
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
        Icon(Icons.add),
        SizedBox(height: 8,),
        Text(titles)
      ],
    );
  }
}