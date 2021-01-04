import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/exchange/model/basead_model.dart';
import 'package:migo/page/home/view/home_gradient_text.dart';
import 'package:migo/page/mine/view/headdetail_view.dart';

class ExhangeCoinHeadView extends StatefulWidget {
  static const List<String> rangesTitles = [
    "1-20",
    "21-100",
    "101-200",
    "201-300",
    "300以上",
  ];
  final BaseAdModel model;
  final Function onRefresh;
  final Function(String rate) onSelect;
  const ExhangeCoinHeadView({Key key, this.model, this.onSelect, this.onRefresh}) : super(key: key);

  @override
  _ExhangeCoinHeadViewState createState() => _ExhangeCoinHeadViewState();
}

class _ExhangeCoinHeadViewState extends State<ExhangeCoinHeadView> {

  int selectIndex = 0;

  num _getnumber() {
    if(widget.model == null || widget.model?.yesterdayPrice == null) return 0;
    num last = num.parse(widget.model?.yesterdayPrice);
    num today = num.parse(widget.model?.todayPrice);
    return last == 0 ? 0 : ((today - last) / last) * 100;
  }

  num _todayPrice() {
    num today = num.parse(widget.model?.todayPrice ?? "0",(e) => 0);
    num newp = num.parse(widget.model?.newUsdtPrice ?? '0',(e) => 0);
    return today * newp;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeadDetailView(title: "${I18n.of(context).extodayprice}(USDT)", detail: Tool.number(num.parse(widget.model?.todayPrice ?? "0"), 3),),
              HeadDetailView(title: I18n.of(context).exupdown, isright: true, detail: Tool.number(_getnumber(), 2) + "%",),
            ],
          ),
        ),
        SizedBox(height: 14,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeadDetailView(title: "${I18n.of(context).exyesterdayprice}(USDT)", detail: widget.model?.yesterdayPrice,),
              HeadDetailView(title: "${I18n.of(context).extodaypricecny}", isright: true, detail: "${ Tool.number(num.parse(widget.model?.todayPrice ?? "0"), 3)} USDT≈${Tool.number(_todayPrice(), 2)} CNY",),
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
              _Item(title: I18n.of(context).extodaycount, val: Tool.number(widget.model?.todayTradeAmount, 2),),
              _Item(title: I18n.of(context).explatformcount, val: Tool.number(widget.model?.totalTradeAmount, 2),),
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
                data: "${Tool.number(widget.model?.balance, 2)} MIGO",
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
            onTap: () async {
              final res = await Navigator.pushNamed(context, "/exchangebuy", arguments: {"price":widget.model?.todayPrice});
              if(res != null) {
                if(widget.onRefresh != null) widget.onRefresh();
              }
            },
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(5, (index) => _Btn(titles: ExhangeCoinHeadView.rangesTitles[index], isselect: index == selectIndex, onTap: () {
                      setState(() {
                        selectIndex = index;
                      });
                      if(widget.onSelect != null) widget.onSelect(ExhangeCoinHeadView.rangesTitles[index]);
                    },))
                  ),
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