import 'dart:io';

import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

class Tool {
  static bool isLoginPassword(String input) {
    RegExp mobile = new RegExp(r"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$");
    return mobile.hasMatch(input);
  }

  static String timeFormat(String format, int createtime) {
    if(createtime == null) createtime = 0;
    return DateFormat(format).format(DateTime.fromMillisecondsSinceEpoch(createtime));
  }

  static String timeForWeekendDay(int createtime) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(createtime);
    return _getWeekday(time.weekday);
  }

  /// 计算相差多久
  static String timeDistance(int createtime) {
    
    DateTime time = DateTime.fromMillisecondsSinceEpoch(createtime);
    DateTime now = DateTime.now();
    Duration duration = now.difference(time);
    var res = "";
    print(duration);
    int day = duration.inHours ~/ 24;
    int hour = duration.inHours % 24;
    if(day != 0) {
      res += day.toString() + "天";
    }
    if(hour != 0) {
      res += hour.toString() + "时";
    }
    return res == "" ? "0时" : res;
  }

  static String _getWeekday(int weekday) {
    switch (weekday) {
      case 1:return "星期一";
      case 2:return "星期二";
      case 3:return "星期三";
      case 4:return "星期四";
      case 5:return "星期五";
      case 6:return "星期六";
      default:return "星期日";
    }
  }

  // md5 加密
  static String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }

  /// 千分位格式化
  /// fixed 保留几位小数
  static String thousandFormat(num val, {int fixed = 2, String splichar = ","}) {
    if(val == null) return 0.toStringAsFixed(2);
    if(fixed == null) fixed = 2;
    String temp = val.abs().toStringAsFixed(fixed);
    List<String> arr = temp.split("");
    final index = arr.indexOf(".") - 3;
    for(int i = index; i > 0; i -= 3) {
      arr.insert(i, splichar);
    }
    return val < 0 ? "-${arr.join("")}" : arr.join("");
  }

    /*
  * 通过图片路径将图片转换成Base64字符串
  */
  static Future<String> image2Base64(File path) async {
    File file = path;
    List<int> imageBytes = await file.readAsBytes();
    return "base64Data,"+base64Encode(imageBytes);
  }

  static String number(num sender, int fixed) {
    if(sender == null) return "0.00";
    if(fixed == null) fixed = 2;
    String res = "$sender";
    final temp = res.split(".");
    if(temp.length < 2) {
      return res;
    } else {
      if(temp[1].length > fixed) {
        res = temp[0] + "." + temp[1].substring(0, fixed);
        if(temp[1].length < fixed) {
          res += "0" * (fixed - temp[1].length);
        }
        return res;
      } else {
        res = temp[0] + "." + temp[1];
        if(temp[1].length < fixed) {
          res += "0" * (fixed - temp[1].length);
        }
        return res;
      }
    }
  }

  static String timeHourAndDay(int createtime, int days) {
    DateTime now = DateTime.fromMillisecondsSinceEpoch(createtime);
    DateTime to = now.add(Duration(days: days));
    Duration duration = to.difference(now);
    int hour = duration.inHours;
    if(hour % 24 == 0) {
      return "${hour / 24}天";
    } else {
      return "${hour ~/ 24}天${hour % 24}小时";
    }
  }
}