import 'package:migo/common/textstyle/textstyle.dart';
import 'package:flutter/material.dart';

class HomeHeadView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SafeArea(child: Icon(Icons.access_time))
        ),
        Container(
          height: 130,
          color: Colors.red,
        ),
        SizedBox(height: 35,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Row(
            children: [
              Expanded(
                child: _DetailBtn(title: "MIGO",),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: _DetailBtn(title: "MIGOS",),
              )
            ],
          ),
        )
      ],
    );
  }
}

class _DetailBtn extends StatelessWidget {
  final String img;
  final String title;
  final Function() onTap;

  const _DetailBtn({Key key, this.img, this.title, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.green
        ),
        child: Text(title, style: AppFont.textStyle(14, color: Colors.white),),
      ),
    );
  }
}