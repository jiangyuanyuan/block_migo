import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';

class MineEarnHeadView extends StatelessWidget {
  final int tabindex;
  final Function(int sender) onTap;
  static const List<String> titles = [
    "全部",
    "乐屋",
    "乐巷",
    "乐堂",
    "乐都",
  ];

  const MineEarnHeadView({Key key, this.onTap, this.tabindex = 0}) : super(key: key);

  List<Widget> _create(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = (size.width - 40 - 40) / titles.length;
    return titles.map((e) => _Button(
      isselect: tabindex == titles.indexOf(e),
      width: width,
      onTap: () => onTap(titles.indexOf(e)),
      titles: e,
    )).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _create(context),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String titles;
  final Function() onTap;
  final double width;
  final bool isselect;
  const _Button({Key key, this.isselect = false, this.width = 50, this.titles, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isselect ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 1, color: const Color(0xff7BA0B9))
        ),
        child: Text(titles, style: AppFont.textStyle(12, color: !isselect ? const Color(0xffDBF0FF) : AppColor.back998),),
      ),
    );
  }
}