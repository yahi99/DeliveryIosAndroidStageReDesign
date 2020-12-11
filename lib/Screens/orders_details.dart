import 'package:flutter/material.dart';
import 'package:flutter_app/Internet/check_internet.dart';
import 'package:flutter_app/PutData/OrderCancel.dart';
import 'package:flutter_app/Screens/cart_screen.dart';
import 'package:flutter_app/Screens/restaurant_screen.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/models/OrderStoryModel.dart';
import 'package:flutter_app/models/ResponseData.dart';
import 'package:flutter_app/models/RestaurantDataItems.dart';
import 'package:flutter_app/models/order.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../GetData/getImage.dart';
import 'home_screen.dart';

class OrdersDetailsScreen extends StatefulWidget {
  final OrdersStoryModelItem ordersStoryModelItem;

  OrdersDetailsScreen({Key key, this.ordersStoryModelItem}) : super(key: key);

  @override
  OrdersDetailsScreenState createState() =>
      OrdersDetailsScreenState(ordersStoryModelItem);
}

class OrdersDetailsScreenState extends State<OrdersDetailsScreen> {
  final OrdersStoryModelItem ordersStoryModelItem;

  OrdersDetailsScreenState(this.ordersStoryModelItem);

  GlobalKey<CartItemsQuantityState> cartItemsQuantityKey = new GlobalKey();

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Container(
              height: 150,
              width: 320,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 20, bottom: 20),
                    child: Text(
                      'Отмена заказа',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF424242)),
                    ),
                  ),
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              )),
        );
      },
    );
  }

  showNoCancelAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop(true);
        });
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Container(
              height: 100,
              width: 320,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 20, bottom: 20, right: 15),
                    child: Text(
                      'Вы не можете отменить заказ',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF424242)),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }

  List<Widget> _buildListItems(){
    double totalPrice = ordersStoryModelItem.tariff.totalPrice.toDouble();
    var format = new DateFormat('  HH:mm    dd.MM.yyyy');
    List<Widget> result = new List<Widget>();
    if(ordersStoryModelItem.products == null){
      return List<Container>();
    }
    result.add(Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10, top: 10),
      child: Container(
        height: 170,
        padding: EdgeInsets.only(right: 10, left: 15),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8.0, // soften the shadow
                spreadRadius: 3.0, //extend the shadow
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(width: 1.0, color: Colors.grey[200])),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (ordersStoryModelItem.store != null)
                        ? ordersStoryModelItem.store.name
                        : 'Пусто',
                    style: TextStyle(fontSize: 18, color: Color(0xFF000000)),
                  ),
                  Text(
                    '${ordersStoryModelItem.price + ordersStoryModelItem.tariff.productsPrice - ordersStoryModelItem.tariff.bonusPayment} \₽',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svg_images/clock.svg'),
                        Padding(
                          padding: EdgeInsets.only(left: 15, top: 0, right: 15),
                          child: Text(
                            format.format(DateTime.fromMillisecondsSinceEpoch( ordersStoryModelItem.created_at_unix * 1000)),
                            style: TextStyle(fontSize: 12, color: Color(0xFFB0B0B0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  (ordersStoryModelItem.state_title == "Завершен") ? Row(
                    children: [
                      Text('Доставлен',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: SvgPicture.asset('assets/svg_images/delivered.svg'),
                      )
                    ],
                  ) : Container(
                    child: Text(ordersStoryModelItem.state_title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(color: Color(0xFFE6E6E6),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Адрес заведения',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF3F3F3F),),
                  ),
                  Text(
                    'Адрес доставки',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF3F3F3F),),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (ordersStoryModelItem.store != null)
                            ? ordersStoryModelItem.routes[0].unrestrictedValue
                            : 'Пусто',
                        style: TextStyle(fontSize: 12, color: Color(0xFFB0B0B0)),
                      ),
                      Text(
                        (ordersStoryModelItem.store != null && ordersStoryModelItem.routes.length > 1)
                            ?  ordersStoryModelItem.routes[1].unrestrictedValue
                            : 'Пусто',
                        style: TextStyle(fontSize: 12, color: Color(0xFFB0B0B0),),
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
    ordersStoryModelItem.products.forEach((product) {
      if(product.selectedVariant != null && product.selectedVariant.price != null){
        totalPrice += product.number * (product.price + product.selectedVariant.price);
      }else{
        totalPrice += product.number * product.price;
      }
      double toppingsCost = 0;
      if(product.toppings != null){
        product.toppings.forEach((element) {
          toppingsCost += product.number * element.price;
        });
        totalPrice += toppingsCost;
      }
      result.add(Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    child: Image.network(
                      getImage(product.image),
                      fit: BoxFit.cover,
                      height: 70,
                      width: 70,
                    ),),
                ),
                (product.selectedVariant == null || product.toppings == null ||
                    product.selectedVariant == null && product.toppings == null) ? Expanded(
                  child: SingleChildScrollView(
                    child:  Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              product.name,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 16.0,
                                  color: Color(0xFF000000)),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        (product.selectedVariant != null)
                            ? Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              product.selectedVariant .name,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 10.0,
                                  color: Color(0xFF000000)),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        )
                            : Text(''),
                        (product.toppings != null)
                            ? Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Column(
                            children: List.generate(
                                product.toppings.length,
                                    (index) => Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(bottom: 5, left: 2),
                                    child: Text(
                                      product.toppings[index]
                                          .name,
                                      style: TextStyle(
                                          decoration:
                                          TextDecoration.none,
                                          fontSize: 10.0,
                                          color: Color(0xFF000000)),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                )),
                          ),
                        )
                            : Text(''),
                      ],
                    ),
                  ),
                ) : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, left: 15),
                            child: Text(
                              product.name,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 16.0,
                                  color: Color(0xFF000000)),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        (product.selectedVariant != null)
                            ? Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5, left: 15),
                            child: Text(
                              product.selectedVariant .name,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 10.0,
                                  color: Color(0xFF000000)),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        )
                            : Text(''),
                        (product.toppings != null)
                            ? Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Column(
                            children: List.generate(
                                product.toppings.length,
                                    (index) => Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(bottom: 5, left: 2),
                                    child: Text(
                                      product.toppings[index]
                                          .name,
                                      style: TextStyle(
                                          decoration:
                                          TextDecoration.none,
                                          fontSize: 10.0,
                                          color: Color(0xFF000000)),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                )),
                          ),
                        )
                            : Text(''),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Text(
                        '${(product.selectedVariant != null  && product.selectedVariant.price != null) ?
                        (product.number * (product.price + product.selectedVariant.price) + toppingsCost).toStringAsFixed(0) :
                        (product.number * product.price + toppingsCost).toStringAsFixed(0)} \₽',
                        style: TextStyle(
                            color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Text(
                        '${product.number}шт',
                        style: TextStyle(
                            color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Divider(color: Color(0xFFE6E6E6)),
          ),
        ],
      ));
    });
    double own_delivery_price = totalPrice - ordersStoryModelItem.tariff.totalPrice;
    (ordersStoryModelItem.own_delivery != null && ordersStoryModelItem.own_delivery) ? result.add(Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15, bottom: 20, top: 10),
              child: Text(
                'Итого',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF000000)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15, bottom: 20),
              child: Text('${own_delivery_price.toStringAsFixed(0)} \₽',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF000000))),
            )
          ],
        ),
        Container(height: 10, color: Color(0xF3F3F3F3),),
        Padding(
            padding: EdgeInsets.only(left: 15, top: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Доставка оплачивается отдельно",
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 14),
                ),
              ],
            )
        ),
        Container(
          height: MediaQuery.of(context).size.height,
        )
      ],
    ),) : result.add(Column(
      children: [
        Padding(
            padding: EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Доставка",
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.only(),
                  child: Text(
                    (ordersStoryModelItem.tariff.totalPrice - ordersStoryModelItem.tariff.bonusPayment).toString() + ' \₽',
                    style: TextStyle(
                        color: Colors.black, fontSize: 18),
                  ),
                ),
              ],
            )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15, bottom: 20, top: 10),
              child: Text(
                'Итого',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF000000)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15, bottom: 20),
              child: Text('${totalPrice.toStringAsFixed(0)} \₽',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF000000))),
            )
          ],
        )
      ],
    ),);

    return result;
  }

  bool status1 = false;

  @override
  Widget build(BuildContext context) {
    double totalPrice = 134;
    currentUser.cartDataModel.cart.forEach(
            (Order order) {
          if(order.food.variants != null && order.food.variants.length > 0 && order.food.variants[0].price != null){
            totalPrice += order.quantity * (order.food.price + order.food.variants[0].price);
          }else{
            totalPrice += order.quantity * order.food.price;
          }
          double toppingsCost = 0;
          if(order.food.toppings != null){
            order.food.toppings.forEach((element) {
              toppingsCost += order.quantity * element.price;
            });
            totalPrice += toppingsCost;
          }
        }
    );
    var state_array = [
      'waiting_for_confirmation',
      'cooking',
      'offer_offered',
      'smart_distribution',
      'finding_driver',
      'offer_rejected',
      'order_start',
      'on_place',
      'on_the_way',
      'order_payment',
      'transferred_to_store',
      'order_accepted'
    ];
    var not_cancel_state = [
      'cooking',
      'offer_offered',
      'smart_distribution',
      'finding_driver',
      'offer_rejected',
      'order_start',
      'on_place',
      'on_the_way',
      'order_payment',
      'transferred_to_store',
      'order_accepted'
    ];
    // TODO: implement build
    return Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40, bottom: 10),
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              height: 40,
                              width: 60,
                              child: Padding(
                                padding:
                                EdgeInsets.only(top: 12, bottom: 12, right: 10),
                                child:  SvgPicture.asset(
                                    'assets/svg_images/arrow_left.svg'),
                              ))),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Flexible(
                    flex: 6,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: 40),
                        child: Text(
                          "Детали заказа",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3F3F3F)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 1.0, color: Color(0xFFF5F5F5)),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: _buildListItems(),
              ),
            ),
            Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 5, right: 10, left: 10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: (!state_array.contains(ordersStoryModelItem.state)) ? GestureDetector(
                      child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Color(0xFF50B561),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              'Повторить заказ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,),
                            ),
                          )),
                      onTap: () async {
                        if (await Internet.checkConnection()) {
                          Records restaurant = ordersStoryModelItem.store;
                          currentUser.cartDataModel.cart.clear();
                          ordersStoryModelItem.products
                              .forEach((FoodRecordsStory element) {
                            FoodRecords foodItem =
                            FoodRecords.fromFoodRecordsStory(element);
                            Order order = new Order(
                                restaurant: restaurant,
                                food: foodItem,
                                date: DateTime.now().toString(),
                                quantity: element.number,
                                isSelected: false);
                            currentUser.cartDataModel.cart.add(order);
                          });
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) {
                              return new CartScreen(restaurant: restaurant);
                            }),
                          );
                        } else {
                          noConnection(context);
                        }
                      },
                    ) : (!not_cancel_state.contains(ordersStoryModelItem.state)) ?  GestureDetector(
                      child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Color(0xFFFE534F),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              'Отменить',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,),
                            ),
                          )),
                      onTap: () async {
                        if (await Internet.checkConnection()) {
//                          if(not_cancel_state.contains(ordersStoryModelItem.state)){
//                            showNoCancelAlertDialog(context);
//                            return;
//                          }
                          showAlertDialog(context);
                          await loadOrderCancel(ordersStoryModelItem.uuid);
                          homeScreenKey = new GlobalKey();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                                  (Route<dynamic> route) => false);
                        } else {
                          noConnection(context);
                        }
                      },
                    ): Container(),
                  )),
            ),
            Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 20, right: 10, left: 10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: (!state_array.contains(ordersStoryModelItem.state)) ? GestureDetector(
                      child: Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Color(0xFFDC634A),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              'Удалить данные о заказе',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,),
                            ),
                          )),
                    ) : Container(),
                  )),
            )
          ],
        ));
  }
}