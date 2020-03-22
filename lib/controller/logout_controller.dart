import 'dart:convert';

import 'package:cone08/model/person_model.dart';
import 'package:dio/dio.dart' as fuck;

abstract class LogoutController {
  static Future<Person> logout({Person person}) async {
    String url = 'http://192.168.1.100:8888';
    fuck.RequestOptions option = fuck.RequestOptions();
    option.baseUrl = url;
    option.method = 'POST';
    option.data = jsonEncode(person);
    fuck.Dio dio = fuck.Dio();
    Person personS;
    fuck.Response response = await dio.request("/logout", options: option);
    if (response.statusCode == 200) {
      personS = Person.fromJson(jsonDecode(response.data));
      return personS;
    } else {
      print(response.statusCode);
      personS.method = 'error';
      personS.desc = response.statusMessage;
      return personS;
    }
  }
}
