import 'package:flutter/material.dart';
import 'package:migo/page/mine/view/mine_action_view.dart';
import 'package:migo/page/mine/view/mine_coin_cell.dart';
import 'package:migo/page/mine/view/mine_head.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 9,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          if(index == 0) return MainHeadView();
          return MineCoinCell();
        }
      ),
    );
  }
}