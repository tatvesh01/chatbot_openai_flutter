import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../controller/history_controller.dart';
import '../utils/global.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);
  HistoryController historyController = Get.put(HistoryController());

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
        backgroundColor: Colors.red[50],
        body: Obx(
          () => historyController.isLoading.value
              ? circularIndicator(context)
              : SafeArea(
                  child: Column(
                    children: [

                      Column(
                        children: [
                          SizedBox(
                            height: 6.h,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: const Icon(
                                          Icons.arrow_back_ios_sharp,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                        width: 5.h,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: SizedBox(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Center(
                                    child: Text(
                                      "History",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                Expanded(
                                    flex: 4,
                                    child:Container()
                                ),

                              ],
                            ),
                          ),
                          const Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ],
                      ),

                      Expanded(
                        child: ListView.builder(
                          itemCount: historyController.historyList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Question : "+historyController.historyList[index].question,style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12.sp),overflow: TextOverflow.ellipsis,maxLines: 1,),
                                  SizedBox(height: 3,),
                                  Text("Answer   : "+historyController.historyList[index].answer,style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12.sp),overflow: TextOverflow.ellipsis,maxLines: 1),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )),
        ),
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
