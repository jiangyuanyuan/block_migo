import 'package:flutter/material.dart';
import 'package:migo/common/commview/custom_menu_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class ExchangeCell extends StatefulWidget {
  final bool ispre;

  const ExchangeCell({Key key, this.ispre = true}) : super(key: key);
  @override
  _ExchangeCellState createState() => _ExchangeCellState();
}

class _ExchangeCellState extends State<ExchangeCell> {
  String coins = "USDT";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(width: 1, color: const Color(0xffF0F1F2))
      ),
      child: Column(
        children: [
          SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.ispre ? I18n.of(context).output : "${I18n.of(context).output}(${I18n.of(context).estimate})", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
              Text("${I18n.of(context).balance}: 44.848485", style: AppFont.textStyle(12, color: AppColor.back998),)
            ],
          ),
          Row(
            children: [
              Expanded(
                child: IgnorePointer(
                  ignoring: !widget.ispre,
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelStyle: AppFont.textStyle(16, color: AppColor.back998, fontWeight: FontWeight.bold),
                      hintText: "0.0",
                      counterText: "",
                      hintStyle: AppFont.textStyle(16, color: AppColor.back998, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Text("MAX", style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: CustiomMenuView(
                  titles: ["USDT", "MIGO"],
                  onSelected: (index, val) {
                    setState(() {
                      coins = val;
                    });
                  },
                  child: Container(
                    width: 92,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.back998,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(coins, style: AppFont.textStyle(12, color: Colors.white),),
                        SizedBox(width: 5,),
                        Image.asset("assets/pull.png")
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}