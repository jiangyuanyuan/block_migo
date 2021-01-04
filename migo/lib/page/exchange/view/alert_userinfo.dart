import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/screen_tool.dart';
import 'package:migo/generated/i18n.dart';

class AlerUserInfoView extends StatelessWidget {
  final String username;
  final String usermobile;

  const AlerUserInfoView({Key key, this.username, this.usermobile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 32,
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 40,),
              Text(I18n.of(context).alertuserinfo, style: AppFont.textStyle(14, color: AppColor.back998),),
              IconButton(
                  icon: Icon(Icons.cancel, color: Colors.black12,),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                  },
              )
            ],
          ),
          Divider(height: 1,),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffE5F0FA),
                    borderRadius: BorderRadius.circular(4)
                  ),
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 2),
                  child: Column(
                    children: [
                      _ItemLabel(title: I18n.of(context).susername, val: username,),
                      _ItemLabel(title: I18n.of(context).payusermobile, val: usermobile, onTap: () {
                        ScreenTool.copy(usermobile);
                      }, showIcon: true,),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Center(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(I18n.of(context).notpaycoin , style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
          ))
        ]
      )
    );
  }
}

class _ItemLabel extends StatelessWidget {
  final String title;
  final String val;
  final Color color;
  final bool showIcon;
  final Function onTap;
  const _ItemLabel({Key key, this.title, this.onTap, this.showIcon = false, this.val, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),),
          Expanded(child: Text(val, style: AppFont.textStyle(12, color: color ?? AppColor.back998),)),
          Visibility(
            visible: showIcon,
            child: InkWell(
              onTap: onTap,
              child: Image.asset("assets/copy.png"))
            )
        ],
      ),
    );
  }
}