import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class AlertAuthView extends StatelessWidget {
  final Function() onSure;
  final int status;
  const AlertAuthView({Key key, this.status = 0, this.onSure}) : super(key: key);

  String _getString(BuildContext context) {
    switch (status) {
      case 0:
        return I18n.of(context).reelusecontent("1");
        break;
      case 1:
        return I18n.of(context).reeluserd;
        break;
      default: 
        return I18n.of(context).reelnouse;
    }
  }

  Widget _createBtton(BuildContext context) {
    switch (status) {
      case 0:
        return Row(
            children: [
              Expanded(
                child: BtnImageBottomView(
                  title: I18n.of(context).cancel,
                  img: "home_btn_inactive.png",
                  onTap: () => Navigator.pop(context),
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: BtnImageBottomView(
                  title: I18n.of(context).sure,
                  img: "home_btn.png",
                  onTap: () {
                    onSure();
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          );
        break;
      case 1:
        return BtnImageBottomView(
                  title: I18n.of(context).sure,
                  img: "btn_active.png",
                  onTap: () {
                    Navigator.pop(context);
                  },
                );
        break;
      default:
        return BtnImageBottomView(
                  title: I18n.of(context).sure,
                  img: "btn_inactive.png",
                  onTap: () {
                    Navigator.pop(context);
                  },
                );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 32,
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10,),
          Image.asset("assets/icon_reel.png"),
          Padding(
            padding: const EdgeInsets.only(top: 14.0, bottom: 10),
            child: Text(I18n.of(context).reelusename, style: AppFont.textStyle(14, color: AppColor.back998),),
          ),
          Text(_getString(context), style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
          SizedBox(height: 44,),
          _createBtton(context)
        ],
      ),
    );
  }
}