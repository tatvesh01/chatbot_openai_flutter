import 'dart:convert';
import 'dart:math';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;
import 'package:chatbot/utils/global.dart';
import 'package:chatbot/utils/sp_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../Api/api_url.dart';
import '../model/gpt_ans_res_model.dart';
import '../model/history_model.dart';
import '../model/menu_item_model.dart';
import '../model/personal_chat_model.dart';
import '../ui/homepage.dart';

class InPageAnsController extends GetxController {
  RxBool refreshUi = false.obs;
  RxBool loadUi = false.obs;
  RxBool showBlurView = false.obs;
  int opponentUserId = 1;
  int myUserId = 2;
  String autoReplayAnswer = "";
  //bool isFromHistory = Get.arguments[0];
  bool isFromHistory = true;
  TextEditingController msgcontroller = TextEditingController();
  RxList<PersonalChat> msgList = RxList();
  RxList<MenuItemModel> menuItem = RxList();
  Rx<GptAnsResModel> gptAnsResModel = GptAnsResModel(usage: Usage()).obs;
  int autoIncrement = 0;

  @override
  Future<void> onInit() async {
    menuItem.add(MenuItemModel(id: 1, name: "Clear Chat", icon: Icons.cleaning_services_outlined));

    if (isFromHistory) {
      getHistoryData();

      /*bool premiumUser = await SPHelper.getBoolFromSP(SPHelper.isPremiumUser);
      if(!premiumUser){
        MembershipPageController membershipPageController = Get.put(MembershipPageController());
        membershipPageController.rewardedDialog(() {
          Get.back();
        },);
        showBlurView(true);
      }*/
    } /*else{
      msgList.add(PersonalChat(receiverId: opponentUserId, messageText: lastQuestionStr));
      Future.delayed(const Duration(seconds: 2), () {
        msgList.insert(0,PersonalChat(receiverId: myUserId, messageText:firstAutoReplayText ));
      });
      setDataInHistory();
    }*/

    Future.delayed(const Duration(seconds: 2), () async {
      bool isOldUser = await SPHelper.getBoolFromSP(SPHelper.isOldUser);
      if (!isOldUser) {
        Get.to(
          HomePage(),
          transition: Transition.upToDown,
          duration: const Duration(milliseconds: 1000),
        );
      }
    });

    super.onInit();
  }

  void setDataInHistory() async {
    List<HistoryModel> historyList = [];
    String historyStr = await SPHelper.getStringSP(SPHelper.historyData);
    if (historyStr != "") {
      historyList = HistoryModel.decode(historyStr);
      historyList.add(HistoryModel(question: lastQuestionStr, answer: autoReplayAnswer, time: DateTime.now()));
      String encodedData = HistoryModel.encode(historyList);
      SPHelper.setStringSP(SPHelper.historyData, encodedData);
    } else {
      historyList.add(HistoryModel(question: lastQuestionStr, answer: autoReplayAnswer, time: DateTime.now()));
      String encodedData = HistoryModel.encode(historyList);
      SPHelper.setStringSP(SPHelper.historyData, encodedData);
    }
  }

  void getHistoryData() async {
    refreshUi(true);
    String historyStr = await SPHelper.getStringSP(SPHelper.historyData);
    if (historyStr != "") {
      List<HistoryModel> historyList = HistoryModel.decode(historyStr);
      for (var element in historyList) {
        msgList.add(PersonalChat(receiverId: opponentUserId, messageText: element.question, time: element.time));
        msgList.add(PersonalChat(receiverId: myUserId, messageText: element.answer, time: element.time));
      }
      var tempMsgList = msgList.reversed.toList();
      msgList.clear();
      msgList.addAll(tempMsgList);
    }
    refreshUi(false);
  }

  clearChatData() {
    msgList.clear();
  }

  sendMessage() {

    if(!enableService.value){
      Fluttertoast.showToast(msg: "Service Under Mantainance");
      return;
    }

    autoIncrement = autoIncrement + 1;
    lastQuestionStr = msgcontroller.text;
    autoReplayAnswer = "";
    PersonalChat personalChat =
        PersonalChat(receiverId: opponentUserId, messageText: lastQuestionStr, time: DateTime.now());
    msgList.insert(0, personalChat);
    msgcontroller.clear();
    /* getAnswerChatGPTApi(lastQuestionStr); */
    Future.delayed(const Duration(seconds: 1), () {
      msgList.insert(0, PersonalChat(receiverId: myUserId, messageText: "autoTyping", time: DateTime.now()));
      Future.delayed(Duration(milliseconds: Random().nextInt(1000) + 1000), () {
        getAnswerChatGPTApi(lastQuestionStr);
        /*  msgList.removeAt(0);
        msgList.insert(0, PersonalChat(receiverId: myUserId, messageText: autoReplayAnswer, time: DateTime.now()));
        setDataInHistory(); */
      });
    });
  }

