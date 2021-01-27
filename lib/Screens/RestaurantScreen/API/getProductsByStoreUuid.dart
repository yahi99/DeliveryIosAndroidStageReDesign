import 'package:flutter_app/Screens/RestaurantScreen/Model/ProductsByStoreUuid.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/models/CreateOrderModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


Future<ProductsByStoreUuidData> getProductsByStoreUuid(String store_uuid) async {
  ProductsByStoreUuidData productsByStoreUuid = null;
  var url = 'http://78.110.156.74:3003/api/v3/products/store/${store_uuid}';
  var response = await http.get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    'Source':'ios_client_app_1',
    "ServiceName": 'faem_food',
  });
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    productsByStoreUuid = new ProductsByStoreUuidData.fromJson(jsonResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  //print(response.body);
  return productsByStoreUuid;
}