import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/exchange/view/exchange_cell.dart';
import 'package:migo/page/exchange/view/exchange_head_view.dart';

class ExchangeCoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: "MIGO"+I18n.of(context).coinexchange,
        leading: SizedBox(),
        actions: [
          IconButton(
            icon: Image.asset("assets/coins_record.png"),
            onPressed: () {
              Navigator.pushNamed(context, "/exchangerecord");
            },
          )
        ],
        child: ListView.builder(
          itemCount: 2,
          padding: const EdgeInsets.only(top: 32),
          itemBuilder: (context, index) {
            if(index == 0) {
              return ExhangeCoinHeadView();
            } else {
              return ExchangeCell();
            }
          }
        ),
      ),
    );
  }
}