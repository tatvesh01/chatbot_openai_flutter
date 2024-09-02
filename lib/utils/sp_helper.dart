import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  //saved data key list
  static String userId = "user_id";
  static String bannerId1 = "banner_id1";
  static String interstitialId1 = "interstitial_id1";
  static String rewardedAdId1 = "rewarded_id1";
  static String rewardedAdId2 = "rewarded_id2";
  static String nativeId1 = "native_id1";
  static String appOpenId1 = "appOpen_id1";
  static String bannerId2 = "banner_id2";
  static String interstitialId2 = "interstitial_id2";
  static String nativeId2 = "native_id2";
  static String appOpenId2 = "appOpen_id2";
  static String clickEvent = "click_event";
  static String splashAppOpenCounter = "splashAppOpenCounter";
  static String setCountry = "setCountry";
  static String isCheck = "isCheck";
  static String isPremiumUser = "isPremiumUser";
  static String historyData = "historyData";
  static String themeMode = "ThemeMode";
  static String isOldUser = "isOldUser";
  static String appUrl = "app_url";
  static String appVersion = "app_version";


  static String notificationType = "notificationType";
  static String notificationUrl = "notificationUrl";
  static String myCoins = "myCoins";

  static setStringSP(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static setBoolToSP(String spName, bool spValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(spName, spValue);
  }

  static removeUserData(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }

  static getBoolFromSP(String spName) async {
    final prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool(spName) ?? false;
    return value;
  }

  static Future<String> getStringSP(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static setIntSP(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static Future<int> getIntSP(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 50000000;
  }
}
