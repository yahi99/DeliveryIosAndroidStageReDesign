import 'package:flutter/material.dart';
import 'package:flutter_app/GetData/getImage.dart';
import 'package:flutter_app/Internet/check_internet.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/models/ResponseData.dart';
import 'package:flutter_app/models/RestaurantDataItems.dart';
import 'package:flutter_app/models/amplitude.dart';
import 'package:flutter_app/models/order.dart';
import 'package:flutter_svg/svg.dart';
import 'address_screen.dart';
import 'auth_screen.dart';
import 'home_screen.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key, this.restaurant}) : super(key: key);
  final Records restaurant;

  @override
  _CartScreenState createState() => _CartScreenState(restaurant);
}

class _CartScreenState extends State<CartScreen> {
  String title;
  String category;
  String description;
  String price;
  String discount;
  final Records restaurant;
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();
  double total;
  bool delete = false;
  GlobalKey<PriceFieldState> priceFieldKey =
  new GlobalKey<PriceFieldState>();

  _CartScreenState(this.restaurant);

  _buildList() {
    double totalPrice = 0;
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
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: currentUser.cartDataModel.cart.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < currentUser.cartDataModel.cart.length) {
            Order order = currentUser.cartDataModel.cart[index];
            return Dismissible(
              key: Key(currentUser.cartDataModel.cart[index].food.uuid),
              background: Container(
                alignment: AlignmentDirectional.centerEnd,
                color: Colors.red,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (direction) {
                AmplitudeAnalytics.analytics.logEvent('remove_from_cart ', eventProperties: {
                  'uuid': currentUser.cartDataModel.cart[index].food.uuid
                });
                setState(() {
                  currentUser.cartDataModel.cart.removeAt(index);
                  currentUser.cartDataModel.saveData();
                });
                if (currentUser.cartDataModel.cart.length == 0) {
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
                child: _buildCartItem(order),
              ),
            );
          }
          return Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Итого',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF000000)),
                      ),
                      Text('${totalPrice.toStringAsFixed(0)} \₽',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Color(0xFF000000))),
                    ],
                  ),
                  SizedBox(height: 80.0)
                ],
              ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1.0,
            color: Color(0xFFF5F5F5),
          );
        },
      ),
    );
  }

  _buildCartItem(Order order) {
    double toppingsCost = 0;
    if(order.food.toppings != null){
      order.food.toppings.forEach((element) {
        toppingsCost += order.quantity * element.price;
      });
    }
    GlobalKey<CounterState> counterKey = new GlobalKey();
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Row(
                children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(left: 8.0),
                     child: ClipRRect(
                         borderRadius: BorderRadius.only(
                             bottomLeft: Radius.circular(10),
                             topLeft: Radius.circular(10),
                             topRight: Radius.circular(10),
                             bottomRight: Radius.circular(10)),
                         child: Hero(
                           tag: order.food.name,
                           child: Image.network(
                             getImage(order.food.image),
                             fit: BoxFit.cover,
                             height: 70,
                             width: 70,
                           ),)),
                   ),
                  Column(
                    children: [
                      (order.food.variants == null || order.food.toppings == null ||
                          order.food.variants == null && order.food.toppings == null) ? Container(
                        child: Padding(
                            padding: const EdgeInsets.only(left: 15.0, top: 27),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    order.food.name,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 14.0,
                                        color: Color(0xFF000000)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                (order.food.variants != null)
                                    ? Align(
                                  alignment: Alignment.topLeft,
                                      child: Text(
                                  order.food.variants[0].name,
                                  style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 10.0,
                                        color: Colors.grey),
                                  textAlign: TextAlign.start,
                                ),
                                    ) : Text(''),
                                (order.food.toppings != null)
                                    ? Column(
                                  children: List.generate(
                                      order.food.toppings.length,
                                          (index) => Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          order.food.toppings[index]
                                              .name,
                                          style: TextStyle(
                                              decoration:
                                              TextDecoration.none,
                                              fontSize: 10.0,
                                              color: Colors.grey),
                                          textAlign: TextAlign.start,
                                        ),
                                      )),
                                )
                                    : Text(''),
                              ],
                            )
                        )
                      ) : Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 15, bottom: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  order.food.name,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 14.0,
                                      color: Color(0xFF000000)),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              (order.food.variants != null)
                                  ? Align(
                                alignment: Alignment.topLeft,
                                    child: Text(
                                order.food.variants[0].name,
                                style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontSize: 10.0,
                                      color: Colors.grey),
                                textAlign: TextAlign.start,
                              ),
                                  ) : Text(''),
                              (order.food.toppings != null)
                                  ? Column(
                                children: List.generate(
                                    order.food.toppings.length,
                                        (index) => Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        order.food.toppings[index]
                                            .name,
                                        style: TextStyle(
                                            decoration:
                                            TextDecoration.none,
                                            fontSize: 10.0,
                                            color: Colors.grey),
                                        textAlign: TextAlign.start,
                                      ),
                                    )),
                              )
                                  : Text(''),
                            ],
                          )
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Counter(
                            key: counterKey,
                            priceFieldKey: priceFieldKey
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: PriceField(key: priceFieldKey, order: order)
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
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
                      onTap: () {
                        setState(() {
                          AmplitudeAnalytics.analytics.logEvent('remove_from_cart_all');
                          currentUser.cartDataModel.cart.clear();
                          currentUser.cartDataModel.saveData();
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
    double totalPrice = 0;
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
    return new Scaffold(
      key: _scaffoldStateKey,
      body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                        onTap: () => Navigator.pop(context),
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
                        restaurant.name,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3F3F3F)),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          child: SvgPicture.asset(
                              'assets/svg_images/del_basket.svg'),
                          onTap: () {
                            showAlertDialog(context);
                          },
                        )),
                  ],
                ),
              ),
              Container(
                color: Color(0xFFF5F5F5),
                height: 10,
                width: MediaQuery.of(context).size.width,
              ),
              _buildList(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                  EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                                '${totalPrice.toStringAsFixed(0)} \₽',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              (restaurant.order_preparation_time_second != null)? '~' + '${restaurant.order_preparation_time_second ~/ 60} мин' : '',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      FlatButton(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 15,
                          ),
                          child: Text('Далее',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ),
                        color: Color(0xFFFE534F),
                        splashColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.only(
                            left: 70, top: 20, right: 70, bottom: 20),
                        onPressed: () async {
                          if (await Internet.checkConnection()) {
                            if (currentUser.isLoggedIn) {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                    new PageScreen(restaurant: restaurant)),
                              );
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
            ],
          )),
    );
  }
}

