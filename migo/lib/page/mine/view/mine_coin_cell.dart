import 'package:flutter/material.dart';

class MineCoinCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
      child: Row(
        children: [
          Icon(Icons.control_point),
          SizedBox(width: 20,),
          Text("USDT"),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("7777.7"),
              Text("\$7777.7")
            ],
          )
        ],
      ),
    );
  }
}