import 'package:migo/common/commview/appbar.dart';
import 'package:migo/common/commview/bottom_buttom.dart';
import 'package:migo/common/network/network.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/login&regist/model/user_model.dart';
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
      appBar: NormalAppbar.normal(
        title: Text("编辑个人资料"),
        onPress: () => Navigator.pop(context)
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 51,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColor.f9f9f9,
                borderRadius: BorderRadius.circular(10)
              ),
              child: TextField(
                focusNode: focusNode,
                controller: controller,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(
                      "[a-zA-Z]|[\u4e00-\u9fa5]|[0-9]")), //只能输入汉字或者字母或数字
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelStyle: AppFont.textStyle(15, color: AppColor.font333),
                  hintText: modname ? "输入姓名(10字内)" : '请输入个性签名(10字内)',
                  counterText: "",
                  prefix: SizedBox(width: 15,),
                  hintStyle: AppFont.textStyle(16, color: AppColor.fontgrey),
                  suffixIcon: IconButton(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    icon: Icon(Icons.cancel, color: const Color(0xffcccccc),),
                    onPressed: () => controller.clear(),
                  ),
                ),
                onChanged: (val) {
                  if(val.length > 10) controller.text = val.substring(0,10);
                },
              ),
            ),
            Spacer(),
            BottomButton(
              title: "保存",
              onTap: _save,
            )
          ],
        ),
      ),
    );
  }
}