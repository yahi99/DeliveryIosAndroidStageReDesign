
import 'package:flutter/material.dart';

import '../Model/CartModel.dart';

class PriceField extends StatefulWidget {
  CartModel order;
  PriceField({Key key, this.order}) : super(key: key);

  @override
  PriceFieldState createState() {
    return new PriceFieldState(order);
  }
}

class PriceFieldState extends State<PriceField> {
  int count = 1;
  CartModel cartModel;
  PriceFieldState(this.cartModel);
  double totalPrice = 0;

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Text('${cartModel.totalPrice} \₽',
          style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 18.0,
              color: Colors.black)),
    );
  }
  void setCount(int newCount){
    setState(() {
      count = newCount;
    });
  }
}