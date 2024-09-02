import 'package:chatbot/utils/PushNotificationService.dart';
import 'package:chatbot/utils/global.dart';
import 'package:chatbot/utils/helper.dart';
import 'package:chatbot/utils/sp_helper.dart';
import 'package:event_bus/event_bus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Ads/ads_controller.dart';
import 'splash_screen/splash_screen.dart';
import 'utils/base_http_core.dart';
import 'utils/theme_manager.dart';

EventBus eventBus = EventBus();
final baseCall = BaseApiCalls();
AdsController adsController = Get.put(AdsController());
String? themeValue = "";


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");

  if(message.data.isNotEmpty){
    if(message.data["value"].toString() == "2"){

      SPHelper.setStringSP(SPHelper.notificationType, message.data["value"].toString());
      SPHelper.setStringSP(SPHelper.notificationUrl, message.data["click_value"].toString());
    }else{
      SPHelper.setStringSP(SPHelper.notificationType, "");
      SPHelper.setStringSP(SPHelper.notificationUrl, "");
    }
  }
}


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Future.delayed(Duration.zero, () async {
    await PushNotificationService().setupInteractedMessage();
  });

  Future.delayed(Duration.zero, () async {
    themeValue = await SPHelper.getStringSP(SPHelper.themeMode);
    int tempCoinsData = await SPHelper.getIntSP(SPHelper.myCoins);
    if(tempCoinsData == 50000000 ){
      coins.value = 500;
    }else{
      coins.value = tempCoinsData;
    }



    debugPrint('themeValue ==> $themeValue');
    if (themeValue != null) {
      if (themeValue == "Dark") {
        Get.changeThemeMode(ThemeMode.dark);
        isDarkMode.value = true;
        enableSwitch.value = true;
        textColorCode = Helper.white;
      } else {
        Get.changeThemeMode(ThemeMode.light);
        isDarkMode.value = false;
        enableSwitch.value = false;
        textColorCode = Helper.black;
      }
    } else {
      Get.changeThemeMode(ThemeMode.light);
      isDarkMode.value = false;
      enableSwitch.value = false;
    }
  });

  return runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => ThemeNotifier(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Consumer<ThemeNotifier>(
        builder: (_, model, __) {
          return GetMaterialApp(
            themeMode: ThemeMode.system,
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Helper.darkModeBGColor,
            ),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(brightness: Brightness.light),
            // home: SplashScreen(),
            home: SplashScreen(),
          );
        },
      );
    });
  }
}
