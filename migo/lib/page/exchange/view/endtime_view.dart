import 'dart:async';

import 'package:flutter/material.dart';

import '../../../common/commview/btn_image_bottom.dart';
import '../../../common/util/tool.dart';
import '../../../generated/i18n.dart';

class EndTimeView extends StatefulWidget {
  final int endtime;
  final TextStyle textStyle;
  final String leftString;
  final Function() onFinish;
  final Function() onTap;
  const EndTimeView({Key key, this.onFinish, this.leftString = "结束倒计时：", this.onTap, this.endtime, this.textStyle}) : super(key: key);
  @override
  _EndTimeViewState createState() => _EndTimeViewState();
}

class _EndTimeViewState extends State<EndTimeView> {

  int currTime;
  Timer _timer;
  String timeString = "--";
  int endtime;
  bool isenable = false;
  @override
  void initState() {
    super.initState();
    endtime = widget.endtime;
    _begin();
  }

  @override
  void didUpdateWidget(EndTimeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.endtime != endtime) {
      _begin();
    }
  }

  void _begin() {
    endtime = widget.endtime;
    currTime = widget.endtime - DateTime.now().millisecondsSinceEpoch;
    _timer?.cancel();
    _timer = null;
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) { 
      _compute();
    });
  }

  void _compute() {
    currTime -= 1000;
    if(currTime <= 0) {
      currTime = 0;
      _timer?.cancel();
      _timer = null;
      setState(() {
        timeString = "00:00:00";
        isenable = true;
      });
      if(widget.onFinish != null) widget.onFinish();
      return;
    }
    setState(() {
      timeString = Tool.timeFormat("HH:mm:ss", currTime);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return BtnImageBottomView(
      title: isenable ? I18n.of(context).shensu : "($timeString)"+I18n.of(context).shensu,
      img: isenable ? "btn_active.png" : "btn_inactive.png",
      onTap: () {
        if(isenable) {
          if(widget.onTap != null) widget.onTap();
        }
      },
    );
  }
}