import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Internet/check_internet.dart';
import 'package:flutter_app/Screens/AuthScreen/View/auth_screen.dart';
import 'package:flutter_app/Screens/CartScreen/API/clear_cart.dart';
import 'package:flutter_app/Screens/CartScreen/API/decriment_cart_item.dart';
import 'package:flutter_app/Screens/CartScreen/API/delete_item_from_cart.dart';
import 'package:flutter_app/Screens/CartScreen/API/increment_cart_item_count.dart';
import 'package:flutter_app/Screens/CartScreen/Model/CartModel.dart';
import 'package:flutter_app/Screens/HomeScreen/Model/FilteredStores.dart';
import 'package:flutter_app/Screens/HomeScreen/View/home_screen.dart';
import 'package:flutter_app/Screens/OrderConfirmationScreen/View/address_screen.dart';
import 'package:flutter_app/Screens/OrdersScreen/Model/order.dart';
import 'package:flutter_app/Screens/RestaurantScreen/View/restaurant_screen.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/models/ResponseData.dart';
import 'package:flutter_app/models/RestaurantDataItems.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io' show Platform;

import '../../../Amplitude/amplitude.dart';


class CartPageScreen extends StatefulWidget {
  final FilteredStores restaurant;
  CartPageScreen({
    Key key,
    this.restaurant,
  }) : super(key: key);

  @override
  CartPageState createState() => CartPageState(restaurant);
}

class CartPageState extends State<CartPageScreen> {
  final FilteredStores restaurant;

  int selectedPageId = 0;
  GlobalKey<CartScreenState> cartTakeAwayScreenKey = new GlobalKey<CartScreenState>();
  GlobalKey<CartScreenState> cartScreenKey = new GlobalKey<CartScreenState>();
  TotalPrice totalPriceWidget = new TotalPrice(key: new GlobalKey(),);

  int selectedPaymentId = 0;