  getAnswerChatGPTApi(String prompt) async {
    //=========================================For Test Without Api==============================================

    /* gptAnsResModel.value = GptAnsResModel.fromJson(jsonDecode(jsonEncode({
      "id": "cmpl-6biNrkL5FlEhzIoGojdKPiRG6ZGN3",
      "object": "text_completion",
      "created": 1674446767,
      "model": "text-curie-001",
      "choices": [
        {
          "text":
              "\n\nNarendra Modi is an Indian politician who is the current Prime Minister of India. He has been the Chief Minister of Gujarat since 2001, and is the leader of the Bharatiya Janata Party (BJP). Modi is the first Indian Prime Minister to be elected in a nationwide election.",
          "index": 0,
          "logprobs": null,
          "finish_reason": "stop"
        }
      ],
      "usage": {"prompt_tokens": 7, "completion_tokens": 61, "total_tokens": 68}
    })));
    debugPrint('GPTANSRESMODEL.VALUE.ID: ${gptAnsResModel.value.id}');
    debugPrint('GPTANSRESMODEL.VALUE.ID: ${gptAnsResModel.value.choices[0].text}');
    if (gptAnsResModel.value.choices[0].text.isNotEmpty) {
      msgList.removeAt(0);
      msgList.insert(0,
          PersonalChat(receiverId: myUserId, messageText: gptAnsResModel.value.choices[0].text, time: DateTime.now()));
      coins.value -= gptAnsResModel.value.usage.totalTokens * 5;
      setDataInHistory();
    } else {
      msgList.removeAt(0);
      msgList.insert(0, PersonalChat(receiverId: myUserId, messageText: "No Data Found", time: DateTime.now()));
      setDataInHistory();
    } */

    //=========================================Api==============================================

    Map<String, String> header = {'Content-Type': 'application/json', 'Authorization': 'Bearer $tokenForChatGPT'};
    Map jsonBodyData = {
      "model": "text-curie-001",
      "prompt": prompt,
      "temperature": 0.7,
      "max_tokens": 256,
      "top_p": 1,
      "frequency_penalty": 0,
      "presence_penalty": 0
    };
    if (prompt.isNotEmpty) {
      try {
        var response =
            await http.post(Uri.parse(ApiUrl.getAnswerChatGPTurl), body: json.encode(jsonBodyData), headers: header);
        var jsonResponse = json.decode(response.body);
        debugPrint('getAnswerChatGPTApi JSONRESPONSE: $jsonResponse');
        if (response.statusCode == HttpStatus.ok) {
          gptAnsResModel.value = GptAnsResModel.fromJson(jsonResponse);
          debugPrint('GPTANSRESMODEL.VALUE.ID: ${gptAnsResModel.value.id}');
          debugPrint('GPTANSRESMODEL.VALUE.ID: ${gptAnsResModel.value.choices[0].text}');
          if (gptAnsResModel.value.choices[0].text.isNotEmpty) {
            msgList.removeAt(0);
            msgList.insert(
                0,
                PersonalChat(
                    receiverId: myUserId, messageText: gptAnsResModel.value.choices[0].text, time: DateTime.now()));
            autoReplayAnswer = gptAnsResModel.value.choices[0].text;
                coins.value -= gptAnsResModel.value.usage.totalTokens * 5;

                if(coins.value < 0){
                  coins.value = 0;
                }

            SPHelper.setIntSP(SPHelper.myCoins, coins.value);


            setDataInHistory();
          } else {
            msgList.removeAt(0);
            msgList.insert(0, PersonalChat(receiverId: myUserId, messageText: "No Data Found", time: DateTime.now()));
            autoReplayAnswer = "No Data Found";
            setDataInHistory();
          }
        } else {
          Fluttertoast.showToast(msg: "Something went wrong");
        }
      } catch (e) {
        msgList.removeAt(0);
        msgList.insert(
            0,
            PersonalChat(
                receiverId: myUserId,
                messageText: "Sorry for inconvenience, Couldn't get Answer Something went wrong",
                time: DateTime.now()));
        setDataInHistory();
        debugPrint('getAnswerChatGPTurl E: $e');
      }
    } else {
      Fluttertoast.showToast(msg: "Please Enter Some text");
    }
  }
}
