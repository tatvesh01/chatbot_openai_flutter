import 'package:chatbot/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../utils/global.dart';
import 'splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  SplashScreenController bottomScreenController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          Image.asset(Assets.imagesMainBg,
            height: height,
            width: width,
            fit: BoxFit.cover,),


          Center(
            child: Container(
              height: height * 0.70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    Assets.imagesBot3,
                    height: height * 0.35,
                    fit: BoxFit.fitHeight,
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Lottie.asset(
                Assets.imagesloader3,
                height: height * 0.01,
                width:width,
              ),
            ),
          )

        ],
      ),
    );
  }
}
