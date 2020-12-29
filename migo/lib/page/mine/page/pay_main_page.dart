import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class PayMainPage extends StatefulWidget {
  @override
  _PayMainPageState createState() => _PayMainPageState();
}

class _PayMainPageState extends State<PayMainPage> {
  List<String> imgs = [
    "logo_colle_wechat_def",
    "logo_colle_wechat_def备份",
    "logo_colle_bank_def"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: I18n.of(context).spaysetting,
        onPop: () => Navigator.pop(context),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, "/paysetting");
            },
          )
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 16),
          child: Column(
            children: [
              _Cell(type: 0, title: I18n.of(context).paybank, val: "1891289", img: imgs[0],),
              _Cell(type: 1, title: I18n.of(context).payalipay, val: "1891289", img: imgs[1],),
              _Cell(type: 2, title: I18n.of(context).paywx, val: "1891289", img: imgs[2],),
            ],
          ),
        ),
      ),
    );
  }
}


class _Cell extends StatelessWidget {
  final int type;
  final String title;
  final String val;
  final String img;
  const _Cell({Key key, this.type, this.img, this.title, this.val}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg_list_sett_def.png"),
          fit: BoxFit.fill
        )
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Image.asset("assets/$img.png"),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppFont.textStyle(14,),),
              SizedBox(height: 6,),
              Text(val, style: AppFont.textStyle(12, color: Colors.black.withOpacity(0.4)),)
            ],
          )
        ],
      ),
    );
  }
}

