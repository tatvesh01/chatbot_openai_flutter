import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../model/history_model.dart';
import '../utils/sp_helper.dart';

class HistoryController extends GetxController {
  RxBool isLoading = false.obs;
  List<HistoryModel> historyList = [];
  @override
  void onInit() {
    super.onInit();


    getHistoryData();
  }

  void getHistoryData() async{
    isLoading(true);
    String historyStr = await SPHelper.getStringSP(SPHelper.historyData);
    if(historyStr != ""){
      historyList = HistoryModel.decode(historyStr);
    }
    isLoading(false);
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
