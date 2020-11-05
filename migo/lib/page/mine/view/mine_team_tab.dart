import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/generated/i18n.dart';

class MineTeamTabarView extends StatefulWidget {
  final Function(int sender) onTabIndex;

  const MineTeamTabarView({Key key, this.onTabIndex}) : super(key: key);
  @override
  _MineTeamTabarViewState createState() => _MineTeamTabarViewState();
}

class _MineTeamTabarViewState extends State<MineTeamTabarView> with SingleTickerProviderStateMixin{
  
  TabController _tabController;
  int tabIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        tabIndex = _tabController.index;
      });
      if(widget.onTabIndex != null) {
        widget.onTabIndex(tabIndex);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
      indicatorColor: Colors.transparent,
      tabs: [
        Text(I18n.of(context).teamgroupshare, style: AppFont.textStyle(tabIndex == 0 ? 16 : 14, color: tabIndex == 0 ? Colors.white : const Color(0xffDBDAE0)),),
        Text(I18n.of(context).teamgroupleader, style: AppFont.textStyle(tabIndex == 1 ? 16 : 14, color: tabIndex == 1 ? Colors.white : const Color(0xffDBDAE0))),
        Text(I18n.of(context).teamgrouppush, style: AppFont.textStyle(tabIndex == 2 ? 16 : 14, color: tabIndex == 2 ? Colors.white : const Color(0xffDBDAE0))),
      ],
    );
  }
}