import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class HomeDetailBarView extends StatefulWidget {
  final Function(int tabindex) onTabIndex;

  const HomeDetailBarView({Key key, this.onTabIndex}) : super(key: key);
  @override
  _RechargeHeadViewState createState() => _RechargeHeadViewState();
}

class _RechargeHeadViewState extends State<HomeDetailBarView> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if(widget.onTabIndex != null) widget.onTabIndex(_tabController.index);
    });
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
            left: 0,
            right: 0,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColor.back998,
              unselectedLabelColor: Colors.black.withOpacity(0.5),
              indicatorColor: AppColor.back998,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 50),
              labelStyle: AppFont.textStyle(14, color: AppColor.back998),
              unselectedLabelStyle: AppFont.textStyle(14, color: Colors.black.withOpacity(0.5)),
              tabs: [
                Text(I18n.of(context).miningpaymentrecord),
                Text(I18n.of(context).miningrevenuerecord),
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