class Counter extends StatefulWidget {
  GlobalKey<PriceFieldState> priceFieldKey;
  Counter({Key key, this.priceFieldKey}) : super(key: key);

  @override
  CounterState createState() {
    return new CounterState(priceFieldKey);
  }
}

class CounterState extends State<Counter> {
  GlobalKey<PriceFieldState> priceFieldKey;
  CounterState(this.priceFieldKey);

  int counter = 1;

  // ignore: non_constant_identifier_names
  void _incrementCounter_plus() {
    setState(() {
      counter++;
      if(priceFieldKey.currentState != null){
        priceFieldKey.currentState.setCount(counter);
      }
    });
  }

  // ignore: non_constant_identifier_names
  void _incrementCounter_minus() {
    setState(() {
      counter--;
      if(priceFieldKey.currentState != null){
        priceFieldKey.currentState.setCount(counter);
      }
    });
  }


  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: EdgeInsets.only(left: 0, top: 0, bottom: 0),
          child: InkWell(
            onTap: () {
              if (counter != 1) {
                _incrementCounter_minus();
                // counter = restaurantDataItems.records_count;
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8)),
              ),
              height: 40,
              width: 28,
              child: Padding(
                padding: EdgeInsets.all(7),
                child: SvgPicture.asset('assets/svg_images/mini_minus.svg'),
              ),
            ),
          ),
        ),
        Container(
          height: 30,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFE6E6E6)
          ),
          child: Padding(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: Center(
              child: Text(
                '$counter',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 0, top: 0, bottom: 0),
          child: InkWell(
            onTap: () async {
              if (await Internet.checkConnection()) {
                setState(() {
                  _incrementCounter_plus();
                  // counter = restaurantDataItems.records_count;
                });
              } else {
                noConnection(context);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
              ),
              height: 40,
              width: 28,
              child: Padding(
                padding: EdgeInsets.all(7),
                child: SvgPicture.asset('assets/svg_images/plus_counter.svg'),
              ),
            ),
          ),
        )
      ])
    );
  }

  void refresh() {
    setState(() {});
  }
}


class PriceField extends StatefulWidget {
  Order order;
  PriceField({Key key, this.order}) : super(key: key);

  @override
  PriceFieldState createState() {
    return new PriceFieldState(order);
  }
}

class PriceFieldState extends State<PriceField> {
  int count = 1;
  Order order;
  PriceFieldState(this.order);
  double totalPrice = 0;

  Widget build(BuildContext context) {
    double toppingsCost = 0;
    if(order.food.toppings != null){
      order.food.toppings.forEach((element) {
        toppingsCost += order.quantity * element.price;
      });
      totalPrice += toppingsCost;
    }
    return Padding(
      padding: EdgeInsets.only(right: 15),
      child: Text('${(order.food.variants != null && order.food.variants.length > 0 && order.food.variants[0].price != null) ?
      (order.quantity * (order.food.price + order.food.variants[0].price) + toppingsCost).toStringAsFixed(0) :
      (order.quantity * order.food.price + toppingsCost).toStringAsFixed(0)} \₽',
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

class EmptyCartScreen extends StatefulWidget {
  final Records restaurant;

  EmptyCartScreen({Key key, this.restaurant}) : super(key: key);

  @override
  EmptyCartScreenState createState() {
    return new EmptyCartScreenState(restaurant);
  }
}

class EmptyCartScreenState extends State<EmptyCartScreen> {
  final Records restaurant;

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
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                                    (Route<dynamic> route) => false);
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
                          child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                              child: GestureDetector(
                                child: SvgPicture.asset(
                                    'assets/svg_images/delete.svg'),
                              ))),
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
                      color: Color(0xFFFE534F),
                      splashColor: Colors.redAccent,
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