import 'package:flutter/material.dart';
import 'file:///C:/Users/79187/AndroidStudioProjects/DeliveryIosAndroidStageReDesign/lib/Screens/HomeScreen/API/getInitData.dart';
import 'package:flutter_app/Screens/OrdersScreen/Model/OrderStoryModel.dart';
import 'package:flutter_app/Screens/OrdersScreen/View/orders_details.dart';
import 'package:flutter_app/data/data.dart';
import 'file:///C:/Users/79187/AndroidStudioProjects/DeliveryIosAndroidStageReDesign/lib/Screens/HomeScreen/Model/InitData.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderChecking extends StatefulWidget {
  OrdersStoryModelItem ordersStoryModelItem;

  OrderChecking({Key key, this.ordersStoryModelItem}) : super(key: key);
  static var state_array = [
    'waiting_for_confirmation',
    'cooking',
    'offer_offered',
    'smart_distribution',
    'finding_driver',
    'offer_rejected',
    'order_start',
    'on_place',
    'on_the_way',
    'transferred_to_store',
    'order_payment'
  ];

  @override
  OrderCheckingState createState() {
    return new OrderCheckingState(ordersStoryModelItem);
  }

  static Future<List<OrderChecking>> getActiveOrder() async {
    List<OrderChecking> activeOrderList = new List<OrderChecking>();
    InitData initData = await getInitData();
    orderCheckingStates.clear();
    initData.ordersData
        .forEach((OrdersStoryModelItem element) {
      if (state_array.contains(element.state)) {
        print(element.uuid);
        GlobalKey<OrderCheckingState> key = new GlobalKey<OrderCheckingState>();
        orderCheckingStates[element.uuid] = key;
        activeOrderList.add(new OrderChecking(
          ordersStoryModelItem: element,
          key: key,
        ));
      }
    });
    return activeOrderList;
  }
}

class OrderCheckingState extends State<OrderChecking> with AutomaticKeepAliveClientMixin {
  OrdersStoryModelItem ordersStoryModelItem;
  @override
  bool get wantKeepAlive => true;

  OrderCheckingState(this.ordersStoryModelItem);

  @override
  Widget build(BuildContext context) {
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
    var take = ['order_payment'];

    if (!OrderChecking.state_array.contains(ordersStoryModelItem.state)) {
      return Container();
    }
    return InkWell(
      child: Container(
          width: 350,
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4.0, // soften the shadow
                  spreadRadius: 1.0, //extend the shadow
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(17.0),
              border: Border.all(width: 1.0, color: Colors.grey[200])),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Align(
                          child: Text(
                            'Ваш заказ из ' +
                                (ordersStoryModelItem.productsData != null
                                    ? ordersStoryModelItem.productsData.store.name
                                    : 'Пусто'),
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10, left: 20, bottom: 0),
                        child: InkWell(
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                color: Color(0xF6F6F6F6)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 7, top: 7, bottom: 5),
                                  child: SvgPicture.asset('assets/svg_images/i.svg'),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 7, bottom: 5),
                                    child: Text(
                                      'Заказ',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 13),
                                    )),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) {
                                return OrdersDetailsScreen(
                                    ordersStoryModelItem: ordersStoryModelItem);
                              }),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 5, left: 5),
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Color(0xFF09B44D)),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: SvgPicture.asset(
                                    'assets/svg_images/white_clock.svg'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text('Обработка',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10)),
                              )
                            ],
                          ),
                        ),
                      ),
                      (processing.contains(ordersStoryModelItem.state)) ? Center(
                        child: SpinKitThreeBounce(
                          color: Colors.green,
                          size: 20.0,
                        ),
                      ) : Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: SvgPicture.asset('assets/svg_images/ellipse.svg', color: Color(0xFF09B44D),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: SvgPicture.asset('assets/svg_images/ellipse.svg', color: Color(0xFF09B44D),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: SvgPicture.asset('assets/svg_images/ellipse.svg', color: Color(0xFF09B44D),),
                          ),
                        ],
                      ),
                      Padding(
                        padding: (ordersStoryModelItem.withoutDelivery) ? EdgeInsets.only(left: 20) : EdgeInsets.only(right: 5),
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: (cooking_state
                                  .contains(ordersStoryModelItem.state) ||
                                  in_the_way.contains(ordersStoryModelItem.state))
                                  ? Color(0xFF09B44D)
                                  : Color(0xF6F6F6F6)),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: (cooking_state
                                    .contains(ordersStoryModelItem.state) ||
                                    in_the_way.contains(ordersStoryModelItem.state))
                                    ? SvgPicture.asset(
                                    'assets/svg_images/white_bell.svg')
                                    : SvgPicture.asset(
                                    'assets/svg_images/bell.svg'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text('Готовится',
                                    style: (cooking_state
                                        .contains(ordersStoryModelItem.state) ||
                                        in_the_way.contains(ordersStoryModelItem.state))
                                        ? TextStyle(
                                        color: Colors.white, fontSize: 10)
                                        : TextStyle(
                                        color: Color(0x42424242),
                                        fontSize: 10)),
                              )
                            ],
                          ),
                        ),
                      ),
                      (cooking_state
                          .contains(ordersStoryModelItem.state)) ? Center(
                        child: SpinKitThreeBounce(
                          color: Colors.green,
                          size: 20.0,
                        ),
                      ) : Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: SvgPicture.asset('assets/svg_images/ellipse.svg', color: Color(0xFF09B44D),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: SvgPicture.asset('assets/svg_images/ellipse.svg', color: Color(0xFF09B44D),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: SvgPicture.asset('assets/svg_images/ellipse.svg', color: Color(0xFF09B44D),),
                          ),
                        ],
                      ),
                      (ordersStoryModelItem.withoutDelivery) ? Container() : Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: (in_the_way
                                  .contains(ordersStoryModelItem.state))
                                  ? Color(0xFF09B44D)
                                  : Color(0xF6F6F6F6)),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 18),
                                child: (in_the_way
                                    .contains(ordersStoryModelItem.state))
                                    ? SvgPicture.asset(
                                    'assets/svg_images/light_car.svg')
                                    : SvgPicture.asset(
                                    'assets/svg_images/car.svg'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text('В пути',
                                    style: (in_the_way
                                        .contains(ordersStoryModelItem.state))
                                        ? TextStyle(
                                        color: Colors.white, fontSize: 10)
                                        : TextStyle(
                                        color: Color(0x42424242),
                                        fontSize: 10)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              (in_the_way.contains(ordersStoryModelItem.state) && ordersStoryModelItem.ownDelivery != null && ordersStoryModelItem.ownDelivery) ? Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Text('Доставку осуществляет курьер от заведения',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14
                    ),
                  )
              ) :Container()
            ],
          )),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) {
            return OrdersDetailsScreen(
                ordersStoryModelItem: ordersStoryModelItem);
          }),
        );
      },
    );
  }
}