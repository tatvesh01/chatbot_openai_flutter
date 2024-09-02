import 'package:chatbot/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'answerpage.dart';
import '../main.dart';
import '../controller/question_controller.dart';
import '../utils/global.dart';

class QuestionPage extends StatelessWidget {
  QuestionPage({Key? key}) : super(key: key);
  QuestionController queController = Get.put(QuestionController());

  RxInt pageIndex = 0.obs;
  late Size commonBotSize;

  @override
  Widget build(BuildContext context) {
    commonBotSize = Size(height * 0.2, height * 0.2);
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: isDarkMode.value ? Helper.darkModeBGColor : Helper.lightModeBGColor,
        body: Obx(
          () => queController.isLoading.value
              ? circularIndicator(context)
              : SafeArea(
                  child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        queController.showNativeAd.value ? nativeAdPart() : const SizedBox(),
                        Text(
                          "Ask Question Here",
                          style: TextStyle(color: textColorCode, fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        SizedBox(height: height * 0.02),
                        Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: isDarkMode.value ? Helper.white.withOpacity(0.5) : Helper.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(15)),
                            width: width * 0.9,
                            padding: const EdgeInsets.all(10),
                            child: cmnTextField(
                                contentPadding: EdgeInsets.zero,
                                controller: queController.queController,
                                focusNode: queController.queNode,
                                hintText: "Please Enter your Question Here...")),
                        SizedBox(height: height * 0.08),
                        InkWell(
                            onTap: () {
                              lastQuestionStr = queController.queController.text;
                              rewardedDialog();
                              /* adsController.loadShowAdsManager(dismissCallBack: () {
                                Get.to(() => AnswerPage());
                              }); */
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.purple.shade600, borderRadius: BorderRadius.circular(5)),
                              width: width * 0.7,
                              height: height * 0.055,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Get Answer",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
                                  ),
                                  Icon(Icons.navigate_next_rounded,color: Colors.white,size: 30,),

                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                )),
        ),
      ),
    );
  }

  

  nativeAdPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Container(
        height: height * 0.27,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child:  const SizedBox(),
      ),
    );
  }

  Widget cmnTextField(
      {required TextEditingController controller,
      required FocusNode focusNode,
      EdgeInsetsGeometry? contentPadding,
      List<TextInputFormatter>? inputFormatters,
      TextInputType? keyboardType,
      bool readOnly = false,
      String? hintText}) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
      cursorColor: Colors.blue.withOpacity(0.7),
      maxLines: null,
      minLines: 8,
      decoration: InputDecoration(
        isCollapsed: true,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black45, fontSize: 18, fontWeight: FontWeight.w500),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        contentPadding: contentPadding,
      ),
    );
  }

  Widget commonSpecsText(String data) {
    return Text(
      data,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18),
    );
  }

  Widget commonBotWid(String path) {
    return Lottie.asset(
      path,
      width: commonBotSize.width,
      height: commonBotSize.height,
      fit: BoxFit.fitHeight,
    );
  }
}
