import 'package:migo/common/const/cosnt.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/cache_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MineSettingClear extends StatefulWidget {
  @override
  _MineSettingClearState createState() => _MineSettingClearState();
}

class _MineSettingClearState extends State<MineSettingClear> {

  String cache = "0.0M";

  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() async {
    double val = await CacheTool.loadCache();
    val = val / 1024 / 1024;
    setState(() {
      cache = val.toStringAsFixed(2) + "M";
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        EasyLoading.show(status: "Loading...");
        bool res = await CacheTool.clearCache();
        EasyLoading.dismiss();
        if(res == true) _initData();
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("清除缓存", style: AppFont.textStyle(15, color:AppColor.font333),)),
                Padding(
                  padding: const EdgeInsets.only(right:8.0),
                  child: Text(cache, style: AppFont.textStyle(15, color:AppColor.font666)),
                ),
                Image.asset("assets/icon_you.png")
              ],
            ),
          ),
          SizedBox(height: 1, child: Divider(indent: 15, endIndent: 15,))
        ],
      ),
    );
  }
}