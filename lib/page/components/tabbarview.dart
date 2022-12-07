import 'package:crud/provider/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../provider/quran_provider.dart';
import '../../services/quran_service.dart';

class anjayTabBarView extends StatelessWidget {
  const anjayTabBarView({
    Key? key,
    required this.hasInternet,
  }) : super(key: key);

  final bool hasInternet;

  @override
  Widget build(BuildContext context) {
    return TabBarView(children: [
      Consumer3<QuranProvider, appColor, tColor>(
        builder: ((context, QuranProvider, appColor, tColor, child) =>
            FutureBuilder(
              future: QuranService().getAll(),
              builder: ((context, index) {
                var value = QuranProvider;
                final product = value.alquran;
                if (index.error != null && !hasInternet) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: tColor.warna,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Check Your Connection',
                            style: TextStyle(
                              color: tColor.warna,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
                if (index.connectionState == ConnectionState.waiting) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: tColor.warna,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return AnimationLimiter(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.grey[100],
                          thickness: 0.2,
                        );
                      },
                      itemCount: value.alquran.length,
                      itemBuilder: ((context, index) {
                        final asu = product[index];
                        return AnimationConfiguration.staggeredGrid(
                          duration: const Duration(milliseconds: 100),
                          columnCount: index,
                          position: index,
                          child: SlideAnimation(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.0),
                              child: FadeInAnimation(
                                child: ListTile(
                                  isThreeLine: false,
                                  onTap: () {},
                                  dense: true,
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  leading: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/leading.png'))),
                                    child: Center(
                                      child: Text(
                                        '${asu.nomor}',
                                        style: GoogleFonts.poppins(
                                          color: tColor.warna,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  trailing: Text(
                                    '${asu.nama}',
                                    style: GoogleFonts.amiri(
                                      color: tColor.warna,
                                      fontSize: 17.sp,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  title: Text(
                                    asu.nama_latin,
                                    style: GoogleFonts.poppins(
                                      color: tColor.warna,
                                      fontSize: 16.sp,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        '${asu.jumlah_ayat} AYAT ',
                                        style: GoogleFonts.poppins(
                                          color: Colors.grey,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      Text(
                                        '| ${asu.tempat_turun.toUpperCase()}',
                                        style: GoogleFonts.poppins(
                                          color: Colors.grey,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                }
              }),
            )),
      ),
      Center(
        child: Container(
          height: 20,
          width: 20,
          child: const CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
      Center(
        child: Container(
          height: 20,
          width: 20,
          child: const CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
      Center(
        child: Container(
          height: 20,
          width: 20,
          child: const CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    ]);
  }
}
