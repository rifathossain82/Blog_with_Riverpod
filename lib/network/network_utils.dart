import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class Network {
  static const baseUrl = 'https://apiv1.techofic.com/app/techofice/';

  static getRequest({required String endPoint}) async {
    var headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };

    Response response =
        await get(Uri.parse(baseUrl + endPoint), headers: headers);
    return response;
  }

  static postRequest({required String endPoint, body}) async {
    var headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };

    Response response =
        await post(Uri.parse(baseUrl + endPoint), headers: headers, body: body);
    return response;
  }

  static multipartRequest(
      {required String endPoint,
      required String methodName,
      body,
      required String filePath,
      String fieldName = 'image'}) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data'
    };

    MultipartRequest request;
    var url = baseUrl + endPoint;

    if (filePath.isEmpty || filePath == '') {
      request = MultipartRequest(methodName, Uri.parse(url))
        ..fields.addAll(body)
        ..headers.addAll(headers);
    } else {
      request = MultipartRequest(methodName, Uri.parse(url))
        ..fields.addAll(body)
        ..headers.addAll(headers)
        ..files.add(await MultipartFile.fromPath(fieldName, filePath));
    }

    StreamedResponse streamedResponse = await request.send();
    Response response = await Response.fromStream(streamedResponse);

    return response;
  }

  static handleResponse(Response response) async {
    if (response.statusCode >= 200 && response.statusCode <= 200) {
      if (kDebugMode) {
        print('SuccessCode: ${response.statusCode}');
        print('SuccessResponse: ${response.body}');
      }

      if (response.body.isNotEmpty) {
        return jsonDecode(response.body);
      } else {
        return response.body;
      }
    } else {
      if (kDebugMode) {
        print('ErrorCode: ${response.statusCode}');
        print('ErrorResponse: ${response.body}');
      }

      print('Something went wrong!');
    }
  }
}
