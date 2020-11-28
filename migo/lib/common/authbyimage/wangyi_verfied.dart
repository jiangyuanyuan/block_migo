import 'dart:io';

import 'package:flutter/services.dart';
import 'package:migo/common/commview/alert.dart';

class WangyVerfied {
  var channel = const MethodChannel("yd_captcha_flutter_method_channel");
  var eventChannel = const EventChannel("yd_captcha_flutter_event_channel");
  
  Function(bool issuccess) onSuccess;

  static void showCaptcha(Function(bool issuccess) onfinish) {
    final temp = WangyVerfied();
    temp.onSuccess = onfinish;
    temp._showCaptcha();
  }

  _showCaptcha() {
    channel.invokeMethod("showCaptcha");
  }

  WangyVerfied() {
    eventChannel.receiveBroadcastStream().listen(_onData, onError: _onError);
  }

  _onError(Object error) {
    PlatformException exception = error;
    print(exception.message);
    onSuccess(false);
  }

  /// {
  /// result: true, 
  /// validate: CN31_8KXyaZEGKut4ERQMEVQt.VprYthz1ARssSAxjY-eySnExQ07IMUerHJu2eAvLtyZHEAjy_tQLml5N7CL4GZ-kEXQPL8B6nUjt_BUuM.Owi1oFmISDnPNx-uAQ_EXc7gF_E.qhT4kZRIME1e_pXPKjHLtl02SGZmHV8tLi7gfEQa-hdZYnf_8hJ2vivZfedj_YUgBA1MUZh9AixHdu5dqn8UaUuvjtQc5flwFwxm98lDdJjAOuenAA526jR9jAMHAUYiMAodm9aNvc1oh9IVN2CrpYnNIck_v_Hfh9W.PE27KZkqDNnnvPXdcnnpywCIwoIMYdhJllo9e_72a9APFFDOdOocF5IDeRnczn86yjO6lfAn5PRtxKhqT7q9lAdxOVIhp0_L6SLzKuts2_rTItm.EupsV2OhmH5Yhplbx8FNJjCrFjRodgZn5Z7Fm2nAVgRqGeQBLYJsxQ8DKVa_xNmMHhd8EtyP9wfv0i2vXydVojLRzvr6t-Wmjfwj3, 
  /// msg: 验证成功}
  void _onData(response) {
    if(response is Map) {
      if(Platform.isAndroid) {
        if(response["result"] == "true") {
          onSuccess(true);
        } else {
          Alert.showToast(response['msg']);
        }
      } else {
        if(response["result"]) {
          onSuccess(true);
        } else {
          Alert.showToast(response['msg']);
        }
      }
    }
  }
}