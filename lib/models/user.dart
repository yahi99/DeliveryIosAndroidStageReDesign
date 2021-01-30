import 'package:flutter_app/Screens/CartScreen/Model/CartModel.dart';
import 'package:flutter_app/Screens/OrdersScreen/Model/order.dart';

import 'CartDataModel.dart';

class User{
  bool isLoggedIn;
  String name;
  final List<Order> orders;
  CartModel cartModel;
  String phone;

  User({
    this.isLoggedIn = true,
    this.name,
    this.orders,
    this.cartModel,
    this.phone
  });
}