import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/models/CreateOrderModel.dart';
import 'package:flutter_app/models/OrderStoryModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


Future<OrdersStoryModelItem> loadCurrentDataAboutOrder(String uuid) async {
  await CreateOrder.sendRefreshToken();
  OrdersStoryModelItem ordersStoryModel = null;
  var url = 'https://client.apis.stage.faem.pro/api/v2/orders/' + uuid;
  var response = await http.get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    'Source':'ios_client_app_1',
    "ServiceName": 'faem_food',
    'Authorization':'Bearer ' + authCodeData.token,
    'Accept-Language': 'ru'
  });
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    ordersStoryModel = new OrdersStoryModelItem.fromJson(jsonResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  print(ordersStoryModel);
  return ordersStoryModel;
}