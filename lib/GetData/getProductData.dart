import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/models/CreateOrderModel.dart';
import 'package:flutter_app/models/ProductDataModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


Future<ProductDataModel> getProductData() async {
  await CreateOrder.sendRefreshToken();
  ProductDataModel productDataModelItem = null;
  var url = 'http://78.110.156.74:3003/api/v3/products/04b07ccb-dfd4-468a-9277-f4dc87ffa39c';
  var response = await http.get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    'Source':'ios_client_app_1',
    "ServiceName": 'faem_food',
    'Authorization':'Bearer ' + authCodeData.token
  });
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    productDataModelItem = new ProductDataModel.fromJson(jsonResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  print(response.body);
  return productDataModelItem;
}