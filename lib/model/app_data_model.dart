// To parse this JSON data, do
//
//     final appDataModel = appDataModelFromJson(jsonString);

import 'dart:convert';

AppDataModel appDataModelFromJson(String str) => AppDataModel.fromJson(json.decode(str));

String appDataModelToJson(AppDataModel data) => json.encode(data.toJson());

class AppDataModel {
  AppDataModel({
    this.success = false,
    this.statusCode = 0,
    this.message = '',
    this.data,
  });

  bool success;
  int statusCode;
  String message;
  Data? data;

  factory AppDataModel.fromJson(Map<String, dynamic> json) => AppDataModel(
        success: json["success"],
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : Data(),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.userId = "",
    this.appData,
  });

  String userId;
  AppData? appData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userId"],
        appData: AppData.fromJson(json["appData"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "appData": appData!.toJson(),
      };
}

class AppData {
  AppData({
    this.id = 0,
    this.appName = "",
    this.appUrl = "",
    this.appVersion = "",
    this.appBundle = "",
    this.appIcon = "",
    this.interstitial1 = "",
    this.interstitial2 = "",
    this.rewardedAdId1 = "",
    this.rewardedAdId2 = "",
    this.native1 = "",
    this.native2 = "",
    this.banner1 = "",
    this.banner2 = "",
    this.appOpen1 = "",
    this.appOpen2 = "",
    this.clickEvent = 0,
    this.clickEventSplash = 0,
    this.splashType = 0,
    this.intervalTime = "",
    this.eStatus = 0,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.isSubscription,
  });

  int id;
  String appName;
  String appUrl;
  String appVersion;
  String appBundle;
  String appIcon;
  String interstitial1;
  String interstitial2;
  String rewardedAdId1;
  String rewardedAdId2;
  String native1;
  String native2;
  String banner1;
  String banner2;
  String appOpen1;
  String appOpen2;
  int clickEvent;
  int clickEventSplash;
  int splashType;
  String intervalTime;
  int eStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  bool? isSubscription;

  factory AppData.fromJson(Map<String, dynamic> json) => AppData(
        id: json["id"] ?? 0,
        appName: json["app_name"] ?? "",
        appUrl: json["app_url"] ?? "",
        appVersion: json["app_version"] ?? "",
        appBundle: json["app_bundle"] ?? "",
        appIcon: json["app_icon"] ?? "",
        interstitial1: json["interstitial1"] ?? "",
        interstitial2: json["interstitial2"] ?? "",
        rewardedAdId1: json["reward1"] ?? "",
        rewardedAdId2: json["reward2"] ?? "",
        native1: json["native1"] ?? "",
        native2: json["native2"] ?? "",
        banner1: json["banner1"] ?? "",
        banner2: json["banner2"] ?? "",
        appOpen1: json["app_open1"] ?? "",
        appOpen2: json["app_open2"] ?? "",
        clickEvent: json["click_event"] ?? 0,
        clickEventSplash: json["click_event_splash"] ?? 0,
        splashType: json["splash_type"] ?? 0,
        intervalTime: json["interval_time"] ?? "",
        eStatus: json["estatus"] ?? 0,
        createdAt: DateTime.parse(json["created_at"] ?? "0000-00-00"),
        updatedAt: DateTime.parse(json["updated_at"] ?? "0000-00-00"),
        deletedAt: json["deleted_at"],
    isSubscription: json["is_subscription"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "app_name": appName,
        "app_url": appUrl,
        "app_version": appVersion,
        "app_bundle": appBundle,
        "app_icon": appIcon,
        "interstitial1": interstitial1,
        "interstitial2": interstitial2,
        "reward1": rewardedAdId1,
        "reward2": rewardedAdId2,
        "native1": native1,
        "native2": native2,
        "banner1": banner1,
        "banner2": banner2,
        "app_open1": appOpen1,
        "app_open2": appOpen2,
        "click_event": clickEvent,
        "click_event_splash": clickEventSplash,
        "splash_type": splashType,
        "interval_time": intervalTime,
        "estatus": eStatus,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "deleted_at": deletedAt,
    "is_subscription": isSubscription,
      };
}
