import 'package:chatbot/generated/assets.dart';
import 'package:chatbot/model/bot_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isDrawerLoading = false.obs;
  RxBool openDrawer = false.obs;
  final scrollDirection = Axis.vertical;
  RxInt sliderCounter = 0.obs;


  RxList<BotParamsModel> botParamsList = [
    BotParamsModel(name: "Ruin", iq: "67", speed: "823ms", assetPath: Assets.imagesBot3, bgColor: Colors.yellow,desc: "Ruin bot is very power full, its very smart and clever."),
    BotParamsModel(name: "Sputnik", iq: "54", speed: "600ms", assetPath: Assets.imagesBot4, bgColor: Colors.pink.shade400,desc: "Sputnik bot is very power full, its very smart and clever."),
    BotParamsModel(name: "Bruno", iq: "78", speed: "400ms", assetPath: Assets.imagesBot2, bgColor: Colors.deepPurple.shade300,desc: "Bruno bot is very power full, its very smart and clever."),
    BotParamsModel(name: "Scrap", iq: "94", speed: "525ms", assetPath: Assets.imagesBot1, bgColor: Colors.blue.shade400,desc: "Scrap bot is very power full, its very smart and clever."),
  ].obs;

}
