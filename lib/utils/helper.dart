import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/assets.dart';

class Helper {

  static Color wpColor = const Color(0xff075E54);
  static Color white = const Color(0xffFFFFFF);
  static Color black = const Color(0xff000000);
  static Color grey = const Color(0xffb2b2b2);
  static Color darkModeBGColor = const Color(0xff28282B);
  static Color lightModeBGColor = const Color(0xffffffff);

  static ThemeMode? tempMode;

  static setPermission() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('permissionGrantOrNot', true);
  }

  static Future<bool> getPermission() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('permissionGrantOrNot') ?? false;
  }

  static const btnGradient = LinearGradient(
    colors: [btnlightPinkColor, signInBtnColor],
  );
  static const Color btnlightPinkColor = Color.fromARGB(255, 249, 121, 219);
  static const Color signInBtnColor = Color(0xFF6030E8);
  /// Ad Id's

  static String interstitlaAdId = "ca-app-pub-3940256099942544/1033173712";
  static String nativeAdId = "ca-app-pub-3940256099942544/2247696110";
  static String bannerAdId = "ca-app-pub-3940256099942544/6300978111";
  static String openAdId = "ca-app-pub-3940256099942544/3419835294";
  static String rewarded = "ca-app-pub-3940256099942544/5224354917";
}
