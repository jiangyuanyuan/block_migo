import 'package:flutter/material.dart';
import 'package:migo/common/commview/btn_image_bottom.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class FeedbackPosePage extends StatefulWidget {
  @override
  _FeedbackPosePageState createState() => _FeedbackPosePageState();
}

class _FeedbackPosePageState extends State<FeedbackPosePage> {

  final focusnode = FocusNode();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => focusnode.unfocus(),
        child: CommbackView(
          titles: I18n.of(context).feed,
          onPop: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SizedBox(height: 40,),
                Stack(
                  children: [
                    Image.asset("assets/banner_back.png", height: 222, width: MediaQuery.of(context).size.width, fit: BoxFit.fill,),
                    TextField(
                      maxLines: 10,
                      controller: _controller,
                      focusNode: focusnode,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: I18n.of(context).pleaseinput,
                        contentPadding: EdgeInsets.all(10),
                        hintStyle: AppFont.textStyle(12, color: Colors.black.withOpacity(0.2))
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Text(I18n.of(context).feennotice, style: AppFont.textStyle(12, color: Colors.white.withOpacity(0.5)),),
                Spacer(),
                SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: BtnImageBottomView(
                          img: "home_btn.png",
                          title: I18n.of(context).feedchoose,
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        flex: 1,
                        child: BtnImageBottomView(
                          img: "home_btn_inactive.png",
                          title: I18n.of(context).submit,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 70,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}