import 'package:flutter/material.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:migo/common/util/custon_indicator.dart';
import 'package:migo/generated/i18n.dart';

class MineTeamTabarView extends StatefulWidget {
  final Function(int sender) onTabIndex;
  final List<String> titles;
  final bool isscrolll;
  const MineTeamTabarView({Key key, this.isscrolll = false, this.onTabIndex, this.titles}) : super(key: key);
  @override
  _MineTeamTabarViewState createState() => _MineTeamTabarViewState();
}

class _MineTeamTabarViewState extends State<MineTeamTabarView> with SingleTickerProviderStateMixin {
  
  TabController _tabController;
  int tabIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.titles.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        tabIndex = _tabController.index;
      });
      if(widget.onTabIndex != null) {
        widget.onTabIndex(tabIndex);
      }
    });
  }

  List<Widget> _create() {
    return widget.titles.map((e) => Text(e, style: AppFont.textStyle(tabIndex == widget.titles.indexOf(e) ? 16 : 14, color: tabIndex == widget.titles.indexOf(e) ? Colors.white : const Color(0xffDBDAE0)),),).toList();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TabBar(
        isScrollable: widget.isscrolll,
        controller: _tabController,
        indicator: RoundUnderlineTabIndicator(
          borderSide: BorderSide(
           width: 3.5,
           color: Color(0xff00cdd7),
          )
        ),
        tabs: _create(),
      ),
    );
  }
}