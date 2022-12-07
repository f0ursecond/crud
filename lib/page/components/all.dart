import 'package:crud/page/components/kontener.dart';
import 'package:crud/page/components/tabbar.dart';
import 'package:crud/page/components/tabbarview.dart';
import 'package:crud/provider/app_color.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class all extends StatelessWidget {
  const all({
    Key? key,
    required this.hasInternet,
  }) : super(key: key);

  final bool hasInternet;

  @override
  Widget build(BuildContext context) {
    return Consumer<tColor>(
      builder: (context, tColor, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                'ٱلسَّلَامُ عَلَيْكُمْ',
                style: GoogleFonts.amiri(
                  color: tColor.warna,
                  fontSize: 20,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const kontener(),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: const [
              Expanded(
                child: anjayTabBar(),
              ),
            ],
          ),
          Expanded(
            child: anjayTabBarView(hasInternet: hasInternet),
          ),
        ],
      ),
    );
  }
}
