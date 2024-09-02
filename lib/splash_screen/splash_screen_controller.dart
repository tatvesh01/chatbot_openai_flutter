import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Ads/app_lifecycle_reactor.dart';
import '../Ads/app_open_ad_meneger.dart';
import '../controller/membership_controller.dart';
import '../model/inapp_model.dart';
import '../model/pakage_data_model.dart';
import '../new_ui/new_screen/welcome_screen.dart';
import '../ui/custom_drawer.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/sp_helper.dart';
import '../utils/storage_manager.dart';

class SplashScreenController extends GetxController {

  @override
  Future<void> onInit() async {

    String tempNotificationType = await SPHelper.getStringSP(SPHelper.notificationType,);
    if(tempNotificationType == "2"){
      String tempNotificationUrl = await SPHelper.getStringSP(SPHelper.notificationUrl,);
      await launchUrl(Uri.parse(tempNotificationUrl));
      SPHelper.setStringSP(SPHelper.notificationType, "");
      SPHelper.setStringSP(SPHelper.notificationUrl, "");
    }

    StorageManager.readData('isLightMode').then((value) {
      if (value) {
        Helper.tempMode = ThemeMode.light;
      } else {
        Helper.tempMode = ThemeMode.dark;
      }
    });

    await aaa().then((value) {
      Future.delayed(const Duration(seconds: 3), () async {
        Get.offAll(() => WelcomeScreen());
      });
    });

    super.onInit();
  }

  Future aaa() async{

    final snapshot = await FirebaseDatabase.instance.ref('users').get();

    final map = snapshot.value as Map<dynamic, dynamic>;

    map.forEach((key, value) {
      if(key == "openaikey") {
        tokenForChatGPT.value = value;
      }
      if(key == "response") {
        enableService.value = value;
      }
    });

    final snapshot1 = await FirebaseDatabase.instance.ref('plans').get();
    final map1 = snapshot1.value as Map<dynamic, dynamic>;

    map1.forEach((key, value) {
      InAppData aa = InAppData.fromJson(Map.from(value));
      inAppData.add(aa);
    });

  }

}
