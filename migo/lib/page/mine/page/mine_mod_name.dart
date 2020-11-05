import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/commview/bottom_buttom.dart';
import 'package:migo/common/commview/btn_action.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';
import 'package:migo/login&regist/model/user_model.dart';
import 'package:migo/login&regist/view/normal_textfield.dart';
import 'package:migo/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class MineModNamePage extends StatefulWidget {

  final Map params;

  const MineModNamePage({Key key, this.params}) : super(key: key);
  @override
  _MineModNamePageState createState() => _MineModNamePageState();
}

class _MineModNamePageState extends State<MineModNamePage> {

  final FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();
  bool modname = true; // 否则就是修改个性签名
  @override
  void initState() {
    super.initState();
    modname = widget.params['modname'];
    controller.text = widget.params['val'];
  }

  @override
  void didUpdateWidget(MineModNamePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _save() {
    if(controller.text.isEmpty) return;
    final model = Provider.of<UserModel>(context, listen: false);
    // if(modname){
    //   model.setNickname(controller.text);
    // } else {
    //   model.setLabel(controller.text);
    // }
    
    _requestMod(controller.text);
  }

  void _requestMod(String val) {
    EasyLoading.show(status: "Loading...");
    Map<String, dynamic> params;
    if(modname) {
      params = {"logo":"","userName": val};
    } else {
      params = {"logo":"", "gender":"", "userSign": val,"nickName": ""};
    }
    Networktool.request(
      API.mod, 
      params: params,
      success: (data){
        EasyLoading.showSuccess("修改成功");
        // 更新用户缓存信息
        // if(data["data"] != null) UserInfoModel.saveData(data["data"]);
        final temp = Provider.of<UserModel>(context, listen: false);
        final curr = temp.data;
        curr.nickName = val;
        temp.setModel(curr);
        Navigator.pop(context);
    },fail: (msg) => EasyLoading.showError(msg));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          focusNode.unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: CommbackView(
          titles: "更改昵称",
          onPop: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                NormalTextfield(
                  hintText: "请输入昵称",
                  controller: controller,
                  focusNode: focusNode,
                ),
                BtnImageBottomView(
                  title: I18n.of(context).save,
                  onTap: _save,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}