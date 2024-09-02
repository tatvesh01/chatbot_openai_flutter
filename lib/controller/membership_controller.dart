import 'dart:io';

import 'package:chatbot/utils/sp_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Api/api_call.dart';
import '../Api/api_url.dart';
import '../main.dart';
import '../model/inapp_model.dart';
import '../model/pakage_data_model.dart';
import 'package:flutter/scheduler.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';

import 'package:chatbot/utils/base_http_core.dart';
import 'package:chatbot/utils/url_helper.dart';

List<InAppData> inAppData = [];

class MembershipPageController extends GetxController {
  int inAppPurchaseItemIndex = 0;
  final InAppPurchase inAppPurchase = InAppPurchase.instance;
  List<String> productIds = [];
  double cmnBorderRadiOfMidBox = 3.h;
  List<ProductDetails> products = <ProductDetails>[];

  late StreamSubscription<List<PurchaseDetails>> _subscription;
  Rx<PakageDataModel> pakageDataModel = PakageDataModel().obs;
  // RxInt coins = 500.obs;

  @override
  void onInit() {
    super.onInit();

    /*inAppData.add(InAppData(
        id:1,
        applicationId:1,
        packageType:1,
        title:"1 week",
        key:"1week",
        price:"100",
        value:"100",
        estatus:0,
        ),
    );
    inAppData.add(InAppData(
      id:1,
      applicationId:1,
      packageType:1,
      title:"1 month",
      key:"1month",
      price:"249",
      value:"249",
      estatus:0,
    ),
    );
    inAppData.add(InAppData(
      id:1,
      applicationId:1,
      packageType:1,
      title:"3 month",
      key:"3month",
      price:"599",
      value:"599",
      estatus:0,
    ),
    );*/


    inAppData.forEach((element) {
      productIds.add(element.planId!);
    });

    final Stream<List<PurchaseDetails>> purchaseUpdated = inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      // handle error here.
    });

    initStoreInfo();


  }



  Future<void> initStoreInfo() async {
    final bool isAvailable = await inAppPurchase.isAvailable();
    if (!isAvailable) {
      products = <ProductDetails>[];
      return;
    }
    final ProductDetailsResponse productDetailResponse = await inAppPurchase.queryProductDetails(productIds.toSet());
    if (productDetailResponse.error != null) {
      products = productDetailResponse.productDetails;
      return;
    }
    products = productDetailResponse.productDetails;
    print('_productssdsds ==> ${products.length}');
  }

  Future<void> _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        Fluttertoast.showToast(msg: "Purchase Pending");
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          //Fluttertoast.showToast(msg: purchaseDetails.error.toString());
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            Fluttertoast.showToast(msg: "Purchase Done");
          } else {
            Fluttertoast.showToast(msg: "Invalid Purchase");
            return;
          }
        }
        if (Platform.isAndroid) {
          //if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
          final InAppPurchaseAndroidPlatformAddition androidAddition =
              inAppPurchase.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
          await androidAddition.consumePurchase(purchaseDetails);
          //}
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }



  void buySubscription(String? key, int index) {
    late PurchaseParam purchaseParam;
    inAppPurchaseItemIndex = index;

    int tempIndex = products.indexWhere((element) => element.id == key);
    if (tempIndex != -1) {
      debugPrint('Price: ${products[tempIndex].price}   ----    Id: ${products[tempIndex].id}');
      purchaseParam = GooglePlayPurchaseParam(productDetails: products[tempIndex], changeSubscriptionParam: null);
      inAppPurchase.buyConsumable(purchaseParam: purchaseParam, autoConsume: true);
    } else {
      Fluttertoast.showToast(msg: "Please try again");
    }
  }




  void rewardedDialog(Function() callBackWhenClose) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Get.dialog(
        AlertDialog(
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            insetPadding: const EdgeInsets.symmetric(horizontal: 10),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            content: WillPopScope(
              onWillPop: ()async{
                return false;
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: (){
                          callBackWhenClose();
                          Get.back();
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10,top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                            border: Border.all(width: 2,color: Colors.grey)
                          )
                        ,child: Icon(Icons.close,color: Colors.black,)),
                      )),
                  SizedBox(height: 0.1.h),
                  const Text(
                    "Select Plan for Remove Ads",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Container(
                    width: 100.w,
                    height: 20.h,
                    padding: const EdgeInsets.fromLTRB(5,0,5,0,),
                    child: ListView.builder(
                        itemCount: inAppData.length,
                        shrinkWrap: true,
                        scrollDirection:Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return packWid(
                            packDuration: inAppData[index].title!,
                            packPrice: "₹ ${inAppData[index].price!}",
                            packSubPrice: "₹ ${inAppData[index].price!}/${inAppData[index].title!}",
                            clickEvent: () {
                              buySubscription(inAppData[index].planId,index);
                            },
                          );
                        }),
                  ),
                  SizedBox(height: 1.5.h),
                ],
              ),
            )),
        barrierDismissible: false,
      );
    });
  }

  Widget packWid({
    required String packDuration,
    required String packPrice,
    required String packSubPrice,
    required Function() clickEvent,
  }) {
    return InkWell(
      onTap: () {
        clickEvent();
      },
      child: Container(
        height: 15.h,
        width: 28.w,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.h),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade600,
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
              height: 17.h * 0.34,
              width: 100.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 246, 246, 246),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(1.h),
                  bottomRight: Radius.circular(1.h),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    packPrice,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    packSubPrice,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
