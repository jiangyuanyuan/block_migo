import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/exchange/view/exchange_record_cell.dart';

class ExchangeRecordPage extends StatefulWidget {
  @override
  _ExchangeRecordPageState createState() => _ExchangeRecordPageState();
}

class _ExchangeRecordPageState extends State<ExchangeRecordPage> {

  int selecttype = 0;
  Widget _createHead() {
    List<String> list = [
      I18n.of(context).rnotpay, 
      I18n.of(context).rnotsure,
      I18n.of(context).rfinish, 
      I18n.of(context).rnotfinish,
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 24, right: 23, bottom: 8),
      child: Row(
        children: list.map((e) => _Item(
          index: list.indexOf(e), 
          titles: e, 
          isselect: selecttype == list.indexOf(e),
          onTap: () {
            setState(() {
              selecttype = list.indexOf(e);
            });
          },
        )).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).rtitle,
        onPop: () => Navigator.pop(context),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8))
          ),
          child: Column(
            children: [
              _createHead(),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return ExchangeRecordCell();
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String titles;
  final Function onTap;
  final int index;
  final bool isselect;

  const _Item({Key key, this.titles, this.onTap, this.index, this.isselect = false}) : super(key: key);

  BorderRadius _createRaduis() {
    if(index == 0) {
      return BorderRadius.horizontal(left: Radius.circular(4));
    } else if(index == 3) {
      return BorderRadius.horizontal(right: Radius.circular(4));
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 34,
          margin: const EdgeInsets.only(right: 1),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isselect ? const Color(0xff7BA0B9) : const Color(0x1A7BA0B9),
            borderRadius: _createRaduis()
          ),
          child: Text(titles, textAlign: TextAlign.center, style: AppFont.textStyle(12, color: isselect ? Colors.white : AppColor.back998),),
        ),
      ),
    );
  }
}