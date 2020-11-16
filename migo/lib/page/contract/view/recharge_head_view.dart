import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class RechargeHeadView extends StatefulWidget {
  final Function(int tabindex) onSelected;
  final bool isreflect;
  const RechargeHeadView({Key key, this.onSelected, this.isreflect = false}) : super(key: key);
  @override
  _RechargeHeadViewState createState() => _RechargeHeadViewState();
}

class _RechargeHeadViewState extends State<RechargeHeadView> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            height: 1,
            left: 0,
            right: 0,
            child: Divider(height: 1),
          ),
          Positioned.fill(
            left: 54,
            right: 54,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColor.back998,
              unselectedLabelColor: Colors.black.withOpacity(0.5),
              indicatorColor: AppColor.back998,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 30),
              labelStyle: AppFont.textStyle(12, color: AppColor.back998),
              unselectedLabelStyle: AppFont.textStyle(12, color: Colors.black.withOpacity(0.5)),
              onTap: (sender) {
                if(sender == 1 && widget.isreflect) {
                  EasyLoading.showToast(I18n.of(context).rechargeNotsupport);
                  _tabController.index = 0;
                } else {
                  if(widget.onSelected != null) {
                    widget.onSelected(sender);
                  }
                }
              } ,
              tabs: [
                Text("TRC20"),
                Text("ERC20"),
              ],
            )
          ),
          Positioned.fill(
            child: Center(
              child: Container(
                width: 1,
                height: 10,
                color: Colors.black.withOpacity(0.1),
              ),
            )
          )
        ],
      ),
    );
  }
}