class BaseResponse {
  bool status = true;
  // Data? data;
  String message = "";
  String msg = "";
  int errorcode = 0;
  BaseResponse({required this.status, required this.message, required this.errorcode});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    status = json['success'] ?? false;
    message = json['message'] ?? "";
    msg = json['msg'] ?? "";
    errorcode = json["status_code"] ?? 0;
    // data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = status;
    data['message'] = message;
    data['msg'] = msg;
    // if (this.data != null) {
    //   data['data'] = this.data!.toJson();
    // }
    return data;
  }
}

class Data {
  String? token;

  Data({this.token});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}
