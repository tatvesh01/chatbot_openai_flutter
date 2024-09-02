import 'package:chatbot/generated/assets.dart';
import 'package:chatbot/ui/custom_drawer.dart';
import 'package:chatbot/ui/in_page_answer_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../ui/homepage.dart';
import '../../ui/premium_page.dart';
import '../../utils/global.dart';
import '../new_controller/dashboard_screen_controller.dart';
import '../new_controller/welcome_screen_controller.dart';


class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);
  DashboardScreenController dashboardScreenController = Get.put(DashboardScreenController());

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body:Stack(
        children: [
          Image.asset(Assets.imagesMainBg,
            height: height,
            width: width,
          fit: BoxFit.cover,),
          SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [

                Container(
                  height: height * 0.10,
                  width: width,
                  padding: EdgeInsets.only(bottom:  height * 0.01),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(width: width*0.2,),
                      Text("Category",style: TextStyle(color: whiteColor,fontSize: 20,fontWeight: FontWeight.bold)),
                      InkWell(onTap: () {
                        Get.to(() => PremiumPage());
                      }, child: coinWid()),
                    ],
                  ),
                ),

                Container(
                  color: Colors.white,
                height: height * 0.0,
                width: width,
                  child: Center(child: Text("AD")),
                ),


                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GridView.count(
                      physics: ScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      shrinkWrap: true,
                      children: List.generate(10, (index) {
                        return InkWell(
                          onTap: (){
                            Get.to(()=>HomePage());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: whiteColor,width: 1),
                            ),
                            child: Column(
                              children: [

                                Image.asset(
                                  dashboardScreenController.dataList[index].image,
                                  height: 100,
                                  width: 100,),

                                SizedBox(height: 20,),

                                Text("${dashboardScreenController.dataList[index].name}",style: TextStyle(color: whiteColor,fontSize: 16,fontWeight: FontWeight.w500)),

                              ],
                            ),
                          ),
                        );
                      },),
                    ),
                  ),





              ],
            ),
          ),
        ],
      ),
    );
  }
}
