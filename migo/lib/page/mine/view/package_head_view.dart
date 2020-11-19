import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/tool.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/page/home/view/home_gradient_text.dart';
import 'package:migo/page/mine/model/mine_package_model.dart';

class PackageHeadView extends StatelessWidget {
  final MinePackageHeadModel model;

  const PackageHeadView({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 26, left: 32, right: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(I18n.of(context).currtotalproduce, style: AppFont.textStyle(12, color: const Color(0xffDBF0FF), showshadow: true),),
              SizedBox(height: 8,),
              // Text(, style: AppFont.textStyle(12, color: Colors.white),),
              HomeGradientText(data: Tool.number(model?.totalProductivity, 4), fontstyle: AppFont.textStyle(16, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Text(I18n.of(context).todaypreget, style: AppFont.textStyle(12, color: const Color(0xffDBF0FF), showshadow: true),),
              HomeGradientText(data: Tool.number(model?.todayForecast, 4), fontstyle: AppFont.textStyle(16, fontWeight: FontWeight.bold),),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(I18n.of(context).packagesize, style: AppFont.textStyle(12, color: const Color(0xffDBF0FF), showshadow: true),),
              SizedBox(height: 8,),
              HomeGradientText(data: "${model?.usedCapacity ?? 0} / ${model?.totalCapacity ?? 0}", fontstyle: AppFont.textStyle(16, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Text("${I18n.of(context).totalgetmigos} MIGOs", style: AppFont.textStyle(12, color: const Color(0xffDBF0FF), showshadow: true),),
              HomeGradientText(data: Tool.number(model?.totalMIGOs, 4), fontstyle: AppFont.textStyle(16, fontWeight: FontWeight.bold),),
            ],
          )
        ],
      ),
    );
  }
}