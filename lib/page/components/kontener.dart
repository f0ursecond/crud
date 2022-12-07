import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class kontener extends StatelessWidget {
  const kontener({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFDF98FA),
            Color(0xFF9055FF),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
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
    );
  }
}
