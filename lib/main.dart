import 'package:crud/page/loginpage.dart';
import 'package:crud/provider/app_color.dart';

import 'package:crud/provider/quran_provider.dart';

import 'package:crud/provider/uiset.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('shopping_box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => appColor()),
        ChangeNotifierProvider(create: (context) => tColor()),
        ChangeNotifierProvider(create: (context) => QuranProvider()),
        ChangeNotifierProvider(create: (context) => anjaySize()),
      ],
      child: ResponsiveSizer(
        builder: (p0, p1, p2) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const loginPage(),
            theme: ThemeData.from(
              colorScheme: const ColorScheme.light(),
            )),
      ),
    );
  }
}
