import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/RestaurantScreen/Model/ProductsByStoreUuid.dart';

class PriceField extends StatefulWidget {
  ProductsByStoreUuid restaurantDataItems;
  PriceField({Key key, this.restaurantDataItems}) : super(key: key);

  @override
  PriceFieldState createState() {
    return new PriceFieldState(restaurantDataItems);
  }
}

class PriceFieldState extends State<PriceField> {
  int count = 1;
  ProductsByStoreUuid restaurantDataItems;
  PriceFieldState(this.restaurantDataItems);
  Widget build(BuildContext context) {
    return Text(
      '${restaurantDataItems.price * count}\₽',
      style: TextStyle(
          fontSize: 15.0,
          color: Color(0xFF000000)),
      overflow: TextOverflow.ellipsis,
    );
  }
  void setCount(int newCount){
    setState(() {
      count = newCount;
    });
  }
}