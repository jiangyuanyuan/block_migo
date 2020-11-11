import 'package:flutter/material.dart';
import 'package:migo/common/commview/custom_menu_view.dart';
import 'package:migo/common/textstyle/textfield_number.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/contract/model/exchange_model.dart';

class ExchangeCell extends StatefulWidget {
  final bool ispre;
  final List<String> titles;
  final Function(String val, int index) onSelected;
  final List<ExchangeCoinModel> tradings;
  final Function(String val) onChanged;
  final String outputAmount;
  final String currCoinsName;
  const ExchangeCell({
    Key key, 
    this.tradings, 
    this.ispre = true, 
    this.onChanged,
    this.onSelected, 
    this.outputAmount,
    this.currCoinsName,
    this.titles
  }) : super(key: key);
  @override
  _ExchangeCellState createState() => _ExchangeCellState();
}

class _ExchangeCellState extends State<ExchangeCell> {
  String coins = "--";
  List<String> titles = [];
  TextEditingController _editingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    titles = titles;
    if(widget.titles != null && widget.titles?.length > 0) {
      coins = widget.titles.first;
    }
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  String _getTrading() {
    num res = 0;
    if(widget.tradings != null && widget.tradings.length > 0) {
      final e = widget.tradings.firstWhere((element) => element.ntn.startsWith(coins), orElse: () => null,);
      if(e != null) {
        if(widget.ispre) {
          res = e.inputCoinAmount;
        } else {
          res = e.outputCoinAmount;
        }
      }
    }
    return Tool.number(res, 4);
  }

  @override
  void didUpdateWidget(ExchangeCell oldWidget) {
    if(widget.titles != null){
      if(widget.titles.length > 0) {
        if(widget.currCoinsName != coins && widget.ispre == false) {
          titles = widget.titles;
          coins = widget.titles.first;
        } else {
          if(titles.join("") != widget.titles.join("")) {
            titles = widget.titles;
            coins = widget.titles.first;
          }
        }
      }
    }
    if(widget.ispre == false) _editingController.text = Tool.number(num.parse(widget.outputAmount), 4);
    super.didUpdateWidget(oldWidget);
  }

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
              Text("${I18n.of(context).balance}: ${_getTrading()}", style: AppFont.textStyle(12, color: AppColor.back998),)
            ],
          ),
          Row(
            children: [
              Expanded(
                child: IgnorePointer(
                  ignoring: !widget.ispre,
                  child: TextField(
                    controller: _editingController,
                    focusNode: focusNode,
                    style: AppFont.textStyle(16, color: AppColor.back998, fontWeight: FontWeight.bold),
                    onChanged: widget.onChanged,
                    onSubmitted: widget.onChanged,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      NumberFormat(decimalRange: 8)
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
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
                  titles: titles?.length == 0 ? ["--"] : titles,
                  onSelected: (index, val) {
                    setState(() {
                      coins = val;
                    });
                    if(widget.onSelected != null) {
                      widget.onSelected(coins, index);
                    }
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