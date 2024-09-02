import 'package:chatbot/generated/assets.dart';
import 'package:chatbot/ui/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/global.dart';
import '../new_controller/welcome_screen_controller.dart';


class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);
  WelcomeScreenController welcomeScreenController = Get.put(WelcomeScreenController());

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
          Column(
            children: [
              Container(

              height: height * 0.20,
              width: width,

              ),


              Container(
                height: height * 0.30,
              ),

              InkWell(
                onTap: (){
                  Get.to(()=>CustomDrawer());
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: height * 0.08,
                  width: width * 0.90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: whiteColor,width: 1),

                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        Color(0xffB721FF),
                        Color(0xff6384FE),
                        Color(0xff21D4FD),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(width: width*0.15,),
                      Lottie.asset(
                        Assets.imagesstart,
                        height: height * 0.1,
                        fit: BoxFit.fitHeight,
                      ),

                      Text("GET START",style: TextStyle(color: whiteColor,fontSize: 22,fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  InkWell(
                    onTap: () async {
                      try{
                        await launchUrl(Uri.parse(welcomeScreenController.appLink));
                      }catch(e){}
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: height * 0.07,
                      width: width * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: whiteColor,width: 1,),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            Assets.imagesstar,
                            height: height * 0.05,
                            fit: BoxFit.fitHeight,
                          ),

                          Text("Rate Us",style: TextStyle(color: whiteColor,fontSize: 15,fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: width*0.02,),

                  InkWell(
                    onTap: (){
                      Share.share('check out my app ${welcomeScreenController.appLink}');
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: height * 0.07,
                      width: width * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: whiteColor,width: 1),

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            Assets.imagesshare,
                            height: height * 0.05,
                            fit: BoxFit.fitHeight,
                          ),

                          Text("Share",style: TextStyle(color: whiteColor,fontSize: 15,fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              InkWell(
                onTap: () async {
                  try{
                    await launchUrl(Uri.parse("https://brandpointpolicy.blogspot.com/2023/02/brandpointpolicy.html"));
                  }catch(e){}
                },
                child: Container(
                  height: height * 0.07,
                  width: width * 0.45,
                child: Center(child: Text("Privacy Policy",style: TextStyle(color: whiteColor,fontSize: 15,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,)),),
                ),
              )

            ],
          ),
        ],
      ),
    );
  }
}
