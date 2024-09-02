import 'package:chatbot/ui/premium_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import '../controller/in_page_ans_controller.dart';
import '../controller/membership_controller.dart';
import '../generated/assets.dart';
import '../main.dart';
import '../utils/global.dart';
import '../utils/helper.dart';
import 'homepage.dart';

class InPageAnswerPage extends StatelessWidget {
  InPageAnswerPage({Key? key}) : super(key: key);
  InPageAnsController inPageAnsController = Get.put(InPageAnsController());
  MembershipPageController membershipPageController = Get.put(MembershipPageController());
  RxInt pageIndex = 0.obs;
  late Size commonBotSize;

  Widget commonBotWid(String path) {
    return Lottie.asset(
      path,
      width: commonBotSize.width,
      height: commonBotSize.height,
      fit: BoxFit.fitHeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    commonBotSize = Size(height * 0.2, height * 0.2);
    return WillPopScope(
      onWillPop: () async {
        //SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: isDarkMode.value ? Helper.darkModeBGColor : Helper.lightModeBGColor,
        body: Stack(
          children: [

            Image.asset(Assets.imagesMainBg,
              height: height,
              width: width,
              fit: BoxFit.cover,),


            Obx(() => SizedBox(
                  width: 100.w,
                  height: 100.h,
                  child: !inPageAnsController.refreshUi.value
                      ? Stack(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 10.h,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 25),
                                    child: Row(
                                      children: [

                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [

                                              InkWell(
                                                onTap: (){
                                                  Get.back();
                                                },
                                                child: Container(
                                                  child: Icon(
                                                    Icons.arrow_back_ios,
                                                    color: whiteColor,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Expanded(
                                          flex: 8,
                                          child: InkWell(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              Get.to(() => HomePage());
                                            },
                                            child: Row(
                                              children: [
                                                Hero(
                                                  tag: "swiperAnimation",
                                                  transitionOnUserGestures: true,
                                                  child: SizedBox(
                                                    height: 6.h,
                                                    width: 6.h,
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(1, 5, 5, 5),
                                                      child: commonBotWid(currentBotAsset.value),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  currentBotName.value,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: whiteColor,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                Image.asset(
                                                  Assets.imagesNetworkIcon,
                                                  fit: BoxFit.fitHeight,
                                                  height: 18,
                                                  width: 22,
                                                  color: whiteColor,
                                                  errorBuilder: (context, error, stackTrace) => const SizedBox(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              /*InkWell(
                                                onTap: () {
                                                  Get.to(() => PremiumPage());
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 8),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Image.asset(
                                                        Assets.imagesPremiumIcon,
                                                        fit: BoxFit.cover,
                                                        height: 30,
                                                        width: 30,
                                                        errorBuilder: (context, error, stackTrace) => const SizedBox(),
                                                      ),
                                                      Text(
                                                        "Premium",
                                                        style: TextStyle(
                                                            color: textColorCode,
                                                            fontSize: 6.sp,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),*/
                                              InkWell(onTap: () {
                                                Get.to(() => PremiumPage());
                                              }, child: coinWid()),
                                              Container(
                                                child: PopupMenuButton(
                                                  color: Colors.white,
                                                  child: Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(right: 5),
                                                        child: Icon(
                                                          Icons.more_vert,
                                                          color: whiteColor,
                                                          size: 30,
                                                        ),
                                                      )),
                                                  itemBuilder: (context) {
                                                    return List.generate(1, (index) {
                                                      return PopupMenuItem(
                                                        onTap: () {
                                                          inPageAnsController.msgList.clear();
                                                        },
                                                        value: inPageAnsController.menuItem[index].id,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Icon(
                                                              inPageAnsController.menuItem[index].icon,
                                                              color: Colors.black,
                                                              size: 20,
                                                            ),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              inPageAnsController.menuItem[index].name,
                                                              style: const TextStyle(color: Colors.black),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            Positioned(
                              top: 10.h,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 100.w,
                                      height: MediaQuery.of(context).viewInsets.bottom > 0.0
                                          ? (81.h - MediaQuery.of(context).viewInsets.bottom)
                                          : 81.h,
                                      child: inPageAnsController.msgList.isNotEmpty
                                          ? ListView.builder(
                                              reverse: true,
                                              shrinkWrap: true,
                                              itemCount: inPageAnsController.msgList.length,
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  mainAxisAlignment: inPageAnsController.msgList[index].receiverId !=
                                                          inPageAnsController.myUserId
                                                      ? MainAxisAlignment.end
                                                      : MainAxisAlignment.start,
                                                  children: [
                                                    /*inPageAnsController.msgList[index].receiverId == inPageAnsController.myUserId
                                  ?Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: ClipOval(
                                  child: Image.network(
                                    inPageAnsController.girlImage,
                                    fit: BoxFit.cover,
                                    height: 5.h,
                                    width: 5.h,
                                  ),
                                ),
                              )
                                  :SizedBox(),
*/
                                                    inPageAnsController.msgList[index].messageText == "autoTyping"
                                                        ? autoTypingView(index)
                                                        : Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                constraints: BoxConstraints(
                                                                  maxWidth: 70.w,
                                                                ),
                                                                margin: const EdgeInsets.symmetric(
                                                                  vertical: 5,
                                                                  horizontal: 10,
                                                                ),
                                                                padding: const EdgeInsets.symmetric(
                                                                  horizontal: 10,
                                                                  vertical: 10,
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    color:
                                                                        inPageAnsController.msgList[index].receiverId ==
                                                                                inPageAnsController.myUserId
                                                                            ? Colors.purple.shade600
                                                                            : Colors.white,
                                                                    borderRadius: BorderRadius.circular(10),
                                                                    shape: BoxShape.rectangle,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: inPageAnsController
                                                                                    .msgList[index].receiverId ==
                                                                                inPageAnsController.myUserId
                                                                            ? const Color(0xffE4E9F6)
                                                                            : const Color(0xffE1E1E1),
                                                                        blurRadius: isDarkMode.value ? 0 : 0,
                                                                        offset: isDarkMode.value
                                                                            ? const Offset(0, 0)
                                                                            : const Offset(0, 0),
                                                                      ),
                                                                    ]),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      inPageAnsController.msgList[index].messageText,
                                                                      style: TextStyle(
                                                                        fontSize: 16,
                                                                        color: inPageAnsController
                                                                                    .msgList[index].receiverId ==
                                                                                inPageAnsController.myUserId
                                                                            ? Colors.white
                                                                            : Colors.black,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              inPageAnsController.msgList[index].receiverId ==
                                                                      inPageAnsController.myUserId
                                                                  ? Row(
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      children: [
                                                                        const SizedBox(
                                                                          width: 10,
                                                                        ),
                                                                        Text(
                                                                          DateFormat('hh:mm a').format(DateTime.parse(
                                                                              inPageAnsController.msgList[index].time
                                                                                  .toString())),
                                                                          style: TextStyle(
                                                                              color: whiteColor, fontSize: 9.sp),
                                                                        ),
                                                                        const SizedBox(
                                                                          width: 5,
                                                                        ),
                                                                        InkWell(
                                                                            onTap: () async {
                                                                              Fluttertoast.showToast(
                                                                                  msg: "Answer Copied");
                                                                              await Clipboard.setData(ClipboardData(
                                                                                  text: inPageAnsController
                                                                                      .msgList[index].messageText));
                                                                            },
                                                                            child: SizedBox(
                                                                              width: 23,
                                                                              height: 23,
                                                                              child: Icon(
                                                                                Icons.copy,
                                                                                color: whiteColor,
                                                                                size: 13,
                                                                              ),
                                                                            )),
                                                                        const SizedBox(
                                                                          width: 5,
                                                                        ),
                                                                        InkWell(
                                                                            onTap: () async {
                                                                              print(
                                                                                  'inPageAnsController.msgList[index].time ==> ${inPageAnsController.msgList[index].time}');
                                                                              Share.share(inPageAnsController
                                                                                  .msgList[index].messageText);
                                                                            },
                                                                            child: Container(
                                                                              alignment: Alignment.centerLeft,
                                                                              width: 23,
                                                                              height: 23,
                                                                              child: Icon(
                                                                                Icons.share,
                                                                                color: whiteColor,
                                                                                size: 13,
                                                                              ),
                                                                            )),
                                                                      ],
                                                                    )
                                                                  : const SizedBox(),
                                                            ],
                                                          ),

                                                    /*inPageAnsController.msgList[index].receiverId != inPageAnsController.myUserId
                                  ?Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: ClipOval(
                                  child: Image.network(
                                    "https://st.depositphotos.com/2309453/4904/i/450/depositphotos_49041215-stock-photo-vivacious-young-woman.jpg",
                                    fit: BoxFit.cover,
                                    height: 5.h,
                                    width: 5.h,
                                  ),
                                ),
                              )
                                  :
                              SizedBox(),*/
                                                  ],
                                                );
                                              })
                                          : InkWell(
                                              onTap: () {},
                                              child: Center(
                                                  child: Text(
                                                "Ask your question here",
                                                style: TextStyle(
                                                    color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 12.sp),
                                              ))),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                height: 7.7.h,
                                width: 100.w,
                                child: Column(
                                  children: [
                                    const Divider(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 86.w,
                                          child: TextFormField(
                                            style: TextStyle(color: whiteColor),
                                            controller: inPageAnsController.msgcontroller,
                                            decoration: const InputDecoration(
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.transparent),
                                                  borderRadius: BorderRadius.zero),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.transparent),
                                                  borderRadius: BorderRadius.zero),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.transparent),
                                                  borderRadius: BorderRadius.zero),
                                              hintText: "I'm ready to go!",
                                              hintStyle: TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        InkWell(
                                          onTap: () {

                                            SchedulerBinding.instance.addPostFrameCallback((_) {
                                              try {
                                                debugPrint('coins.value: ${coins.value}');
                                                if (coins.value > 0) {
                                                  if (inPageAnsController.msgcontroller.text.trim().isNotEmpty) {
                                                    inPageAnsController.sendMessage();
                                            } else {
                                              Fluttertoast.showToast(msg: "Please Enter Something");
                                            }
                                                  
                                                }else{
                                                  rewardedDialog();
                                                }
                                              } catch (e) {
                                                debugPrint('E: $e');
                                              }
                                            });

                                            
                                            
                                          },
                                          child: SizedBox(
                                            width: 10.w,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  height: 10.w,
                                                  width: 10.w,
                                                  decoration: BoxDecoration(
                                                    color: Colors.purple.shade600,
                                                    borderRadius: BorderRadius.circular(100),
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.send,
                                                  color: Colors.white,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            inPageAnsController.showBlurView.value
                                ? Container(
                                    width: 100.w,
                                    height: 100.h,
                                    color: Colors.black.withOpacity(0.8),
                                  )
                                : const SizedBox()
                          ],
                        )
                      : const SizedBox(),
                ))
          ],
        ),
      ),
    );
  }

  autoTypingView(int index) {
    return Container(
      width: 70,
      height: 37,
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      decoration: BoxDecoration(
          color: Colors.purple.shade600,
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
          ),
      child: Lottie.asset(
        Assets.imagesTyping,
        width: 60,
        height: 30,
        fit: BoxFit.contain,
      ),
    );
  }
}
