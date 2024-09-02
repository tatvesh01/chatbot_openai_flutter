import 'dart:io';
import 'dart:math' as math;
import 'package:chatbot/controller/in_page_ans_controller.dart';
import 'package:chatbot/generated/assets.dart';
import 'package:chatbot/ui/premium_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../new_ui/new_screen/dashboard_screen.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import '../utils/sp_helper.dart';
import 'in_page_answer_page.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawerState? of(BuildContext context) => context.findAncestorStateOfType<CustomDrawerState>();

  @override
  CustomDrawerState createState() => CustomDrawerState();
}

class CustomDrawerState extends State<CustomDrawer> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool _canBeDragged = false;
  final double maxSlide = 300.0;

  @override
  void initState() {
    super.initState();
    if (newAppUrl.isNotEmpty) {
      newAppDialog();
    }
    versionCheck(context);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void toggle() => animationController.isDismissed ? animationController.forward() : animationController.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      behavior: HitTestBehavior.translucent,
      /* onTap: toggle, */
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          return Material(
            color: Colors.blueGrey,
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(maxSlide * (animationController.value - 1), 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(math.pi / 2 * (1 - animationController.value)),
                    alignment: Alignment.centerRight,
                    child: MyDrawer(animationController),
                  ),
                ),
                Transform.translate(
                  offset: Offset(maxSlide * animationController.value, 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-math.pi * animationController.value / 2),
                    alignment: Alignment.centerLeft,
                    child: DashboardScreen(),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top,
                  left: 4.0 + animationController.value * maxSlide,
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: whiteColor,
                      size: 32,
                    ),
                    onPressed: toggle,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed;
    bool isDragCloseFromRight = animationController.isCompleted;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / maxSlide;
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    //I have no idea what it means, copied from Drawer
    double kMinFlingVelocity = 365.0;

    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx / MediaQuery.of(context).size.width;

      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  void newAppDialog() async {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Get.dialog(
        AlertDialog(
            contentPadding: EdgeInsets.zero,
            insetPadding: const EdgeInsets.symmetric(horizontal: 10),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            content: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                      width: width * 0.9,
                      padding: const EdgeInsets.all(10),
                      constraints: BoxConstraints(
                        maxWidth: width * 0.9,
                        minHeight: height * 0.2,
                      ),
                      child: Column(
                        children: [
                          const Text(
                              "Unfortunately,You Can't Use this app Because. This App is Move Please visit the Link Below"),
                          const SizedBox(height: 15),
                          InkWell(
                            onTap: () {
                              _launchUrl(newAppUrl);
                            },
                            child: const SizedBox(
                              height: 18,
                              child: Text(
                                "https://docs.flutter.dev/",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            )),
        barrierDismissible: false,
      );
    });
  }

  versionCheck(context) async {
    /* double currentVersion = double.parse(appVersion.trim().replaceAll(".", ""));

    String remoteVersionString = await SPHelper.getStringSP(SPHelper.appVersion);

    double remoteVersion = double.parse(remoteVersionString.trim().replaceAll(".", "")); */
    try {
      if (versionCodeRemote > versionCode) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _showVersionDialog(context);
        });
      }
    } catch (exception) {
      debugPrint('versionCheck EXCEPTION: $exception');
    }
  }

  _showVersionDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "New Update Available";
        String message = "There is a newer version of app available please update it now.";
        String btnLabel = "Update Now";
        String btnLabelCancel = "Later";
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  TextButton(
                    child: Text(btnLabel),
                    onPressed: () => _launchUrl(APP_STORE_URL),
                  ),
                  TextButton(
                    child: Text(btnLabelCancel),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              )
            : AlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  TextButton(
                    child: Text(btnLabel),
                    onPressed: () => _launchUrl(PLAY_STORE_URL),
                  ),
                  TextButton(
                    child: Text(btnLabelCancel),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
      },
    );
  }

  /* void updateDialog() {
    Get.dialog(
      AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          content: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    width: width * 0.9,
                    padding: const EdgeInsets.all(10),
                    constraints: BoxConstraints(
                      maxWidth: width * 0.9,
                      minHeight: height * 0.2,
                    ),
                    child: Column(
                      children: [
                        const Text(
                            "Unfortunately,You Can't Use this app Because. This App is Move Please visit the Link Below"),
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () {
                            _launchUrl("https://docs.flutter.dev/");
                          },
                          child: const SizedBox(
                            height: 18,
                            child: Text(
                              "https://docs.flutter.dev/",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          )),
      barrierDismissible: false,
    );
  } */
}