  CartPageState(this.restaurant);

  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.black, // Color for Android
        statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
    ));
  }


  @override
  Widget build(BuildContext context) {
    FocusNode focusNode;
    double totalPrice = 0;
    // currentUser.cartModel.cart.forEach(
    //         (Order order) {
    //       if(order.food.variants != null && order.food.variants.length > 0 && order.food.variants[0].price != null){
    //         totalPrice += order.quantity * (order.food.price + order.food.variants[0].price);
    //       }else{
    //         totalPrice += order.quantity * order.food.price;
    //       }
    //       double toppingsCost = 0;
    //       if(order.food.toppings != null){
    //         order.food.toppings.forEach((element) {
    //           toppingsCost += order.quantity * element.price;
    //         });
    //         totalPrice += toppingsCost;
    //       }
    //     }
    // );
    var cartScreen = CartScreen(restaurant: restaurant, key: cartScreenKey, parent: this, isTakeAwayScreen: false,);
    var cartTakeAwayScreen = CartScreen(restaurant: restaurant, key: cartTakeAwayScreenKey, parent: this, isTakeAwayScreen: true,);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light
      ),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 15),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                     InkWell(
                         onTap: () => Navigator.of(context).pushAndRemoveUntil(
                             PageRouteBuilder(
                                 pageBuilder: (context, animation, anotherAnimation) {
                                   return RestaurantScreen(restaurant: restaurant,);
                                 },
                                 transitionDuration: Duration(milliseconds: 300),
                                 transitionsBuilder:
                                     (context, animation, anotherAnimation, child) {
                                   return SlideTransition(
                                     position: Tween(
                                         begin: Offset(1.0, 0.0),
                                         end: Offset(0.0, 0.0))
                                         .animate(animation),
                                     child: child,
                                   );
                                 }
                             ), (Route<dynamic> route) => false),
                         child: Container(
                             height: 40,
                             width: 60,
                             child: Padding(
                               padding: EdgeInsets.only(
                                   top: 12, bottom: 12, right: 25),
                               child: SvgPicture.asset(
                                   'assets/svg_images/arrow_left.svg'),
                             ))),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          'Корзина',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3F3F3F)),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 13),
                          child: GestureDetector(
                            child: SvgPicture.asset(
                                'assets/svg_images/del_basket.svg'),
                            onTap: () {
                              if(Platform.isIOS){
                                return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.65),
                                      child: Stack(
                                        children: [
                                          Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                            child: InkWell(
                                              child: Container(
                                                height: 50,
                                                width: 100,
                                                child: Center(
                                                  child: Text("Очистить корзину",
                                                    style: TextStyle(
                                                        color: Color(0xFFFF3B30),
                                                        fontSize: 20
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onTap: () async {
                                                currentUser.cartModel = await clearCart(necessaryDataForAuth.device_id);
                                                setState(() {
                                                  AmplitudeAnalytics.analytics.logEvent('remove_from_cart_all');
                                                });
                                                Navigator.pushReplacement(
                                                  context,
                                                  new MaterialPageRoute(
                                                    builder: (context) =>
                                                    new EmptyCartScreen(restaurant: restaurant),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 120),
                                            child: Dialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                              child: InkWell(
                                                child: Container(
                                                  height: 50,
                                                  width: 100,
                                                  child: Center(
                                                    child: Text("Отмена",
                                                      style: TextStyle(
                                                          color: Color(0xFF007AFF),
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
                              }else{
                                return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 0),
                                      child: Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                        child: Container(
                                            height: 130,
                                            width: 300,
                                            child: Column(
                                              children: <Widget>[
                                                InkWell(
                                                  child: Container(
                                                    padding: EdgeInsets.only(top: 20, bottom: 20),
                                                    child: Center(
                                                      child: Text("Очистить корзину",
                                                        style: TextStyle(
                                                            color: Color(0xFFFF3B30),
                                                            fontSize: 20
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    currentUser.cartModel = await clearCart(necessaryDataForAuth.device_id);
                                                    setState(() {
                                                      AmplitudeAnalytics.analytics.logEvent('remove_from_cart_all');
                                                    });
                                                    Navigator.pushReplacement(
                                                      context,
                                                      new MaterialPageRoute(
                                                        builder: (context) =>
                                                        new EmptyCartScreen(restaurant: restaurant),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Divider(
                                                  height: 1,
                                                  color: Colors.grey,
                                                ),
                                                InkWell(
                                                  child: Container(
                                                    padding: EdgeInsets.only(top: 20, bottom: 20),
                                                    child: Center(
                                                      child: Text("Отмена",
                                                        style: TextStyle(
                                                            color: Color(0xFF007AFF),
                                                            fontSize: 20
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: (){
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            )),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Color(0xFF09B44D),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(left: 0,
                              right: 0),
                          child: Container(
                            height: 40,
                            width: 176,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
                              color: (selectedPageId == 0) ? Color(0xFF09B44D) : Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 0, right: 0, top: 0),
                              child: Center(
                                child: Text(
                                  'Доставка',
                                  style: TextStyle(
                                      color: (selectedPageId == 0) ? Colors.white : Color(0xFF09B44D), fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: () async {
                          if (await Internet.checkConnection()) {
                            _controller.jumpToPage(0);
                          } else {
                            noConnection(context);
                          }
                        },
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(left: 0,
                              right: 0),
                          child: Container(
                            height: 40,
                            width: 172,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)),
                              color: (selectedPageId == 1) ? Color(0xFF09B44D) : Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 0, right: 0, top: 0),
                              child: Center(
                                child: Text(
                                  'Самовывоз',
                                  style: TextStyle(
                                      color: (selectedPageId == 1) ? Colors.white : Color(0xFF09B44D), fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: () async {
                          if (await Internet.checkConnection()) {
                            _controller.jumpToPage(1);
                          } else {
                            noConnection(context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _controller,
                  children: [cartScreen, cartTakeAwayScreen],
                  onPageChanged: (int pageId) {
                    setState(() {
                      selectedPageId = pageId;
                    });
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 1
                        )
                      ]
                  ),
                  child: Padding(
                    padding:
                    EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            children: [
                              totalPriceWidget,
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  '000',
                                  // (restaurant.order_preparation_time_second != null)? '~' + '${restaurant.order_preparation_time_second ~/ 60} мин' : '',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FlatButton(
                          child: Text('Далее',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white)),
                          color: Color(0xFF09B44D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.only(
                              left: 70, top: 20, right: 70, bottom: 20),
                          onPressed: () async {
                            if (await Internet.checkConnection()) {
                              if (currentUser.isLoggedIn) {
                                if(selectedPageId == 0){
                                  Navigator.of(context).push(
                                      PageRouteBuilder(
                                          pageBuilder: (context, animation, anotherAnimation) {
                                            return AddressScreen(restaurant: restaurant);
                                          },
                                          transitionDuration: Duration(milliseconds: 300),
                                          transitionsBuilder:
                                              (context, animation, anotherAnimation, child) {
                                            return SlideTransition(
                                              position: Tween(
                                                  begin: Offset(-1.0, 0.0),
                                                  end: Offset(0.0, 0.0))
                                                  .animate(animation),
                                              child: child,
                                            );
                                          }
                                      ));
                                }else{
                                  Navigator.of(context).push(
                                      PageRouteBuilder(
                                          pageBuilder: (context, animation, anotherAnimation) {
                                            return TakeAway(restaurant: restaurant);
                                          },
                                          transitionDuration: Duration(milliseconds: 300),
                                          transitionsBuilder:
                                              (context, animation, anotherAnimation, child) {
                                            return SlideTransition(
                                              position: Tween(
                                                  begin: Offset(-1.0, 0.0),
                                                  end: Offset(0.0, 0.0))
                                                  .animate(animation),
                                              child: child,
                                            );
                                          }
                                      ));
                                }
                              } else {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new AuthScreen()),
                                );
                              }
                            } else {
                              noConnection(context);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  CartScreen({Key key, this.restaurant, this.parent, this.isTakeAwayScreen}) : super(key: key);
  final FilteredStores restaurant;
  CartPageState parent;
  bool isTakeAwayScreen;

  @override
  CartScreenState createState() => CartScreenState(restaurant, parent, isTakeAwayScreen);
}

class CartScreenState extends State<CartScreen> {
  String title;
  String category;
  String description;
  String price;
  String discount;
  CartPageState parent;
  final FilteredStores restaurant;
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();
  GlobalKey<TotalPriceState> totalPriceKey;
  List<TotalPrice> totalPrices;
  double total;
  bool delete = false;
  bool isTakeAwayScreen;

  showCartItemDeleteDialogAlertDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Container(
                height: 202,
                width: 300,
                child: Column(
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        child: Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Center(
                              child: Text(
                                'Удалить',
                                style: TextStyle(
                                    color: Color(0xFFFF0600),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      onTap: () {
                        setState(() {
                          AmplitudeAnalytics.analytics.logEvent('remove_from_cart_all');
                          // currentUser.cartModel.cart.clear();
                          // currentUser.cartModel.saveData();
                        });
                        Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                            builder: (context) =>
                            new EmptyCartScreen(restaurant: restaurant),
                          ),
                        );
                      },
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    InkWell(
                      child: Container(
                        child: Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Center(
                              child: Text(
                                'Отмена',
                                style: TextStyle(
                                    fontSize: 17, color: Color(0xFF424242)),
                              ),
                            )),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )),
          ),
        );
      },
    );
  }


  CartScreenState(this.restaurant, this.parent, this.isTakeAwayScreen);

  _buildList() {
    if(currentUser.cartModel == null || currentUser.cartModel.items.length == 0){
      return Container();
    }
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: currentUser.cartModel.items.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < currentUser.cartModel.items.length) {
            Item order = currentUser.cartModel.items[index];
            return Dismissible(
              key: Key(currentUser.cartModel.items[index].product.uuid),
              background: Container(
                alignment: AlignmentDirectional.centerEnd,
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: SvgPicture.asset('assets/svg_images/del_basket.svg'),
                )
              ),
              onDismissed: (direction) async {
                AmplitudeAnalytics.analytics.logEvent('remove_from_cart ', eventProperties: {
                  'uuid': currentUser.cartModel.items[index].product.uuid
                });
                await deleteItemFromCart(necessaryDataForAuth.device_id, currentUser.cartModel.items[index].id);
                setState(() {
                  if(parent.totalPriceWidget.key.currentState != null){
                    parent.totalPriceWidget.key.currentState.setState(() {

                    });
                  }
                });
                if (currentUser.cartModel.items.length == 0) {
                  Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                      builder: (context) =>
                      new EmptyCartScreen(restaurant: restaurant),
                    ),
                  );
                }
              },
              direction: DismissDirection.endToStart,
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: _buildCartItem(order, index),
              ),
            );
          }
          return Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  (isTakeAwayScreen) ? Container() : Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(
                                'Доставка',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color(0xFF000000)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, top: 5),
                                child: Text(
                                   (currentUser.cartModel.cookingPromiseTime != null)? '~' + '${currentUser.cartModel.cookingPromiseTime ~/ 60} мин' : '',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            (currentUser.cartModel.deliveryPrice != null)? '~' + '${currentUser.cartModel.deliveryPrice} \₽' : '',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFF000000)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20, top: 20),
                    child: Divider(
                      height: 1,
                      color: Color(0xFFE6E6E6),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Итого',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Color(0xFF000000)),
                        ),
                        Text((currentUser.cartModel.totalPrice != null)? '~' + '${currentUser.cartModel.totalPrice} \₽' : '')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 20),
                    child: Divider(
                       height: 1,
                      color: Color(0xFFE6E6E6),
                    ),
                  ) ,
                  SizedBox(height: 80.0)
                ],
              ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Divider(
              height: 1,
              color: Color(0xFFE6E6E6),
            )
          );
        },
      ),
    );
  }

  _buildCartItem(Item order, int index) {
    GlobalKey<CounterState> counterKey = new GlobalKey();
    GlobalKey<PriceFieldState> priceFieldKey =
    new GlobalKey<PriceFieldState>();
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
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
                getImage((order.product.meta.images != null && order.product.meta.images.length != 0) ? order.product.meta.images[0] : null ),
                fit: BoxFit.cover,
                height: 70,
                width: 70,
              ),),
          ),
          Padding(
            padding: EdgeInsets.only(left: 85),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      order.product.name,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 14.0,
                          color: Color(0xFF000000)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                (order.variantGroups != null)
                    ? Column(
                  children: List.generate(
                    order.variantGroups.length,
                      (index){
                        return Column(
                          children: List.generate(
                            order.variantGroups[index].variants.length,
                              (variantsIndex){
                                return Align(
                                  child: Text(order.variantGroups[index].variants[variantsIndex].name),
                                );
                              }
                          )
                        );
                      }
                  ),
                ) : Container(height: 0,),
                Counter(
                  key: counterKey,
                  priceFieldKey: priceFieldKey,
                  order: order,
                  totalPriceList: totalPrices,
                  parent: this,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Column(
              children: [
                PriceField(key: priceFieldKey, order: currentUser.cartModel),
                GestureDetector(
                  child: SvgPicture.asset(
                      'assets/svg_images/del_basket.svg'),
                  onTap: () {
                    if(Platform.isIOS){
                      return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.65),
                            child: Stack(
                              children: [
                                Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                  child: InkWell(
                                    child: Container(
                                      height: 50,
                                      width: 700,
                                      child: Center(
                                        child: Text("Удалить",
                                          style: TextStyle(
                                              color: Color(0xFFFF3B30),
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      currentUser.cartModel = await deleteItemFromCart(necessaryDataForAuth.device_id, order.id);
                                      Navigator.pop(context);
                                      setState(() {
                                        // if(parent.totalPriceWidget.key.currentState != null){
                                        //   parent.totalPriceWidget.key.currentState.setState(() {
                                        //
                                        //   });
                                        // }
                                      });
                                      if (currentUser.cartModel.items.length == 0) {
                                        Navigator.pushReplacement(
                                          context,
                                          new MaterialPageRoute(
                                            builder: (context) =>
                                            new EmptyCartScreen(restaurant: restaurant),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 120),
                                  child: Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                    child: InkWell(
                                      child: Container(
                                        height: 50,
                                        width: 700,
                                        child: Center(
                                          child: Text("Отмена",
                                            style: TextStyle(
                                                color: Color(0xFF007AFF),
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
                    }else{
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 0),
                            child: Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
                              child: Container(
                                  height: 130,
                                  width: 300,
                                  child: Column(
                                    children: <Widget>[
                                      InkWell(
                                        child: Container(
                                          padding: EdgeInsets.only(top: 20, bottom: 20),
                                          child: Center(
                                            child: Text("Удалить",
                                              style: TextStyle(
                                                  color: Color(0xFFFF3B30),
                                                  fontSize: 20
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () async {
                                          currentUser.cartModel = await deleteItemFromCart(necessaryDataForAuth.device_id, order.id);
                                          Navigator.pop(context);
                                          setState(() {
                                            // if(parent.totalPriceWidget.key.currentState != null){
                                            //   parent.totalPriceWidget.key.currentState.setState(() {
                                            //
                                            //   });
                                            // }
                                          });
                                          if (currentUser.cartModel.items.length == 0) {
                                            Navigator.pushReplacement(
                                              context,
                                              new MaterialPageRoute(
                                                builder: (context) =>
                                                new EmptyCartScreen(restaurant: restaurant),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      Divider(
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                      InkWell(
                                        child: Container(
                                          padding: EdgeInsets.only(top: 20, bottom: 20),
                                          child: Center(
                                            child: Text("Отмена",
                                              style: TextStyle(
                                                  color: Color(0xFF007AFF),
                                                  fontSize: 20
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  )),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Container(
                height: 202,
                width: 300,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 20, bottom: 20),
                      child: Text(
                        'Вы действительно хотите\nотчистить корзину?',
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
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Center(
                              child: Text(
                                'Очистить',
                                style: TextStyle(
                                    color: Color(0xFFFF0600),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      onTap: () async {
                        await clearCart(necessaryDataForAuth.device_id);
                        setState(() {
                          AmplitudeAnalytics.analytics.logEvent('remove_from_cart_all');
                        });
                        Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                            builder: (context) =>
                            new EmptyCartScreen(restaurant: restaurant),
                          ),
                        );
                      },
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    InkWell(
                      child: Container(
                        child: Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Center(
                              child: Text(
                                'Отмена',
                                style: TextStyle(
                                    fontSize: 17, color: Color(0xFF424242)),
                              ),
                            )),
                      ),
                      onTap: () {
                        Navigator.pop(context);
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
    totalPrices = new List<TotalPrice>();
    totalPrices.add(new TotalPrice(key: new GlobalKey(),));
    totalPrices.add(new TotalPrice(key: new GlobalKey(),));
    totalPrices.add(parent.totalPriceWidget);
    return WillPopScope(
     onWillPop: () async {
       Navigator.of(context).pushAndRemoveUntil(
           MaterialPageRoute(
               builder: (context) => RestaurantScreen(restaurant: restaurant,)),
               (Route<dynamic> route) => route.isFirst);
       return false;
     },
      child: new Scaffold(
        key: _scaffoldStateKey,
        body: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _buildList(),
              ],
            )),
      ),
    );
  }

  double getBasketButtonHeight(FoodRecords food){
    if(food.variants == null && food.toppings == null){
      return 25;
    }else if(food.variants != null && food.toppings == null){
      return 30;
    }else{
      return 50;
    }
  }
}


class Counter extends StatefulWidget {
  State parent;
  GlobalKey<PriceFieldState> priceFieldKey;
  Item order;
  List<TotalPrice> totalPriceList;
  Counter({Key key, this.priceFieldKey, this.order, this.totalPriceList, this.parent}) : super(key: key);

  @override
  CounterState createState() {
    return new CounterState(priceFieldKey, order, totalPriceList, parent);
  }
}

class CounterState extends State<Counter> {
  State parent;
  GlobalKey<PriceFieldState> priceFieldKey;
  List<TotalPrice> totalPriceList;
  Item order;
  CounterState(this.priceFieldKey, this.order, this.totalPriceList, this.parent);

  int counter;

  // ignore: non_constant_identifier_names
  Future<void> _incrementCounter_plus() async {

    currentUser.cartModel = await incrementCartItemCount(necessaryDataForAuth.device_id, order.id);
    parent.setState(() {

    });
    // setState(() {
    //   counter++;
    //   //updateCartItemQuantity();
    // });
  }

  // ignore: non_constant_identifier_names
  Future<void> _incrementCounter_minus() async {
    currentUser.cartModel = await decrementCartItem(necessaryDataForAuth.device_id, order.id);
    parent.setState(() {

    });
    // setState(() {
    //   counter--;
    //   //updateCartItemQuantity();
    // });
  }


  // void updateCartItemQuantity(){
  //   order.count = counter;
  //   priceFieldKey.currentState.setState(() {
  //
  //   });
  //   totalPriceList.forEach((totalPrice) {
  //     if(totalPrice.key.currentState != null)
  //       totalPrice.key.currentState.setState(() {
  //
  //       });
  //   });
  // }

  Widget build(BuildContext context) {
    counter = order.count;
    return Row(
        children: [
          InkWell(
            onTap: () async {
              if (counter != 1) {
                await _incrementCounter_minus();
                // counter = restaurantDataItems.records_count;
              }
            },
            child: SvgPicture.asset('assets/svg_images/rest_minus.svg'),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(right: 15, left: 15),
              child: Center(
                child: Text(
                  '$counter',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              if (await Internet.checkConnection()) {
                await _incrementCounter_plus();
                // setState(() {
                //
                //   // counter = restaurantDataItems.records_count;
                // });
              } else {
                noConnection(context);
              }
            },
            child: SvgPicture.asset('assets/svg_images/rest_plus.svg'),
          ),
        ]);
  }

  void refresh() {
    setState(() {});
  }
}


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

// ignore: must_be_immutable
class TotalPrice extends StatefulWidget {
  GlobalKey<TotalPriceState> key;
  TotalPrice({this.key}) : super(key: key);

  @override
  TotalPriceState createState() {
    return new TotalPriceState();
  }
}

class TotalPriceState extends State<TotalPrice> {

  TotalPriceState();

  Widget build(BuildContext context) {
    double totalPrice = 0;
    // currentUser.cartModel.cart.forEach(
    //         (Order order) {
    //       if(order.food.variants != null && order.food.variants.length > 0 && order.food.variants[0].price != null){
    //         totalPrice += order.quantity * (order.food.price + order.food.variants[0].price);
    //       }else{
    //         totalPrice += order.quantity * order.food.price;
    //       }
    //       double toppingsCost = 0;
    //       if(order.food.toppings != null){
    //         order.food.toppings.forEach((element) {
    //           toppingsCost += order.quantity * element.price;
    //         });
    //         totalPrice += toppingsCost;
    //       }
    //     }
    // );
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
          '${totalPrice.toStringAsFixed(0)} \₽',
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.black)),
    );
  }
}



class EmptyCartScreen extends StatefulWidget {
  final FilteredStores restaurant;

  EmptyCartScreen({Key key, this.restaurant}) : super(key: key);

  @override
  EmptyCartScreenState createState() {
    return new EmptyCartScreenState(restaurant);
  }
}

class EmptyCartScreenState extends State<EmptyCartScreen> {
  final FilteredStores restaurant;

  EmptyCartScreenState(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: InkWell(
                          onTap: () {
                            homeScreenKey = new GlobalKey<HomeScreenState>();
                            Navigator.of(context).pushAndRemoveUntil(
                                PageRouteBuilder(
                                    pageBuilder: (context, animation, anotherAnimation) {
                                      return HomeScreen();
                                    },
                                    transitionDuration: Duration(milliseconds: 300),
                                    transitionsBuilder:
                                        (context, animation, anotherAnimation, child) {
                                      return SlideTransition(
                                        position: Tween(
                                            begin: Offset(1.0, 0.0),
                                            end: Offset(0.0, 0.0))
                                            .animate(animation),
                                        child: child,
                                      );
                                    }
                                ), (Route<dynamic> route) => false);
                          },
                          child: Padding(
                              padding: EdgeInsets.only(right: 0),
                              child: Container(
                                  width: 40,
                                  height: 60,
                                  child: Center(
                                    child: SvgPicture.asset(
                                        'assets/svg_images/arrow_left.svg'),
                                  ))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: Text(
                          'Корзина',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF000000)),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: SvgPicture.asset(
                              'assets/svg_images/del_basket.svg'),),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 90),
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xFFFAFAFA)),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Center(
                            child: SvgPicture.asset(
                                'assets/svg_images/basket.svg'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Center(
                              child: Text(
                                'Корзина пуста',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Color(0xFF424242)),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 100),
                          child: Center(
                            child: Text(
                              'Перейдите в список мест, чтобы\nоформить заказ заново',
                              style:
                              TextStyle(color: Color(0xFFB0B0B0), fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding:
                    EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 15),
                    child: FlatButton(
                      child: Text(
                        'Вернуться на главную',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      color: Color(0xFF09B44D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.only(
                          left: 80, top: 20, right: 80, bottom: 20),
                      onPressed: () {
                        homeScreenKey = new GlobalKey<HomeScreenState>();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => HomeScreen()),
                                (Route<dynamic> route) => false);
                      },
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}