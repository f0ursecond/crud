import 'package:cherry_toast/cherry_toast.dart';

import 'package:crud/provider/quran_provider.dart';

import 'package:crud/services/quran_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../provider/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hasInternet = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<QuranProvider>(context, listen: false).getAllQuran();
    });

    super.initState();
    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() => this.hasInternet = hasInternet);
      if (!hasInternet) {
        return CherryToast.error(
          title: const Text(
            'No Internet Connection',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          action: const Text(
            'Please Try Again Later',
            style: TextStyle(color: Colors.black),
          ),
          actionHandler: () {},
        ).show(context);
      } else {
        return CherryToast.success(
          title: const Text('  Connected'),
          action: const Text('/merasa senang'),
          actionHandler: () {},
        ).show(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<appColor, tColor>(
      builder: ((context, appColor, tColor, _) => Scaffold(
            backgroundColor: appColor.color,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                'Al Quran App',
                style: GoogleFonts.karla(color: tColor.warna),
              ),
            ),
            body: DefaultTabController(
              length: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
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
                    Container(
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFDF98FA),
                              Color(0xFF9055FF),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      height: 131,
                      width: 326,
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/kitab.png',
                            fit: BoxFit.contain,
                            width: 50.sp,
                            height: 40.sp,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TabBar(
                              labelStyle: TextStyle(fontSize: 15.sp),
                              indicator: UnderlineTabIndicator(
                                  borderSide: BorderSide(width: 1.0),
                                  insets:
                                      EdgeInsets.symmetric(horizontal: 16.0)),
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
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        Consumer<QuranProvider>(
                          builder: ((context, QuranProvider, child) =>
                              FutureBuilder(
                                future: QuranService().getAll(),
                                builder: ((context, index) {
                                  var value = QuranProvider;
                                  final product = value.alquran;
                                  if (index.error != null && !hasInternet) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                              'Check Your Connection & Try Again',
                                              style: TextStyle(
                                                color: tColor.warna,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }
                                  if (index.connectionState ==
                                      ConnectionState.waiting) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                    print('AKHIRNYA BISA COKK');

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
                                          return AnimationConfiguration
                                              .staggeredGrid(
                                            duration: const Duration(
                                                milliseconds: 100),
                                            columnCount: index,
                                            position: index,
                                            child: SlideAnimation(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 3.0),
                                                child: FadeInAnimation(
                                                  child: ListTile(
                                                    isThreeLine: false,
                                                    onTap: () {},
                                                    dense: true,
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 5),
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
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: tColor
                                                                      .warna,
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                      ),
                                                    ),
                                                    trailing: Text(
                                                      '${asu.nama}',
                                                      style: GoogleFonts.amiri(
                                                        color: tColor.warna,
                                                        fontSize: 17.sp,
                                                        letterSpacing: 0.5,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    title: Text(
                                                      asu.nama_latin,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: tColor.warna,
                                                        fontSize: 16.sp,
                                                        letterSpacing: 0.5,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    subtitle: Row(
                                                      children: [
                                                        Text(
                                                          '${asu.jumlah_ayat} AYAT ',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: Colors.grey,
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        ),
                                                        Text(
                                                          '| ${asu.tempat_turun.toUpperCase()}',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: Colors.grey,
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
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
                              child: CircularProgressIndicator(
                                color: tColor.warna,
                              )),
                        ),
                        Center(
                          child: Container(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: tColor.warna,
                              )),
                        ),
                        Center(
                          child: Container(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: tColor.warna,
                              )),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
