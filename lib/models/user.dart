import 'package:flutter_app/Screens/OrdersScreen/Model/order.dart';

import 'CartDataModel.dart';

class User{
  bool isLoggedIn;
  String name;
  final List<Order> orders;
  CartDataModel cartDataModel;
  String phone;

  User({
    this.isLoggedIn = true,
    this.name,
    this.orders,
    this.cartDataModel,
    this.phone
  });
}