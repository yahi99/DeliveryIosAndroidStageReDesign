import 'dart:convert';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/models/AuthCode.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<AuthCodeData> loadAuthCodeData(String device_id, int code) async {

  AuthCodeData authCodeData = null;
  var json_request = jsonEncode({
    "device_id": device_id,
    "code": code
  });
  var url = 'https://client.apis.stage.faem.pro/api/v2/auth/verification';
  var response = await http.post(url, body: json_request, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept-Language': 'ru'
  });
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    authCodeData = new AuthCodeData.fromJson(jsonResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  print(response.body);
  return authCodeData;
}