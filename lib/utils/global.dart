import 'package:chatbot/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/scheduler.dart';
import '../main.dart';
import '../ui/premium_page.dart';

const APP_STORE_URL = 'https://docs.flutter.dev/';
const PLAY_STORE_URL = 'https://docs.flutter.dev/';


//RxString tokenForChatGPT = "".obs; // your token here
RxString tokenForChatGPT = "".obs;
RxBool enableService = false.obs;

String isPremiumUsers = "isPremiumUsers";
String user_id = "user_id";
String appName = "";
int versionCode = 0;
int versionCodeRemote = 0;
String appVersion = "";
String newAppUrl = "";
double height = 803.6363;
double width = 392.7272;
String lastQuestionStr = "";
String fcmToken = "";

RxInt coins = 500.obs;
RxBool isDarkMode = false.obs;
RxBool enableSwitch = false.obs;
Color textColorCode = const Color(0xff000000);
RxString currentBotAsset = Assets.imagesBot1.obs;
RxString currentBotName = "Bot1".obs;

Color whiteColor = const Color(0xffffffff);
Color blackColor = const Color(0xff000000);

Widget coinWid() {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(color: Colors.deepPurple[400], borderRadius: BorderRadius.circular(50)),
    width: width * 0.25,
    height: height * 0.043,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: height * 0.016,
          child: Image.asset(
            Assets.imagesCoin,
            fit: BoxFit.fitHeight,
            errorBuilder: (context, error, stackTrace) => const SizedBox(),
          ),
        ),
        SizedBox(width: width * 0.01),
        Obx(
          () => Text(
            coins.value.toString(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14),
          ),
        ),
      ],
    ),
  );
}

Widget settingWid() {
  return Container(
    decoration: BoxDecoration(color: Colors.deepPurple[400], borderRadius: BorderRadius.circular(100)),
    width: height * 0.05,
    height: height * 0.05,
    child: const Icon(
      Icons.settings_rounded,
      color: Colors.white,
    ),
  );
}

circularIndicator(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    // color: ColorHelper.black.withOpacity(0.5),
    child: SizedBox(
        height: 35,
        width: 35,
        child: Center(
          child: Lottie.asset(
            Assets.imagesLoader,
            width: MediaQuery.of(context).size.width * 0.20,
            height: MediaQuery.of(context).size.height * 0.15,
          ),
        )),
  );
}

void rewardedDialog() {
  SchedulerBinding.instance.addPostFrameCallback((_) {
      Get.dialog(
        AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "You Don't Have Sufficient Coins, To get Coins Click on Go to Premium Page",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18),
                ),
                SizedBox(height: height * 0.05),
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(() => PremiumPage());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.purple.shade600, borderRadius: BorderRadius.circular(50)),
                    width: width * 0.8,
                    height: 50,
                    child: const Text(
                      "Go to Premium Page",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ),
                ),
              ],
            )),
        barrierDismissible: true,
      );
  });
}

clearHistoryPopUp({void Function()? yesOnTap}) {
  Get.defaultDialog(
    actions: [
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15)),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 40,
                    width: 140,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple,
                      ),
                    ),
                    child: const Center(
                      child:
                          Text('No', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w500, fontSize: 18)),
                    ),
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(15)),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: yesOnTap,
                  child: Container(
                    height: 40,
                    width: 140,
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                    ),
                    child: const Center(
                      child: Text('Yes',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ],
    contentPadding: const EdgeInsets.all(0),
    backgroundColor: Colors.white,
    title: "Clear History",
    titlePadding: const EdgeInsets.only(top: 20, bottom: 20),
    titleStyle: const TextStyle(fontSize: 21, fontWeight: FontWeight.w700, color: Colors.black),
    middleText: "Are you sure to clear history?",
    middleTextStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
    barrierDismissible: false,
    radius: 15,
  );
}
