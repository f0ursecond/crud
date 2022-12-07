import 'package:crud/provider/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class anjayTabBar extends StatelessWidget {
  const anjayTabBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<appColor, tColor>(
      builder: (context, appColor, tColor, child) => TabBar(
          labelStyle: TextStyle(fontSize: 15.sp),
          indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 1.0),
              insets: EdgeInsets.symmetric(horizontal: 16.0)),
          labelColor: tColor.warna,
          indicatorColor: tColor.warna,
          tabs: const [
            Tab(
              text: 'Surah',
            ),
            Tab(
              text: 'Para',
            ),
            Tab(
              text: 'Page',
            ),
            Tab(
              text: 'Hijb',
            )
          ]),
    );
  }
}
