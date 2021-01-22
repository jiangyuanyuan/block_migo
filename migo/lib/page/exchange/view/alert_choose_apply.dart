import 'package:flutter/material.dart';
import 'package:migo/common/commview/bottom_buttom.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class AlertChooseApplyView extends StatelessWidget {
  final List<String> titles;
  final Function(int sender) onTap;
  const AlertChooseApplyView({Key key, this.titles, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 45,),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Image.asset("assets/warning.png"),
              ),
              IconButton(
                icon: Icon(Icons.cancel, color: Colors.grey,),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14, bottom: 8),
            child: Text(I18n.of(context).submitapply, style: AppFont.textStyle(14, color: AppColor.back998, fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              I18n.of(context).submitapplynotice,
              style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: titles.map((e) => BtnImageBottomView(title: e, onTap: () {
                Navigator.pop(context);
                onTap(titles.indexOf(e));
              },)).toList(),
            ),
          )
        ],
      ),
    );
  }
}