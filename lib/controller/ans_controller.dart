import 'package:chatbot/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/history_model.dart';
import '../utils/sp_helper.dart';

class AnsController extends GetxController {
  RxBool isLoading = false.obs;

  FocusNode queNode = FocusNode();
  RxString answer =
      """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"""
          .obs;

  @override
  void onInit() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      try {
        if (coins.value > 0 && !(coins.value -= 10).isNegative) {
          coins.value -= 10;
        }
      } catch (e) {
        debugPrint('E: $e');
      }
    });

    setDataInHistory();
    super.onInit();
  }

  void setDataInHistory() async{
    List<HistoryModel> historyList = [];
    String historyStr = await SPHelper.getStringSP(SPHelper.historyData);
    if(historyStr != ""){
      historyList = HistoryModel.decode(historyStr);
      historyList.add(HistoryModel(question: lastQuestionStr,answer: answer.value,time: DateTime.now()));
      String encodedData = HistoryModel.encode(historyList);
      SPHelper.setStringSP(SPHelper.historyData, encodedData);
    }else{
      historyList.add(HistoryModel(question: lastQuestionStr,answer: answer.value,time: DateTime.now()));
      String encodedData = HistoryModel.encode(historyList);
      SPHelper.setStringSP(SPHelper.historyData, encodedData);
    }

  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
