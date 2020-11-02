import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:migo/common/textstyle/textstyle.dart';
import 'package:flutter/material.dart';

class HomeHeadView extends StatefulWidget {
  @override
  _HomeHeadViewState createState() => _HomeHeadViewState();
}

class _HomeHeadViewState extends State<HomeHeadView> {
  List<String> banners = [
    "as",
    "bb",
    "cc"
  ];
  int bannerIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SafeArea(child: Image.asset("assets/logo.png", height: 18,))
        ),
        Container(
          height: 130,
          margin: const EdgeInsets.only(left: 16, right: 16, top: 14, bottom: 10),
          child: HomeBannerView(banners: banners, onChanged: (sender) {
            setState(() {
              bannerIndex = sender;
            });
          },),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: banners.map((e) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Image.asset("assets/${bannerIndex == banners.indexOf(e) ? "point" : "point_not"}.png"),
          )).toList(),
        )
      ],
    );
  }
}

class HomeBannerView extends StatelessWidget {
  final List<String> banners;
  final Function(int index) onChanged;
  HomeBannerView({Key key, this.banners, this.onChanged}) : super(key: key);

  final dot = DotSwiperPaginationBuilder(
    activeColor: AppColor.blue,
    color: Colors.white,
    size: 7,
    activeSize: 7,
    space: 4,
  );

  // static const List<String> images = ["banner", "banner1", "banner2"];
  @override
  Widget build(BuildContext context) {
    if(banners.length == 0) return Container();
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/banner_back.png"),
              fit: BoxFit.fill
            )
          ),
          padding: const EdgeInsets.all(5),
          child: PhysicalModel(
            clipBehavior: Clip.antiAlias,
            color: Colors.black,
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              // imageUrl: banners[index].url,
              imageUrl: banners[index],
              fit: BoxFit.fill,
            ),
            // child: Image.asset("assets/${images[index]}.png", fit: BoxFit.fill,),
          ),
        );
      },
      onIndexChanged: this.onChanged,
      autoplay: true,
      loop: true,
      // itemCount: images.length,
      itemCount: banners.length,
      // viewportFraction: 0.8,
      // scale: 0.85,
      // pagination: SwiperPagination(builder: rect),
      // pagination: SwiperPagination(),
      // control: SwiperControl(),// 左右两个箭头
    );
  }
}

