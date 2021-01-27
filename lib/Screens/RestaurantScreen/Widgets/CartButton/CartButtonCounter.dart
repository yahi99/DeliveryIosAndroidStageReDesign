import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/OrdersScreen/Model/order.dart';
import 'package:flutter_app/data/data.dart';

class CartButtonCounter extends StatefulWidget {
  CartButtonCounter({Key key}) : super(key: key);

  @override
  CartButtonCounterState createState() {
    return new CartButtonCounterState();
  }
}

class CartButtonCounterState extends State<CartButtonCounter> {
  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    currentUser.cartDataModel.cart.forEach(
            (Order order) => totalPrice += order.quantity * order.food.price);

    return Text('${totalPrice.toStringAsFixed(0)} \₽',
        style: TextStyle(
            fontSize: 18.0, color: Colors.white));
  }

  void refresh() {
    setState(() {});
  }
}