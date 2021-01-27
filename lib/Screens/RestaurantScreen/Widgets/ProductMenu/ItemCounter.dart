import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/OrdersScreen/Model/order.dart';
import 'package:flutter_app/Screens/RestaurantScreen/Model/ProductsByStoreUuid.dart';
import 'package:flutter_app/Screens/RestaurantScreen/View/restaurant_screen.dart';
import 'package:flutter_app/Screens/RestaurantScreen/Widgets/PriceField.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Item.dart';

class MenuItemCounter extends StatefulWidget {
  GlobalKey<PriceFieldState> priceFieldKey;
  Order order;
  ProductsByStoreUuid foodRecords;
  MenuItemState parent;
  MenuItemCounter({Key key, this.priceFieldKey, this.foodRecords, this.order, this.parent}) : super(key: key);

  @override
  MenuItemCounterState createState() {
    return new MenuItemCounterState(priceFieldKey, this.foodRecords, this.order, this.parent);
  }
}

class MenuItemCounterState extends State<MenuItemCounter> {
  GlobalKey<PriceFieldState> priceFieldKey;
  Order order;
  ProductsByStoreUuid foodRecords;
  GlobalKey<MenuItemCounterState> menuItemCounterKey = new GlobalKey();

  MenuItemState parent;

  MenuItemCounterState(this.priceFieldKey, this.foodRecords, this.order, this.parent);

  int counter = 1;

  // ignore: non_constant_identifier_names
  void _incrementCounter_plus() {
    setState(() {
      counter++;
      updateCartItemQuantity();
    });
  }

  // ignore: non_constant_identifier_names
  void _incrementCounter_minus() {
    setState(() {
      counter--;
      updateCartItemQuantity();
    });
  }


  void updateCartItemQuantity(){
    order.quantity = counter;
  }

  Widget build(BuildContext context) {
    if(order == null){
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 5),
          child: Row(
            children: [
              SvgPicture.asset('assets/svg_images/rest_plus.svg'),
              Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 5, top: 5, right: 5),
                    child: Text(
                      '00',
                      // '${foodRecords.price} \₽',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
              ),
            ],
          ),
        ),
      );
    }
    counter = order.quantity;
    return Padding(
        padding: EdgeInsets.only(left: 15, right: 0),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          InkWell(
            onTap: () {
              if (counter != 1) {
                _incrementCounter_minus();
                // counter = restaurantDataItems.records_count;
              }
            },
            child: SvgPicture.asset('assets/svg_images/rest_minus.svg'),
          ),
          Container(
            height: 30,
            width: 50,
            child: Padding(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: Center(
                child: Text(
                  '$counter',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ),
            ),
          ),
          // InkWell(
          //   onTap: () async {
          //     if (await Internet.checkConnection()) {
          //       if(foodRecords.toppings != null || foodRecords.variants != null){
          //         parent.onPressedButton(foodRecords, menuItemCounterKey);
          //       }else{
          //         setState(() {
          //           _incrementCounter_plus();
          //           // counter = restaurantDataItems.records_count;
          //         });
          //       }
          //
          //     } else {
          //       noConnection(context);
          //     }
          //   },
          //   child: SvgPicture.asset('assets/svg_images/rest_plus.svg'),
          // ),
        ])
    );
  }

  void refresh() {
    setState(() {});
  }
}