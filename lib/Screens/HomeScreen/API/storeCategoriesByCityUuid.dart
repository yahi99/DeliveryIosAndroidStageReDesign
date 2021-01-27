import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/models/CreateOrderModel.dart';
import 'file:///C:/Users/79187/AndroidStudioProjects/DeliveryIosAndroidStageReDesign/lib/Screens/CityScreen/Model/StoreCategoriesByCItyUuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


Future<StoreCategoriesByCItyUuid> getCategoriesByCityUuid() async {
  await CreateOrder.sendRefreshToken();
  StoreCategoriesByCItyUuid storeCategoriesByCityUuid = null;
  var url = 'http://78.110.156.74:3003/api/v3/stores/categories';
  var response = await http.get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    'Source':'ios_client_app_1',
    "ServiceName": 'faem_food',
    'Authorization':'Bearer ' + authCodeData.token
  });
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    storeCategoriesByCityUuid = new StoreCategoriesByCItyUuid.fromJson(jsonResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  print(response.body);
  return storeCategoriesByCityUuid;
}