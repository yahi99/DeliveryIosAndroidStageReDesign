import 'package:flutter/material.dart';
import 'package:flutter_app/Internet/check_internet.dart';
import 'package:flutter_app/Localization/app_localizations.dart';
import 'package:flutter_app/PutData/OrderCancel.dart';
import 'package:flutter_app/Screens/cart_screen.dart';
import 'package:flutter_app/Screens/restaurant_screen.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/models/OrderStoryModel.dart';
import 'package:flutter_app/models/ResponseData.dart';
import 'package:flutter_app/models/RestaurantDataItems.dart';
import 'package:flutter_app/models/order.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../GetData/getImage.dart';
import 'home_screen.dart';
import 'dart:io' show Platform;

class OrdersDetailsScreen extends StatefulWidget {
  final OrdersStoryModelItem ordersStoryModelItem;

  OrdersDetailsScreen({Key key, this.ordersStoryModelItem}) : super(key: key);

  @override
  OrdersDetailsScreenState createState() =>
      OrdersDetailsScreenState(ordersStoryModelItem);
}

class OrdersDetailsScreenState extends State<OrdersDetailsScreen> {
  final OrdersStoryModelItem ordersStoryModelItem;
  GlobalKey<CartItemsQuantityState> cartItemsQuantityKey = new GlobalKey();

  bool status1 = false;
  var processing = ['waiting_for_confirmation'
  ];
  var cooking_state = [
    'cooking',
    'offer_offered',
    'smart_distribution',
    'finding_driver',
    'offer_rejected',
    'order_start',
    'on_place',
    'transferred_to_store',
    'order_accepted'
  ];
  var in_the_way = ['on_the_way'];

  Map<String,String> statusIcons = {
    'cooking':'assets/svg_images/bell.svg',
    'offer_offered':'assets/svg_images/bell.svg',
    'smart_distribution':'assets/svg_images/bell.svg',
    'finding_driver':'assets/svg_images/bell.svg',
    'offer_rejected':'assets/svg_images/bell.svg',
    'order_start':'assets/svg_images/bell.svg',
    'on_place':'assets/svg_images/bell.svg',
    'transferred_to_store':'assets/svg_images/bell.svg',
    'order_accepted':'assets/svg_images/bell.svg',
    'on_the_way':'assets/svg_images/car.svg',
    'waiting_for_confirmation':'assets/svg_images/state_clock.svg',
  };

  Map<String,String> statusTitles = {
    'cooking':'Готовится',
    'offer_offered':'Готовится',
    'smart_distribution':'Готовится',
    'finding_driver':'Готовится',
    'offer_rejected':'Готовится',
    'order_start':'Готовится',
    'on_place':'Готовится',
    'transferred_to_store':'Готовится',
    'order_accepted':'Готовится',
    'on_the_way':'В пути',
    'waiting_for_confirmation':'Обработка',
  };


