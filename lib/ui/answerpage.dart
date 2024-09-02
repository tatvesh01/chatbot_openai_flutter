import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controller/ans_controller.dart';
import '../controller/home_controller.dart';
import '../main.dart';
import '../utils/global.dart';
import '../utils/helper.dart';

class AnswerPage extends StatelessWidget {
  AnswerPage({Key? key}) : super(key: key);
  AnsController ansController = Get.put(AnsController());
  HomeController homeController = Get.find();
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
          () => ansController.isLoading.value
              ? circularIndicator(context)
              : SafeArea(
                  child: SingleChildScrollView(
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: width * 0.05),
                          alignment: Alignment.centerRight,
                          child: coinWid(),
                        ),
                        SizedBox(height: height * 0.02),
                        commonBotWid(currentBotAsset.value),
                         Text(
                          "Answer",
                          style: TextStyle(
                            color: textColorCode,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Container(
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                              color: isDarkMode.value ? Helper.white.withOpacity(0.5) : Helper.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15)),
                          width: width * 0.9,
                          padding: const EdgeInsets.all(10),
                          constraints: BoxConstraints(
                            maxWidth: width * 0.9,
                            minHeight: height * 0.5,
                          ),
                          child: Stack(
                            children: [
                              DefaultTextStyle(
                                style: const TextStyle(fontSize: 17.0, color: Colors.black),
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    TypewriterAnimatedText(ansController.answer.value,
                                        speed: const Duration(milliseconds: 150)),
                                  ],
                                  onTap: () {
                                    print("Tap Event");
                                  },
                                ),
                              ),

                              Container(
                                width: width * 0.9,
                                height: height * 0.5,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                    child: InkWell(
                                      onTap: () async{
                                        Fluttertoast.showToast(msg: "Answer Copied");
                                        await Clipboard.setData(ClipboardData(text: ansController.answer.value));
                                      },
                                        child: Icon(Icons.copy,color: Colors.black,))),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () async {
                            Get.back();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Colors.purple.shade600, borderRadius: BorderRadius.circular(5)),
                            width: width * 0.7,
                            height: height * 0.055,
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.navigate_before_rounded,color: Colors.white,size: 30,),

                                Text(
                                  "Back",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                )),
        ),
      ),
    );
  }

  Widget cmnTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    EdgeInsetsGeometry? contentPadding,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    bool readOnly = false,
  }) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
      cursorColor: Colors.blue.withOpacity(0.7),
      maxLines: 15,
      decoration: InputDecoration(
        isCollapsed: true,
        // hintText: value,
        // hintStyle: const TextStyle(
        //   color: ColorHelper.white,
        //   fontSize: 11,
        //   fontWeight: FontWeight.bold,
        // ),
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
