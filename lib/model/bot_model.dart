import 'package:flutter/material.dart';

class BotParamsModel {
  static const nameKey = "Name";
  static const descKey = "Desc";
  static const iqKey = "IQ";
  static const speedKey = "Speed";
  static const assetPathKey = "assetPath";
  static const bgColorKey = "bgColor";

  BotParamsModel({
    required this.name,
    required this.desc,
    required this.iq,
    required this.speed,
    required this.assetPath,
    required this.bgColor,
  });

  String name;
  String desc;
  String iq;
  String speed;
  String assetPath;
  Color bgColor;

  factory BotParamsModel.fromJson(Map<String, dynamic> json) => BotParamsModel(
        name: json[nameKey] ?? "NA",
        desc: json[descKey] ?? "NA",
        iq: json[iqKey] ?? "NA",
        speed: json[speedKey] ?? "NA",
        assetPath: json[assetPathKey] ?? "NA",
        bgColor: json[bgColorKey] ?? "NA",
      );

  Map<String, dynamic> toJson() => {
        nameKey: name,
        descKey: desc,
        iqKey: iq,
        speedKey: speed,
        assetPathKey: assetPath,
        bgColorKey: bgColor,
      };
}