  OrdersDetailsScreenState(this.ordersStoryModelItem);


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
                    padding: EdgeInsets.only(left: 10, top: 20, bottom: 20, right: 10),
                    child: Center(
                      child: Text(
                        'Отмена заказа',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF424242)),
                      ),
                    ),
                  ),
                  Center(
                    child: SpinKitThreeBounce(
                      color: Colors.green,
                      size: 20.0,
                    ),
                  ),
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
    if(ordersStoryModelItem.productsData == null || ordersStoryModelItem.productsData.products == null){
      return List<Container>();
    }
    result.add(Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 14, bottom: 10, top: 10),
      child: Container(
        height: (in_the_way.contains(ordersStoryModelItem.state)) ? 270 : 190,
        padding: EdgeInsets.only(right: 10, left: 15),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4.0, // soften the shadow
                spreadRadius: 1.0, //extend the shadow
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
                    (ordersStoryModelItem.productsData.store != null)
                        ? ordersStoryModelItem.productsData.store.name
                        : 'Пусто',
                    style: TextStyle(fontSize: 18, color: Color(0xFF000000)),
                  ),
                  Text(
                    '${ordersStoryModelItem.tariff.totalPrice + ordersStoryModelItem.tariff.productsPrice - ordersStoryModelItem.tariff.bonusPayment} \₽',
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: SvgPicture.asset('assets/svg_images/clock.svg'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 0, top: 0, right: 15),
                          child: Text(
                            format.format(DateTime.fromMillisecondsSinceEpoch( ordersStoryModelItem.createdAtUnix * 1000)),
                            style: TextStyle(fontSize: 12, color: Color(0xFFB0B0B0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  (ordersStoryModelItem.stateTitle == "Завершен") ? Row(
                    children: [
                      Text(AppLocalizations.of(context).getTranslation('order_details.state'),
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
                  ) : Row(
                    children: [
                      Text(statusTitles[ordersStoryModelItem.state],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 5),
                        child: SvgPicture.asset(statusIcons[ordersStoryModelItem.state]),
                      ),
                    ],
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
                    AppLocalizations.of(context).getTranslation('order_details.store_address'),
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF3F3F3F),),
                  ),
                  Text(
                    AppLocalizations.of(context).getTranslation('order_details.delivery_address'),
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
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10, right: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            (ordersStoryModelItem.productsData.store != null)
                                ? ordersStoryModelItem.routes[0].unrestrictedValue
                                : 'Пусто',
                            style: TextStyle(fontSize: 12, color: Color(0xFFB0B0B0)),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            (ordersStoryModelItem.productsData.store != null && ordersStoryModelItem.routes.length > 1)
                                ?  ordersStoryModelItem.routes[1].unrestrictedValue
                                : 'Пусто',
                            style: TextStyle(fontSize: 12, color: Color(0xFFB0B0B0),),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: (in_the_way
                  .contains(ordersStoryModelItem.state)) ? Padding(
                padding: EdgeInsets.only(right: 0, bottom: 5, left: 0),
                child: Text('Курьер на' + ' ' + ordersStoryModelItem.driver.color + ' ' + ordersStoryModelItem.driver.car + ' ' + ordersStoryModelItem.driver.regNumber,
                  style: TextStyle(color: Color(0xFF000000), fontSize: 14, fontWeight: FontWeight.w500)),
              ) : Container(height: 0),
            ),
            (in_the_way.contains(ordersStoryModelItem.state)) ? GestureDetector(
              child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 42,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0xFFF6F6F6)),
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, right: 10, bottom: 5, left: 10),
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 75, top: 5),
                            child: SvgPicture.asset('assets/svg_images/message_icon.svg'),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 20, top: 3, left: 110),
                            child: Text(
                              'Чат с курьером',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          FutureBuilder(future: ordersStoryModelItem.hasNewMessage(),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if(snapshot.connectionState == ConnectionState.done && snapshot.data){
                                return Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 189, bottom: 0),
                                    child: SvgPicture.asset('assets/svg_images/chat_circle.svg'),
                                  ),
                                );
                              }
                              return Container(height: 0);
                            },
                          ),
                        ],
                      ),
                    ),
                  )
              ),
              onTap: (){
                Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new ChatScreen(order_uuid: ordersStoryModelItem.uuid, key: chatKey),
                  ),
                );
              },
            ): Container(height: 0,),
          ],
        ),
      ),
    ));
    ordersStoryModelItem.productsData.products.forEach((product) {
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
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
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
                  Padding(
                    padding: EdgeInsets.only(left: 100),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            product.name,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 14.0,
                                color: Color(0xFF000000)),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        (product.selectedVariant != null)
                            ? Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            product.selectedVariant.name,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 10.0,
                                color: Colors.grey),
                            textAlign: TextAlign.start,
                          ),
                        ) : Text(''),
                        (product.toppings != null)
                            ? Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: List.generate(
                                product.toppings.length,
                                    (index) => Text(
                                  product.toppings[index]
                                      .name,
                                  style: TextStyle(
                                      decoration:
                                      TextDecoration.none,
                                      fontSize: 10.0,
                                      color: Colors.grey),
                                  textAlign: TextAlign.start,
                                )),
                          ),
                        )
                            : Text(''),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Column(
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
                            '${product.number}' + AppLocalizations.of(context).getTranslation('order_details.items_quantity'),
                            style: TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Divider(color: Color(0xFFE6E6E6)),
          ),
        ],
      ));
    });
    double own_delivery_price = totalPrice - ordersStoryModelItem.tariff.totalPrice;
    (ordersStoryModelItem.ownDelivery != null && ordersStoryModelItem.ownDelivery) ? result.add(Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15, bottom: 20, top: 10),
              child: Text(
                AppLocalizations.of(context).getTranslation('cart_screen.total'),
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
                  AppLocalizations.of(context).getTranslation('cart_screen.delivery_title'),
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
                AppLocalizations.of(context).getTranslation('cart_screen.total'),
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


  callTo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Container(
                height: 210,
                width: 315,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 20, bottom: 20),
                      child: Text(
                        'Кому вы хотите позвонить?',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF424242)),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    InkWell(
                      child: Container(
                        child: Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 20, left: 15),
                            child: Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                    'assets/svg_images/call_to_restaurant.svg'),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'В заведение',
                                    style: TextStyle(
                                        fontSize: 17, color: Color(0xFF424242)),
                                  ),
                                )
                              ],
                            )
                        ),
                      ),
                      onTap: () {
                        launch("tel://" + ordersStoryModelItem.productsData.store.phone);
                      },
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    InkWell(
                      child: Container(
                        child: Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 20, left: 15),
                            child: Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                    'assets/svg_images/call_to_driver.svg'),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'Водителю',
                                    style: TextStyle(
                                        fontSize: 17, color: Color(0xFF424242)),
                                  ),
                                )
                              ],
                            )
                        ),
                      ),
                      onTap: () {
                        launch("tel://" + ordersStoryModelItem.driver.phone);
                      },
                    )
                  ],
                )),
          ),
        );
      },
    );
  }


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
              padding: EdgeInsets.only(top: 30, bottom: 10),
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
                          AppLocalizations.of(context).getTranslation('order_details.title'),
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
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Divider(height: 1.0, color: Colors.grey),
            ),
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
                            color: Color(0xFF09B44D),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).getTranslation('order_details.repeat_button'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,),
                            ),
                          )),
                      onTap: () async {
                        if (await Internet.checkConnection()) {
                          Records restaurant = ordersStoryModelItem.productsData.store;
                          currentUser.cartDataModel.cart.clear();
                          ordersStoryModelItem.productsData.products
                              .forEach((Product element) {
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
                              return new CartPageScreen(restaurant: restaurant);
                            }),
                          );
                        } else {
                          noConnection(context);
                        }
                      },
                    ) : (!not_cancel_state.contains(ordersStoryModelItem.state)) ?  GestureDetector(
                      child: Container(
                          height: 50,
                          width: 340,
                          decoration: BoxDecoration(
                            color: Color(0xFFFE534F),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).getTranslation('order_details.cancel_button'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,),
                            ),
                          )),
                      onTap: () async {
                        if (await Internet.checkConnection()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) {
                              return OrderRejectScreen(ordersStoryModelItem: ordersStoryModelItem,);
                            }),
                          );
                        } else {
                          noConnection(context);
                        }
                      },
                    ): (in_the_way.contains(ordersStoryModelItem.state)) ? Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, right: 5, left: 5),
                            child: (in_the_way.contains(ordersStoryModelItem.state))
                                ? Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(11)),
                                  color: Color(0xFF09B44D)),
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 5, right: 0, bottom: 5, left: 0),
                                  child:  Center(
                                    child: Text(
                                      'Позвонить',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white
                                      ),
                                    ),
                                  )
                              ),
                            )
                                : Container(),
                          ),
                          onTap: () {
                            if(Platform.isIOS){
                              return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.48),
                                    child: Column(
                                      children: [
                                        Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                            child: Container(
                                              height: 180,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                                                    child: Text('Кому вы хотите позвонить?',
                                                      style: TextStyle(
                                                          fontSize: 20
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(color: Colors.grey,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                                                    child: InkWell(
                                                      child: Container(
                                                        height: 30,
                                                        width: 140,
                                                        child: Center(
                                                          child: Text("В заведение",
                                                            style: TextStyle(
                                                                color: Color(0xFF007AFF),
                                                                fontSize: 20
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        launch("tel://" + ordersStoryModelItem.productsData.store.phone);
                                                      },
                                                    ),
                                                  ),
                                                  Divider(color: Colors.grey,),
                                                  InkWell(
                                                    child: Container(
                                                      padding: EdgeInsets.only(top: 8),
                                                      height: 30,
                                                      width: 100,
                                                      child: Center(
                                                        child: Text("Водителю",
                                                          style: TextStyle(
                                                              color: Color(0xFF007AFF),
                                                              fontSize: 20
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      launch("tel://" + ordersStoryModelItem.driver.phone);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )
                                        ),
                                        Container(
                                          child: Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                            child: InkWell(
                                              child: Container(
                                                height: 40,
                                                width: 100,
                                                child: Center(
                                                  child: Text("Отмена",
                                                    style: TextStyle(
                                                        color: Color(0xFFDC634A),
                                                        fontSize: 20
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onTap: (){
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                            callTo(context);
                          },
                        )) : Container(),
                  )),
            ),
            Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
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
                              AppLocalizations.of(context).getTranslation('order_details.delete_button'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,),
                            ),
                          )),
                    ) : Container(height: 0,),
                  )),
            )
          ],
        ));
  }
}

class OrderRejectScreen extends StatefulWidget {
  final OrdersStoryModelItem ordersStoryModelItem;
  OrderRejectScreen({Key key, this.ordersStoryModelItem}) : super(key: key);

  @override
  OrderRejectScreenState createState() {
    return new OrderRejectScreenState(ordersStoryModelItem);
  }
}

class OrderRejectScreenState extends State<OrderRejectScreen> {
  final OrdersStoryModelItem ordersStoryModelItem;
  OrderRejectScreenState(this.ordersStoryModelItem);

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Container(
              height: 100,
              width: 320,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 20, bottom: 20, right: 10),
                    child: Center(
                      child: Text(
                        'Отмена заказа',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF424242)),
                      ),
                    ),
                  ),
                  Center(
                    child: SpinKitThreeBounce(
                      color: Colors.green,
                      size: 20.0,
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    double toppingsCost = 0;
    return Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    child: Container(
                        height: 50,
                        width: 60,
                        child: Padding(
                          padding: EdgeInsets.only(top: 12, bottom: 12, right: 15),
                          child: Center(
                            child:SvgPicture.asset(
                                'assets/svg_images/arrow_left.svg'),
                          ),
                        )
                    ),
                    onTap: () async {
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.35),
                    child: Text('Отмена заказа',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF424242))),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
              child: Text('Почему вы решили отменить заказ?',style: TextStyle(fontSize: 18, color: Color(0xFF424242))),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView(
                padding: EdgeInsets.zero,
                children: List.generate(5,(index){
                  return Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 15, right: 15),
                    child: Container(
                        width: 345,
                        height: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFE6E6E6)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Align(alignment: Alignment.centerLeft,child: Text('Заказал случайно', textAlign: TextAlign.start,)),
                        )
                    ),
                  );
                }),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: GestureDetector(
                    child: Container(
                        height: 50,
                        width: 340,
                        decoration: BoxDecoration(
                          color: Color(0xFFFE534F),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                            'Оменить заказ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,),
                          ),
                        )),
                    onTap: () async {
                      if (await Internet.checkConnection()) {
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
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}