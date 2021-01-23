import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/models/CreateOrderModel.dart';
import 'package:flutter_app/models/FilteredCities.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


Future<FilteredCities> getFilteredCities() async {
  await CreateOrder.sendRefreshToken();
  FilteredCities filteredCities = null;
  var url = 'http://78.110.156.74:3003/api/v3/cities/filter';
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
    filteredCities = new FilteredCities.fromJson(jsonResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  print(response.body);
  return filteredCities;
}