import 'dart:convert';

import 'package:cone08/model/person_model.dart';
import 'package:dio/dio.dart' as fuck;

abstract class Reg {
  static Future<String> regToServer({Person person}) async {
    String url = 'http://192.168.1.100:8888';
    fuck.RequestOptions option = fuck.RequestOptions();
    option.responseType = fuck.ResponseType.json;
    //option.connectTimeout = 50000;
    option.baseUrl = url;
    option.contentType = fuck.Headers.jsonContentType;
    option.method = 'POST';
    option.data = jsonEncode(person);
    fuck.Dio dio = fuck.Dio();
    fuck.Response response = await dio.request("/reg", options: option);
    if (response.statusCode == 200) {
      final Map<String, dynamic> dataJson = jsonDecode(response.data);
      String method = dataJson["method"] as String;
      return method;
    } else {
      print(response.statusCode);
      return "error";
    }
  }
}
