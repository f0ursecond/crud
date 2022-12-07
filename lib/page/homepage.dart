import 'package:cherry_toast/cherry_toast.dart';
import 'package:crud/page/settings.dart';

import 'package:crud/provider/quran_provider.dart';

import 'package:crud/services/quran_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../provider/app_color.dart';
import 'components/all.dart';

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
        return showTopSnackBar(
          context,
          const CustomSnackBar.error(
            message: "No Internet!",
          ),
        );
      } else {
        return showTopSnackBar(
          context,
          const CustomSnackBar.success(
            message: "Connected",
          ),
        );
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
                child: all(hasInternet: hasInternet),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ),
                );
              },
              backgroundColor: appColor.color,
              child: Icon(
                Icons.settings,
                color: tColor.warna,
              ),
            ),
          )),
    );
  }
}
