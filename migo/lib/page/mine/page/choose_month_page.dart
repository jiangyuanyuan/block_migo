import 'package:flutter/material.dart';
import 'package:migo/common/commview/commback_view.dart';
import 'package:migo/common/textstyle/textstyle.dart';

class ChooseMonthPage extends StatelessWidget {
  final Map params;
  const ChooseMonthPage({Key key, this.params}) : super(key: key);

  List<Widget> _create(BuildContext context) {
    int year = DateTime.now().year;
    return List.generate(10, (index) => _Cell(
      year: year - index,
      onselect: (y, m) {
        Navigator.pop(context, {"year":y, "month":m + 1});
      },
      selectyear: params["year"] ?? 0,
      month: params["month"] ?? 0,
    )).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommbackView(
        titles: "选择时间",
        onPop: () => Navigator.pop(context),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(8))
          ),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: _create(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  final int year;
  final int month;
  final int selectyear;
  final Function(int year, int month) onselect;
  const _Cell({Key key, this.year, this.selectyear, this.onselect, this.month}) : super(key: key);

  bool isselect(int sender) => (selectyear == year && month == (sender + 1));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 36, height: 1, color: const Color(0xffEFF4F8),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("$year年", style: AppFont.textStyle(12, color: AppColor.back998),),
            ),
            Container(width: 36, height: 1, color: const Color(0xffEFF4F8),),
          ],
        ),
        SizedBox(height: 30,),
        SizedBox(
          height: 150,
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 20,
              crossAxisSpacing: 40,
              childAspectRatio: 1.2
            ), 
            itemCount: 12,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if(onselect != null)onselect(year, index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isselect(index) ? AppColor.back998 : Colors.white,
                    border: Border.all(width: 1, color: const Color(0xffEFF4F8)),
                    borderRadius: BorderRadius.circular(4)
                  ),
                  alignment: Alignment.center,
                  child: Text("${index + 1}月",style: AppFont.textStyle(14, color: isselect(index) ? Colors.white : AppColor.back998),),
                ),
              );
            }
          )
        )
      ],
    );
  }
}