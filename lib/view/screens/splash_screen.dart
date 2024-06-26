import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/view/screens/home_screen.dart';
import 'package:weather_app/view/screens/search_screen.dart';
import 'package:weather_app/view/utility/app_colors.dart';
import 'package:weather_app/view/utility/assets_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('firstTime');
    List<String>? savePlaces = prefs.getStringList('savePlaces');
    if (firstTime == false || savePlaces == null || savePlaces.isEmpty) {
      await prefs.setBool('firstTime', true);
      Get.off(() => const SearchScreen());
    } else {
      Get.off(() => HomeScreen(
            location: savePlaces[0],
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 49, 59),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          SvgPicture.asset(
            AssetsImagePath.appLogoSvg,
            height: 100,
            width: 100,
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              'Weather',
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontSize: 40,
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const Spacer(),
          Text(
            '1.0.1',
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                color: AppColors.secondaryColor,
              ),
            ),
          ),
          const SizedBox(height: 16)
        ],
      ),
    );
  }
}
