import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:sizer/sizer.dart';

import '../controller/membership_controller.dart';
import '../controller/premium_page_controller.dart';
import '../utils/global.dart';
import '../utils/helper.dart';

class PremiumPage extends StatelessWidget {
  PremiumPage({Key? key}) : super(key: key);
  PremiumPageController premiumPageController = Get.put(PremiumPageController());
  double profilePicAlingFromTop = 18.h;
  double profilePicAlingFromLeft = 7.w;
  double profilePicRadius = 23.w;
  double cmnOPTSpacingV = 4.h;
  double cmnBorderRadiOfMidBox = 4.h;

  @override
  Widget build(BuildContext context) {
    cmnBorderRadiOfMidBox = 3.w;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color:Helper.lightModeBGColor,
            width: 100.w,
            height: 100.h,
          ),
          mainFullScreenContainer(),
          /*InkWell(
            onTap: (){
              Get.back();
            },
            child: Container(
              margin: EdgeInsets.only(left: 15,top: 35),
              height: 3.5.h,
              width: 3.5.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: textColorCode,width: 1.5)
              ),
              child: Center(child: Icon(Icons.close,color:textColorCode)),
            ),
          )*/
        ],
      ),
    );
  }

  Widget mainFullScreenContainer() {
    return Container(
      height: 100.h,
      width: 100.w,
      child: mainColumnWidget(),
    );
  }

  Widget mainColumnWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 40.h,
          child: Stack(
            children: [
              CarouselSlider(
                options: CarouselOptions(height: 40.h,
                  viewportFraction: 1,
                    onPageChanged: (int pageNumber, CarouselPageChangedReason reason){
                      premiumPageController.sliderIndex = pageNumber.obs + 1;
                      print('pageNumber ==> ${pageNumber}');
                      premiumPageController.reloadIndicator(true);
                      premiumPageController.reloadIndicator(false);
                    }
                ),
                items: premiumPageController.sliderData.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          //decoration: const BoxDecoration(gradient: ColorHelper.membershipGradient2),
                          child: Stack(
                            children: [
                              Image.asset(i.image,height: 40.h,width: 100.w,fit: BoxFit.cover,),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      i.title1,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                       textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 1.h),
                                      Text(
                                        i.title2,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                        textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                      );
                    },
                  );
                }).toList(),
              ),

              Obx(() =>
                  !premiumPageController.reloadIndicator.value
                      ?Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: premiumPageController.sliderData.map((entry) {
                  return GestureDetector(
                    child: Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Colors.white).withOpacity(premiumPageController.sliderIndex.value == entry.id ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
                      ):SizedBox(),
              ),

            ],
          ),
        ),

        SizedBox(height: 10.h),
        Obx(()=>
           Row(
            children: [
              const SizedBox(width: 4),
              packWid(
                packDuration: "${inAppData[0].title}",
                packPrice: "₹ ${inAppData[0].price}",
                packSubPrice: "₹ ${inAppData[0].price}/${inAppData[0].title}",
                index:0,
                clickEvent: () {
                  premiumPageController.inAppPurchaseItemIndex.value = 0;
              },
              ),
              const SizedBox(width: 4),
              packWid(
                packDuration: "${inAppData[1].title}",
                packPrice: "₹ ${inAppData[1].price}",
                packSubPrice: "₹ ${inAppData[1].price}/${inAppData[1].title}",
                index:1,
                clickEvent: () {
                  premiumPageController.inAppPurchaseItemIndex.value = 1;
                },
              ),
              const SizedBox(width: 4),
              packWid(
                packDuration: "${inAppData[2].title}",
                packPrice: "₹ ${inAppData[2].price}",
                packSubPrice: "₹ ${inAppData[2].price}/${inAppData[2].title}",
                index:2,
                clickEvent: () {
                  premiumPageController.inAppPurchaseItemIndex.value = 2;
                },
              ),
              const SizedBox(width: 4),
            ],
          ),
        ),
        SizedBox(height: 1.5.h),
        const Text(
          "Auto-renewable subscription",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.purple,
          ),
        ),
        SizedBox(height: 2.7.h),
        continueBtn(),
        SizedBox(height: 3.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: const Text(
            """Auto-renewable subscriptions will be automatically renewed within 24 hours prior to the end of the current subscription period. You may disable the auto-renewal at any time in Google Play account settings after purchase. For more information, please refer to our Terms of Service""",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget packWid({
    required String packDuration,
    required String packPrice,
    required String packSubPrice,
    required int index,
    required Function() clickEvent,
  }) {
    return Expanded(
      child: InkWell(
        onTap: (){
          clickEvent();
        },
        child: Container(
          height: 19.h,
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cmnBorderRadiOfMidBox),
            border: Border.all(color: index == premiumPageController.inAppPurchaseItemIndex.value ? Colors.purple : Colors.transparent,width: 2),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 2.0,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    packDuration,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                height: 17.h * 0.40,
                width: 100.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  //color: const Color.fromARGB(255, 246, 246, 246),
                  color: index == premiumPageController.inAppPurchaseItemIndex.value ? Colors.purple : Color.fromARGB(255, 246, 246, 246),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      packPrice,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: index == premiumPageController.inAppPurchaseItemIndex.value ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      packSubPrice,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: index == premiumPageController.inAppPurchaseItemIndex.value ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget continueBtn() {
    return InkWell(
      onTap: () {
        if(premiumPageController.inAppPurchaseItemIndex.value == 50000){
          Fluttertoast.showToast(msg: "Please select plan first");
        }else{
          buySubscription(inAppData[premiumPageController.inAppPurchaseItemIndex.value].planId);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        alignment: Alignment.center,
        height: 7.h,
        width: 80.w,
        decoration: BoxDecoration(
          gradient: Helper.btnGradient,
          borderRadius: BorderRadius.circular(10.h),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 2.0,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: const Text(
          "CONTINUE",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }


  void buySubscription(String? key) {
    late PurchaseParam purchaseParam;
    int tempIndex = premiumPageController.products.indexWhere((element) => element.id == key);
    if(tempIndex != -1){
      debugPrint('Price: ${premiumPageController.products[tempIndex].price}   ----    Id: ${premiumPageController.products[tempIndex].id}');
      purchaseParam = GooglePlayPurchaseParam(productDetails: premiumPageController.products[tempIndex], changeSubscriptionParam: null);
      premiumPageController.inAppPurchase.buyConsumable(purchaseParam: purchaseParam, autoConsume: true);
    } else{
      Fluttertoast.showToast(msg: "Please try again");
    }
  }


}
