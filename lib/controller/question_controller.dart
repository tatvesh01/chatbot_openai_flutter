import 'package:chatbot/utils/sp_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class QuestionController extends GetxController {
  RxBool isLoading = false.obs;
  final scrollDirection = Axis.vertical;
  RxInt sliderCounter = 0.obs;
  RxBool showNativeAd = false.obs;
  TextEditingController queController = TextEditingController();
  FocusNode queNode = FocusNode();
  
  @override
  void onInit() {

    super.onInit();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
