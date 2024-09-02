import 'package:chatbot/controller/home_controller.dart';
import 'package:chatbot/main.dart';
import 'package:chatbot/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:get/get.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import '../controller/membership_controller.dart';
import '../generated/assets.dart';
import '../utils/sp_helper.dart';
import '../utils/global.dart';
import 'in_page_answer_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  HomeController homeController = Get.put(HomeController());
  MembershipPageController membershipPageController = Get.put(MembershipPageController());
  late Size commonBotSize;

  @override
  Widget build(BuildContext context) {
    commonBotSize = Size(height * 0.3, height * 0.3);
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: isDarkMode.value ? Helper.darkModeBGColor : Helper.lightModeBGColor,
        // bottomNavigationBar: bottombar(),
        body: Obx(
          () => homeController.isLoading.value
              ? circularIndicator(context)
              : SafeArea(
                  child: Stack(
                  children: [

                    Image.asset(Assets.imagesMainBg,
                      height: height,
                      width: width,
                      fit: BoxFit.cover,),


                    Center(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      color: whiteColor,
                                      size: 25,
                                    ),
                                  )),
                              InkWell(
                                onTap: () {
                                  membershipPageController.rewardedDialog(
                                    () {},
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: width * 0.03),
                                  alignment: Alignment.centerRight,
                                  child: coinWid(),
                                ),
                              ),

                              /*InkWell(
                                onTap: () {
                                  widthOfDrawer = width;
                                  homeController.openDrawer(true);
                                  homeController.isDrawerLoading(true);
                                  homeController.isDrawerLoading(false);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: width * 0.03),
                                  child: settingWid(),
                                ),
                              ),*/
                            ],
                          ),
                          const Spacer(),
                          Stack(
                            children: [
                              Hero(
                                tag: "swiperAnimation",
                                transitionOnUserGestures: true,
                                child: SizedBox(
                                  height: 30.h,
                                  width: 100.w,
                                  child: Center(child: commonBotWidss(currentBotAsset.value)),
                                ),
                              ),
                              Container(
                                height: height * 0.6,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: InkWell(
                                  onTap: () {},
                                  child: CarouselSlider.builder(
                                    itemCount: homeController.botParamsList.length,
                                    slideBuilder: (index) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: height * 0.01),
                                          commonBotWid(homeController.botParamsList[index].assetPath, index, context),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            homeController.botParamsList[index].name,
                                            style: TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            homeController.botParamsList[index].desc,
                                            style: TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "IQ : ",
                                                style: TextStyle(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 15.0, top: 10, bottom: 10),
                                                child: LinearPercentIndicator(
                                                  width: MediaQuery.of(context).size.width * 0.75,
                                                  animation: true,
                                                  lineHeight: 15.0,
                                                  animationDuration: 3000,
                                                  percent: (int.parse(homeController.botParamsList[index].iq) / 100),
                                                  center: Text(
                                                    "${homeController.botParamsList[index].iq}.0%",
                                                    style: const TextStyle(fontSize: 10, color: Colors.black),
                                                  ),
                                                  barRadius: const Radius.circular(10),
                                                  progressColor: Colors.lightGreenAccent,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "T-Consumption : ",
                                                style: TextStyle(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0),
                                                child: LinearPercentIndicator(
                                                  width: MediaQuery.of(context).size.width * 0.55,
                                                  animation: true,
                                                  lineHeight: 15.0,
                                                  animationDuration: 3000,
                                                  percent: (int.parse(homeController.botParamsList[index].iq) / 100),
                                                  center: Text(
                                                    homeController.botParamsList[index].speed,
                                                    style: const TextStyle(fontSize: 10, color: Colors.black),
                                                  ),
                                                  barRadius: const Radius.circular(10),
                                                  progressColor: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                    onSlideChanged: (indx) {
                                      if (homeController.sliderCounter.value == 3) {
                                        homeController.sliderCounter(0);
                                      } else {
                                        homeController.sliderCounter++;
                                      }
                                      /*currentBotAsset(homeController.botParamsList[homeController.sliderCounter.value].assetPath);
                                      currentBotName = homeController.botParamsList[homeController.sliderCounter.value].name.obs;*/
                                      debugPrint(
                                          'HOMECONTROLLER.SLIDERCOUNTER.VALUE: ${homeController.sliderCounter.value}');
                                    },
                                    slideTransform: const CubeTransform(),
                                    unlimitedMode: true,
                                    enableAutoSlider: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.08),
                          InkWell(
                              onTap: () {
                                currentBotAsset(
                                    homeController.botParamsList[homeController.sliderCounter.value].assetPath);
                                currentBotName =
                                    homeController.botParamsList[homeController.sliderCounter.value].name.obs;
                                SPHelper.setBoolToSP(SPHelper.isOldUser, true);
                                Get.to(()=>InPageAnswerPage());
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.purple.shade600, borderRadius: BorderRadius.circular(5)),
                                width: width * 0.7,
                                height: height * 0.055,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Use This Bot",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
                                    ),
                                    Icon(
                                      Icons.navigate_next_rounded,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              )),
                          const Spacer(),
                        ],
                      ),
                    ),
                    !homeController.isDrawerLoading.value
                        ? Stack(
                            children: [
                              homeController.openDrawer.value
                                  ? InkWell(
                                      onTap: () {
                                        widthOfDrawer = width * 0.0;
                                        homeController.openDrawer(false);
                                        homeController.isDrawerLoading(true);
                                        homeController.isDrawerLoading(false);
                                      },
                                      child: Container(
                                        height: height,
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    )
                                  : const SizedBox(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: widthOfDrawer,
                                  height: height,
                                  child: Row(
                                    children: [
                                      const Expanded(flex: 4, child: SizedBox()),
                                      Expanded(
                                        flex: 6,
                                        child: Container(
                                          height: height,
                                          color: Colors.purple.shade400,
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  widthOfDrawer = width * 0.0;
                                                  homeController.openDrawer(false);
                                                  homeController.isDrawerLoading(true);
                                                  homeController.isDrawerLoading(false);
                                                  Get.to(() => InPageAnswerPage(), arguments: [true]);
                                                },
                                                child: Row(
                                                  children: [
                                                    Text("History",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 12.sp),
                                                        overflow: TextOverflow.ellipsis),
                                                    const Spacer(),
                                                    const Icon(
                                                      Icons.navigate_next,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 1,
                                                color: Colors.white,
                                                margin: const EdgeInsets.symmetric(vertical: 10),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  widthOfDrawer = width * 0.0;
                                                  homeController.openDrawer(false);
                                                  homeController.isDrawerLoading(true);
                                                  homeController.isDrawerLoading(false);
                                                  membershipPageController.rewardedDialog(
                                                    () {},
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    Text("Remove Ads",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 12.sp),
                                                        overflow: TextOverflow.ellipsis),
                                                    const Spacer(),
                                                    const Icon(
                                                      Icons.navigate_next,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 1,
                                                color: Colors.white,
                                                margin: const EdgeInsets.symmetric(vertical: 10),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        : const SizedBox()
                  ],
                )),
        ),
      ),
    );
  }

  double widthOfDrawer = width * 0.0;

  Widget commonBotWid(String path, int index, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: homeController.botParamsList[index].bgColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 7.0,
            ),
          ]),
      child: Center(
        child: Lottie.asset(
          path,
          width: commonBotSize.width,
          height: commonBotSize.height,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget commonBotWidss(String path) {
    return Lottie.asset(
      path,
      width: commonBotSize.width,
      height: commonBotSize.height,
      fit: BoxFit.fitHeight,
    );
  }
}