class MyDrawer extends StatelessWidget {
  AnimationController animationController;
  MyDrawer(this.animationController);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
            right: BorderSide(
          color: Colors.grey,
          width: 2,
        )),
        boxShadow: [
          BoxShadow(blurRadius: 8.0),
          BoxShadow(color: Colors.white, offset: Offset(0, -16)),
          BoxShadow(color: Colors.white, offset: Offset(0, 16)),
          BoxShadow(color: Colors.white, offset: Offset(-16, -16)),
          BoxShadow(color: Colors.white, offset: Offset(-16, 16)),
        ],
      ),
      width: 300,
      height: double.infinity,
      child: Material(
        color: Colors.white,
        child: SafeArea(
          child: Theme(
            data: ThemeData(brightness: Brightness.dark),
            child: Column(
              children: [
                Image.asset(
                  Assets.imagesPremiumIcon,
                  height: height * 0.10,
                  fit: BoxFit.fitHeight,
                ),
                Text(
                  appName,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  appVersion,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 25),
                /*ListTile(
                  onTap: ()  {
                    animationController.reverse().then((value) async{
                      await adsController.loadShowAdsManager(dismissCallBack: () {
                        Get.to(() => InPageAnswerPage(),arguments: [true]);
                      });
                    });
                  },
                  leading: Icon(Icons.history),
                  title: Text('History'),
                ),*/

                Obx(
                  () => ListTile(
                    onTap: () {
                      animationController.reverse().then((value) {
                        toggleDarkMode();
                      });
                    },
                    leading: Icon(
                      isDarkMode.value ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Change Theme',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    trailing: CupertinoSwitch(
                        // overrides the default green color of the track
                        // activeColor: Colors.white,
                        // color of the round icon, which moves from right to left
                        // thumbColor: Colors.black,
                        // when the switch is off
                        // trackColor: Colors.black12,
                        // boolean variable value
                        value: isDarkMode.value,
                        // changes the state of the switch
                        onChanged: (value) {
                          animationController.reverse().then((value) {
                            toggleDarkMode();
                          });
                        }),
                  ),
                ),
                ListTile(
                  onTap: () {
                    animationController.reverse().then((value) async {
                      /*MembershipPageController membershipPageController = Get.put(MembershipPageController());
                      membershipPageController.rewardedDialog(() {
                      },);*/
                      Get.to(() => PremiumPage());
                    });
                  },
                  leading: const Icon(
                    Icons.add_to_home_screen,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Remove Ads',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
                ListTile(
                  onTap: () {
                    animationController.reverse().then((value) {
                      clearHistoryPopUp(yesOnTap: () {
                        SPHelper.setStringSP(SPHelper.historyData, "");
                        Fluttertoast.showToast(msg: "History Removed Successfully");
                        Get.back();
                        InPageAnsController inPageAnsController = Get.find();
                        inPageAnsController.clearChatData();
                      });
                    });
                  },
                  leading: const Icon(
                    Icons.history,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Clear History',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),

                ListTile(
                  onTap: () {
                    animationController.reverse().then((value) async {

                      try{
                        await launchUrl(Uri.parse("https://brandpointpolicy.blogspot.com/2023/02/brandpointpolicy.html"));
                      }catch(e){}

                    });
                  },
                  leading: const Icon(
                    Icons.policy_rounded,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Privacy Policy',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  toggleDarkMode() async {
    isDarkMode.value = !isDarkMode.value;
    if (isDarkMode.value) {
      debugPrint('isDarkMode.value ==> ${isDarkMode.value}');
      SPHelper.setStringSP(SPHelper.themeMode, "Dark");
      textColorCode = Helper.white;
    } else {
      debugPrint('isDarkMode.value ==> ${isDarkMode.value}');
      SPHelper.setStringSP(SPHelper.themeMode, "Light");
      textColorCode = Helper.black;
    }
  }
}
