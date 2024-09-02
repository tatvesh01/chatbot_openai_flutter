class PakageDataModel {
  PakageDataModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  bool? success;
  int? statusCode;
  String? message;
  List<PakageItem?>? data;

  factory PakageDataModel.fromJson(Map<String, dynamic> json) => PakageDataModel(
        success: json["success"],
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] == null ? [] : List<PakageItem?>.from(json["data"]!.map((x) => PakageItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
      };
}

class PakageItem {
  PakageItem({
    this.id,
    this.applicationId,
    this.packageType,
    this.title,
    this.price,
    this.value,
    this.estatus,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  int? applicationId;
  int? packageType;
  String? title;
  String? price;
  String? value;
  int? estatus;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  factory PakageItem.fromJson(Map<String, dynamic> json) => PakageItem(
        id: json["id"],
        applicationId: json["application_id"],
        packageType: json["package_type"],
        title: json["title"],
        price: json["price"],
        value: json["value"],
        estatus: json["estatus"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "application_id": applicationId,
        "package_type": packageType,
        "title": title,
        "price": price,
        "value": value,
        "estatus": estatus,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}



class PakageListItem {
  PakageListItem({
    required this.id,
    required this.title,
    required this.price,
    required this.planId,
  });

  int id;
  String title;
  int price;
  String planId;

  factory PakageListItem.fromJson(Map<String, dynamic> json) => PakageListItem(
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