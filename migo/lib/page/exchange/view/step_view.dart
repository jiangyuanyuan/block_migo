import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class StepView extends StatelessWidget {
  final int step;

  const StepView({Key key, this.step}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Image.asset("assets/bg_step_grey_def.png", width: MediaQuery.of(context).size.width, fit: BoxFit.fill,),
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _BackItem(titles: I18n.of(context).sellcreate, index: 1,),
                _BackItem(titles: I18n.of(context).sellmakesure, index: 2,),
                _BackItem(titles: I18n.of(context).sellmakesurecoin, index: 3,),
                _BackItem(titles: I18n.of(context).sellfinish, index: 4,),
              ],
            ),
          ),
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _FrontItem(titles: I18n.of(context).sellcreate, img: "img_step1_bg_def", isshow: step == 1, index: 1,),
                _FrontItem(titles: I18n.of(context).sellmakesure, index: 2, img: "img_step2_bg_def", isshow: step == 2,),
                _FrontItem(titles: I18n.of(context).sellmakesurecoin, index: 3,img: "img_step2_bg_def", isshow: step == 3,),
                _FrontItem(titles: I18n.of(context).sellfinish, index: 4,img: "img_step4_bg_def", isshow: step == 4,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BackItem extends StatelessWidget {
  final int index;
  final String titles;

  const _BackItem({Key key, this.index, this.titles}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("$titles", textAlign: TextAlign.center, style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.3)),),
          SizedBox(height: 4,),
          Text("STEP$index",style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.3)))
        ],
      ),
    );
  }
}

class _FrontItem extends StatelessWidget {
  final int index;
  final String titles;
  final String img;
  final bool isshow;
  const _FrontItem({Key key, this.index, this.isshow = false, this.img, this.titles}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Visibility(
        visible: isshow,
        child: Container(
          height: double.infinity,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 4, top: 4, bottom: 4, right: 4),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/$img.png"),
              fit: BoxFit.fill
            )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("$titles", textAlign: TextAlign.center, style: AppFont.textStyle(12, color: Colors.white),),
              SizedBox(height: 4,),
              Text("STEP$index",style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.5)))
            ],
          ),
        ),
      ),
    );
  }
}

