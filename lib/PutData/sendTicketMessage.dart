import 'dart:convert';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/models/CreateOrderModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<bool> sendTicketMessage(String uuid, String message) async {
  await CreateOrder.sendRefreshToken();
  var json_request = jsonEncode({
    "message": message,
  });
  var url =
      'https://crm.apis.stage.faem.pro/api/v2/tickets/comments/add/$uuid';
  var response = await http.put(url, body: json_request, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    'Source':'ios_client_app_1',
    "ServiceName": 'faem_food',
    'Authorization':'Bearer ' + authCodeData.token,
    'Accept-Language': 'ru'
  });
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return false;
  }
  print(response.body);
  return true;
}
