// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/base_response.dart';

// ignore: constant_identifier_names
enum ApiType { POST, GET, PATCH, DELETE }

class ApiCall {
  Future apiCall(
      {required String url,
      required Map<String, String> body,
      required Map<String, String> header,
      required ApiType apiType,
      required bool isMultiRequest,
      String imagePath = '',
      String flieParam = '',
      required Function(Map<String, dynamic>, bool, String) onSuccess}) async {
    // required Function(DataClass, bool, int) onSuccess}) async {

    // http.Response response;
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String respStr = "";
    // final dataStorage = GetStorage();
    // String token = "";
    // if (dataStorage.read(StringHelper.token) == null) {
    //   dataStorage.writeIfNull(StringHelper.token, "");
    // } else {
    //   token = dataStorage.read(StringHelper.token);
    //   debugPrint("  token   => " + token);
    // }

    debugPrint("  body   => $body");
    debugPrint("  url   => $url");

    ///Get Api
    if (apiType == ApiType.GET) {
      // String? token = prefs.getString(StringHelper.token);
      var request = http.Request('GET', Uri.parse(url));
      request.body = json.encode(body);
      request.headers.addAll(header);

      var response = await request.send();
      debugPrint("statusCode  =>  ${response.statusCode}");

      String respStr = await response.stream.bytesToString();
      debugPrint('respStr: $respStr');

      var jsonResponse = json.decode(respStr);
      BaseResponse baseResponse = BaseResponse.fromJson(jsonResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (baseResponse.status) {
          onSuccess(jsonResponse, true, "success");
        } else {
          onSuccess(jsonResponse, false, baseResponse.message.isEmpty ? baseResponse.msg : baseResponse.message);
        }
      } else {
        onSuccess(jsonResponse, false, baseResponse.message);
      }
    } else

    /// Post Api
    if (apiType == ApiType.POST) {
      // String? token = prefs.getString(StringHelper.token);
      /*Map<String, String> reqHeader = {
      "Content-type": "application/json",
      "Authorization": "Bearer $token"
    };

    debugPrint("Upload body => " + body.toString());
    // debugPrint("  token  => " + token);
    http.Response response = await http.post(Uri.parse(url), body: body, headers: reqHeader);
    debugPrint("Response body ===> " + response.body);*/

      // ignore: prefer_typing_uninitialized_variables
      var response;
      // ignore: prefer_typing_uninitialized_variables
      var jsonResponse;

      debugPrint("body => $body");
      if (isMultiRequest) {
        http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url))..fields.addAll(body);

        if (imagePath.isNotEmpty) {
          // debugPrint('imagePath: $imagePath');
          http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
            flieParam,
            imagePath, /* contentType: MediaType("image", "jpg",) */
          );

          request.files.add(multipartFile);
        }

        request.headers.addAll(header);
        response = await request.send();

        String respStr = await response.stream.bytesToString();

        jsonResponse = json.decode(respStr);
      } else {
        response = await http.post(Uri.parse(url), body: json.encode(body), headers: header);

        jsonResponse = json.decode(response.body);
/*        var request = http.Request('POST', Uri.parse(url));
        // request.bodyFields.addAll(json.encode(body));
        // request.body = json.encode(body);
        request.headers.addAll(header);
        response = await request.send();
        debugPrint("statusCode  =>  ${response.statusCode}");*/

      }

      // String respStr = await response.stream.bytesToString();

      BaseResponse baseResponse = BaseResponse.fromJson(jsonResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (baseResponse.status) {
          onSuccess(jsonResponse, false, baseResponse.message);
        } else {
          onSuccess(jsonResponse, false, baseResponse.message.isEmpty ? baseResponse.msg : baseResponse.message);
        }
      } else {
        onSuccess(jsonResponse, false, baseResponse.message);
      }
    } else if (apiType == ApiType.PATCH) {
      debugPrint("Upload body => $body");
      // debugPrint("  token   => " + token);

      var response;

      if (isMultiRequest) {
        http.MultipartRequest request = http.MultipartRequest('PATCH', Uri.parse(url))..fields.addAll(body);
        request.headers.addAll(header);
        response = await request.send();

        debugPrint("statusCode  =>  ${response.statusCode}");
      } else {
        var request = http.Request('PATCH', Uri.parse(url));
        request.body = json.encode(body);
        request.headers.addAll(header);

        response = await request.send();
        debugPrint("statusCode  =>  ${response.statusCode}");
      }

      String respStr = await response.stream.bytesToString();
      debugPrint('respStr: $respStr');

      var jsonResponse = json.decode(respStr);
      BaseResponse baseResponse = BaseResponse.fromJson(jsonResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (baseResponse.status) {
          onSuccess(jsonResponse, true, baseResponse.message);
        } else {
          onSuccess(jsonResponse, false, baseResponse.message.isEmpty ? baseResponse.msg : baseResponse.message);
        }
      } else {
        onSuccess(jsonResponse, false, baseResponse.message);
      }
      // request.headers.addAll({'Authorization': 'Bearer $token'});
      // var response = await request.send();
      // respStr = await response.stream.bytesToString();
      // debugPrint('respStr : ${jsonDecode(respStr)}');
    }

    // var jsonResponse = json.decode(respStr);
    // debugPrint('Login Response : ${jsonResponse.toString()}');
    // DataClass dataClass = DataClass.fromJson(jsonResponse);
    // DataClass dataClass = DataClass.fromJson(jsonDecode(response.body));
    // if (dataClass.status) {
    //   onSuccess(dataClass);
    // }
  }
}
