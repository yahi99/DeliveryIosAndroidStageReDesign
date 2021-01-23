import 'dart:convert';
import 'dart:ui';
import 'package:flutter_app/models/ResponseData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


Future<DeliveryResponseData> loadRestaurant(int page, int limit, String category) async {
  DeliveryResponseData deliveryResponseData = null;
  var json_request = jsonEncode({
    "type": "restaurant",
    "page": page,
    "limit": limit,
    "category": category
  });
  if(category == ''){
    json_request = jsonEncode({
      "type": "restaurant",
      "page": page,
      "limit": limit
    });
  }
  var url = 'https://crm.apis.stage.faem.pro/api/v2/stores';
  Locale locale;
  var response = await http.post(url, body: json_request, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept-Language': 'ru'
  });
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    deliveryResponseData = new DeliveryResponseData.fromJson(jsonResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  return deliveryResponseData;
}