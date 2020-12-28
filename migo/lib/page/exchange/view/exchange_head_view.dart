import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/home/view/home_gradient_text.dart';
import 'package:migo/page/mine/view/headdetail_view.dart';

class ExhangeCoinHeadView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeadDetailView(title: "${I18n.of(context).extodayprice}(USDT)", detail: Tool.number(100, 2),),
              HeadDetailView(title: "${I18n.of(context).exyesterdayprice}(USDT)", detail: Tool.number(100, 2),),
              HeadDetailView(title: I18n.of(context).exupdown, detail: Tool.number(50, 2),),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16, top: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                spreadRadius: 0,
                offset: Offset(0, 2),
                color: Colors.black.withOpacity(0.3)
              )
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Item(title: I18n.of(context).extodaycount, val: "10000",),
              _Item(title: I18n.of(context).explatformcount, val: "10000",),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 19),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(I18n.of(context).exablebanence, style: AppFont.textStyle(
                  12, 
                  color: const Color(0xffDBF0FF),
                  showshadow: true
                ),
              ),
              HomeGradientText(
                data: "17023.58343743 MIGO",
                fontstyle: AppFont.textStyle(
                  12, 
                  showshadow: true
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 24, right: 24.0),
          child: BtnImageBottomView(
            title: I18n.of(context).exbuy,
            onTap: () => Navigator.pushNamed(context, "/exchangebuy"),
          ),
        ),
        Container(
          height: 97,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.only(top: 19, left: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(I18n.of(context).exbuylist, style: AppFont.textStyle(12, color: Colors.black)),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) => _Btn(titles: index.toString(), isselect: index == 0,))
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class _Item extends StatelessWidget {
  final String title;
  final String val;

  const _Item({Key key, this.title, this.val}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.3)),),
        Text(val, style: AppFont.textStyle(24, color: AppColor.back998, fontWeight: FontWeight.bold),)
      ],
    );
  }
}

class _Btn extends StatelessWidget {
  final String titles;
  final bool isselect;
  final Function onTap;

  const _Btn({Key key, this.titles, this.isselect, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: isselect ? const Color(0xff7BA0B9) : Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 1, color: isselect ? const Color(0xff7BA0B9) : const Color(0xffEFF4F8))
        ),
        child: Text(titles, style: AppFont.textStyle(12, color: isselect ? Colors.white : const Color(0xff7BA0B9), fontWeight: FontWeight.bold),),
      ),
    );
  }
}