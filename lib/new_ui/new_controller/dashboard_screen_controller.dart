import 'package:chatbot/generated/assets.dart';
import 'package:get/get.dart';

import '../../model/dashboard_model.dart';


class DashboardScreenController extends GetxController {

  List<DashBoardModel> dataList = [
    DashBoardModel("Ai", Assets.imagesai),
    DashBoardModel("Technology", Assets.imagestechnology),
    DashBoardModel("Computer", Assets.imagescomputer),
    DashBoardModel("Film", Assets.imagesfilm),
    DashBoardModel("Financial", Assets.imagesfinancial),
    DashBoardModel("Holly Wood", Assets.imagesholly),
    DashBoardModel("General", Assets.imagesgeneral),
    DashBoardModel("Calculator", Assets.imagescalculator),
    DashBoardModel("Music", Assets.imagesmusic),
    DashBoardModel("Sales", Assets.imagessales),
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
  }


}
