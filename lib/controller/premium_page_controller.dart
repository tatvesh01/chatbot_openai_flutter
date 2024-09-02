import 'dart:async';
import 'dart:io';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import '../Api/api_call.dart';
import '../Api/api_url.dart';
import '../generated/assets.dart';
import '../main.dart';
import '../model/membership_model.dart';
import '../utils/base_http_core.dart';
import '../utils/sp_helper.dart';
import '../utils/url_helper.dart';
import 'membership_controller.dart';

class PremiumPageController extends GetxController {
  RxInt currentSliderIndex = 0.obs;
  final CarouselController controller = CarouselController();
  RxInt sliderIndex = 1.obs;
  RxBool reloadIndicator = false.obs;
  RxInt inAppPurchaseItemIndex = 50000.obs;

  List<MembershipModel> sliderData =[
    MembershipModel(id:1,image: Assets.imagesThree, title1: 'Unlimited Messages', title2: 'No Limits or restrictions on Chat'),
    MembershipModel(id:2,image: Assets.imagesOne, title1: 'Superfast AI Model', title2: 'Provides Superfast AI Models'),
    MembershipModel(id:3,image: Assets.imagesFour, title1: 'Ad Free Experience', title2: 'Seamless experience with no cheapy ads'),
    MembershipModel(id:4,image: Assets.imagesTwo, title1: 'Get Free Updates', title2: 'Gets all future program absolutely free'),
    MembershipModel(id:5,image: Assets.imagesFive, title1: 'VIP Customer Support', title2: 'Write down any suggestions or Query'),
  ];

  List<String> productIds =[];
  final InAppPurchase inAppPurchase = InAppPurchase.instance;
  List<ProductDetails> products = <ProductDetails>[];
  late StreamSubscription<List<PurchaseDetails>> _subscription;

   @override
  void onInit() {
    super.onInit();

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
          inAppPurchase.getPlatformAddition<
              InAppPurchaseAndroidPlatformAddition>();
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




}
