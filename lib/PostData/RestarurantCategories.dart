import 'dart:convert';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/models/AuthCode.dart';
import 'package:flutter_app/models/RestaurantCategoriesModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<RestaurantCategories> loadRestaurantCategories(int page, int limit) async {

  RestaurantCategories restaurantCategories = null;
  var json_request = jsonEncode({
    "page": page,
    "limit": limit
  });

  var url = 'https://crm.apis.stage.faem.pro/api/v2/stores/categories?limit=$limit&page=$page';
  var response = await http.post(url, body: json_request, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept-Language': 'ru'
  });
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    restaurantCategories = new RestaurantCategories.fromJson(jsonResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  print(response.body);
  return restaurantCategories;
}