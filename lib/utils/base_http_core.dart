import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'url_helper.dart';


class BaseApiCalls<T>{
  static const errorMsg = "Got error, please try again.";


  Future<AppClientResponse<T>> sendRequest<T>(
      {
        data,
        Map<String, dynamic>? queryParameters,
        String? url,
      }) async {
    AppClientResponse<T> clientResponse = AppClientResponse<T>();
    T? response;
    var   responses;
    try {

      /* if(apiType == "GET"){
        responses = await http.get(Uri.parse(UrlHelper.APP_URL));
        response = responses.body;
      }else if(apiType == "POST") {
        responses = await http.post(Uri.parse(UrlHelper.APP_URL),headers: UrlHelper.REQ_HEADER, body: jsonEncode(queryParameters));
        response = responses.body;
      } */

      responses = await http.post(Uri.parse(url!),headers: UrlHelper.reqHeader, body: jsonEncode(queryParameters));
      response = responses.body;

      if(clientResponse.code == 200){
        clientResponse.isSuccessful = true;
        clientResponse.rawResponse = response as String?;
      }else{
        clientResponse.isSuccessful = false;
        clientResponse.rawResponse = response as String?;
      }

      clientResponse.code = responses.statusCode;
      debugPrint("Response =======>>>>> $response");
    } catch (exception) {
      debugPrint("response.exception");
      debugPrint(exception.toString());
      clientResponse.code = 10000000000000000;
      clientResponse.isSuccessful = false;
      //clientResponse.errorMsg = handleError2(exception);
    }

    return clientResponse;
  }

}

class AppClientResponse<T> {
  /// true = request is success
  bool isSuccessful;
  int? code;

  /// response data for the request
  String? rawResponse;
  dynamic rawBytes;

  /// Error message which can be displayed to user
  String? errorMsg;
  String? requestUrl;

  T? obj;

  AppClientResponse({
    this.isSuccessful = false,
    this.code = 400,
    this.rawResponse,
    this.rawBytes,
    this.errorMsg = "",
    this.requestUrl,
    this.obj,
  });

  AppClientResponse copyWith({
    bool? isSuccessful,
    int? code,
    String? rawResponse,
    dynamic rawBytes,
    String? errorMsg,
    String? requestUrl,
    T? obj,
  }) {
    return AppClientResponse(
      isSuccessful: isSuccessful ?? this.isSuccessful,
      code: code ?? this.code,
      rawResponse: rawResponse ?? this.rawResponse,
      rawBytes: rawBytes ?? this.rawBytes,
      errorMsg: errorMsg ?? this.errorMsg,
      requestUrl: requestUrl ?? this.requestUrl,
      obj: obj ?? this.obj,
    );
  }

  @override
  String toString() {
    return 'AppClientResponse{isSuccessful: $isSuccessful, code: $code, rawResponse: $rawResponse, rawBytes: $rawBytes, errorMsg: $errorMsg, requestUrl: $requestUrl}';
  }
}