// To parse this JSON data, do
//
//     final inappModel = inappModelFromJson(jsonString);

import 'dart:convert';

InappModel? inappModelFromJson(String str) => InappModel.fromJson(json.decode(str));

String inappModelToJson(InappModel? data) => json.encode(data!.toJson());

class InappModel {
  InappModel({
    this.success,
    this.statusCode,
    this.message,
    required this.data,
  });

  bool? success;
  int? statusCode;
  String? message;
  List<InAppData> data;

  factory InappModel.fromJson(Map<String, dynamic> json) => InappModel(
    success: json["success"],
    statusCode: json["status_code"],
    message: json["message"],
    data: List<InAppData>.from(json["data"].map((x) => InAppData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "message": message,
    "data": List<InAppData>.from(data.map((x) => x.toJson())),
  };
}

class InAppData {
  InAppData({
    required this.id,
    required this.title,
    required this.price,
    required this.planId,
  });

  int id;
  String title;
  int price;
  String planId;

  factory InAppData.fromJson(Map<String, dynamic> json) => InAppData(
    id: json["id"],
    title: json["name"],
    price: json["price"],
    planId: json["planid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": title,
    "price": price,
    "planid": planId,
  };
}
