import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Internet/check_internet.dart';
import 'package:flutter_app/Screens/HomeScreen/Model/FilteredStores.dart';
import 'package:flutter_app/Screens/HomeScreen/View/home_screen.dart';
import 'package:flutter_app/Screens/OrdersScreen/Model/order.dart';
import 'package:flutter_app/Screens/RestaurantScreen/API/getProductsByStoreUuid.dart';
import 'package:flutter_app/Screens/RestaurantScreen/Model/ProductsByStoreUuid.dart';
import 'package:flutter_app/Screens/RestaurantScreen/Widgets/CartButton/CartButton.dart';
import 'package:flutter_app/Screens/RestaurantScreen/Widgets/ProductCategories/CategoryList.dart';
import 'package:flutter_app/Screens/RestaurantScreen/Widgets/ProductDescCounter.dart';
import 'package:flutter_app/Screens/RestaurantScreen/Widgets/ProductMenu/Item.dart';
import 'package:flutter_app/Screens/RestaurantScreen/Widgets/ProductMenu/ItemCounter.dart';
import 'package:flutter_app/Screens/RestaurantScreen/Widgets/ProductMenu/Title.dart';
import 'package:flutter_app/Screens/RestaurantScreen/Widgets/SliverTitleItems/SliverBackButton.dart';
import 'package:flutter_app/Screens/RestaurantScreen/Widgets/SliverTitleItems/SliverText.dart';
import 'package:flutter_app/Screens/RestaurantScreen/Widgets/VariantSelector.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/svg.dart';

class RestaurantScreen extends StatefulWidget {
  final FilteredStores restaurant;

  RestaurantScreen({Key key, this.restaurant}) : super(key: key);

  @override
  RestaurantScreenState createState() =>
      RestaurantScreenState(restaurant);
}

class RestaurantScreenState extends State<RestaurantScreen> {
  final FilteredStores restaurant;
  // Добавленные глобалки
  ProductsByStoreUuidData restaurantDataItems; // Модель текущего меню
  CategoryList categoryList; // Виджет с категориями еды
  // (для подгрузки ВПЕРЕД по клику по категории)
  List<MenuItem> foodMenuItems = new List<MenuItem>(); // Виджеты с хавкой
  List<MenuItemTitle> foodMenuTitles = new List<MenuItemTitle>(); // Тайтлы категорий
  List<Widget> menuWithTitles = new List<Widget>();

  GlobalKey<ProductDescCounterState> counterKey = new GlobalKey();
  GlobalKey<CartButtonState> basketButtonStateKey =
  new GlobalKey<CartButtonState>();
  bool isLoading = true;

  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();

  ScrollController sliverScrollController = new ScrollController();

  RestaurantScreenState(this.restaurant);


  @override
  void initState() {
    super.initState();

    // Инициализируем список категорий
    categoryList = new CategoryList(key: new GlobalKey<CategoryListState>(), restaurant: restaurant, parent: this);
  }

  bool get _isAppBarExpanded {
    return sliverScrollController.hasClients && sliverScrollController.offset > 90;
  }

  _dayOff(ProductsByStoreUuid restaurantDataItems,
      GlobalKey<MenuItemCounterState> menuItemCounterKey) {
    GlobalKey<VariantsSelectorState> variantsSelectorStateKey =
    GlobalKey<VariantsSelectorState>();
    // GlobalKey<ToppingsSelectorState> toppingsSelectorStateKey =
    // new GlobalKey<ToppingsSelectorState>();

//    DateTime now = DateTime.now();
//    int dayNumber  = now.weekday-1;
//
//    int work_beginning = restaurant.work_schedule[dayNumber].work_beginning;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
          )),
      child: Stack(
        children: <Widget>[
//          Padding(
//            padding: EdgeInsets.only(top: 30),
//            child: Align(
//                alignment: Alignment.topCenter,
//                child: Text('К сожалению, доставка не доступна.\nБлижайшее время в ${( work_beginning/ 60).toStringAsFixed(0)} часов',
//                  style: TextStyle(
//                      fontSize: 16
//                  ),
//                  textAlign: TextAlign.center,
//                )
//            ),
//          ),
          Padding(
            padding: EdgeInsets.only(top: 10,left: 15, right: 15, bottom: 25),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  child: Text(
                    "Далее",
                    style:
                    TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  color: Color(0xFF09B44D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.only(
                      left: 110, top: 20, right: 110, bottom: 20),
                  onPressed: () async {
                    homeScreenKey = new GlobalKey<HomeScreenState>();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => HomeScreen()),
                            (Route<dynamic> route) => false);
                  },
                )
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
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
        });
        return Padding(
          padding: EdgeInsets.only(bottom: 500),
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Container(
              height: 50,
              width: 100,
              child: Center(
                child: Text("Товар добавлен в коризну"),
              ),
            ),
          ),
        );
      },
    );
  }

  showCartClearDialog(BuildContext context, Order order,
      GlobalKey<MenuItemCounterState> menuItemCounterKey) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Container(
                height: 242,
                width: 300,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 20, bottom: 20, right: 15),
                      child: Text(
                        'Все ранее добавленные блюда из ресторна ${currentUser.cartDataModel.cart[0].restaurant.name} будут удалены из корзины',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    InkWell(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Center(
                            child: Text(
                              'Ок',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        if (await Internet.checkConnection()) {
                          if (currentUser.cartDataModel.cart.length > 0 &&
                              currentUser
                                  .cartDataModel.cart[0].restaurant.uuid !=
                                  restaurant.uuid) {
                            currentUser.cartDataModel.cart.clear();
                            currentUser.cartDataModel.addItem(order);
                            currentUser.cartDataModel.saveData();
                            basketButtonStateKey.currentState.refresh();
                            menuItemCounterKey.currentState.refresh();
                            counterKey.currentState.refresh();
                          }
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Padding(
                            padding: EdgeInsets.only(bottom: 0),
                            child: showAlertDialog(context),
                          );
                        } else {
                          noConnection(context);
                        }
                      },
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    InkWell(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Center(
                            child: Text(
                              'Отмена',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
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

  _restInfo() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
            )),
        context: context,
        builder: (context) {
          return Container(
            height: 300,
            child: _buildRestInfoNavigationMenu(),
            decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                )),
          );
        });
  }

  _buildRestInfoNavigationMenu() {
//    DateTime now = DateTime.now();
//    int currentTime = now.hour*60+now.minute;
//    int dayNumber  = now.weekday-1;
//    int work_ending = restaurant.work_schedule[dayNumber].work_ending;
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 30),
            child: Align(
              alignment: Alignment.topLeft,
                child: Text(restaurant.name,
                  style: TextStyle(
                    color: Color(0xFF424242),
                    fontSize: 21,
                    fontWeight: FontWeight.bold
                  ),
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('Адрес',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14
                  ),
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(restaurant.address.unrestrictedValue,
                  style: TextStyle(
                    fontSize: 14
                  ),
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text("Время доставки",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14
                  ),
                )
            ),
          ),
//          Padding(
//            padding: EdgeInsets.only(left: 20, top: 10),
//            child: Align(
//                alignment: Alignment.topLeft,
//                child: Text('Доставка до ${(work_ending / 60).toStringAsFixed(0)} часов',
//                  style: TextStyle(
//                      fontSize: 14
//                  ),
//                )
//            ),
//          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('Кухни',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14
                  ),
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('Бургеры и тд',
                  style: TextStyle(
                      fontSize: 14
                  ),
                )
            ),
          )
        ],
      ),
    );
  }

  _buildFoodCategoryList() {
    if(restaurant.productCategoriesUuid.length>0)
      return categoryList;
    else
      return Container(height: 0);
  }


  // функция для получения детей сливера
  List<Widget>  getSliverChildren(){
    List<Widget> result = new List<Widget>();
    result.addAll(menuWithTitles);
    return result;
  }

  // генерация списка еды с названиями категорий
  List<Widget> generateMenu() {
    List<Widget> menu = new List<Widget>();
    String lastCategoryUuid = "";
    int lastCategoryIndex = -1;
    foodMenuItems.forEach((foodMenuItem) {
      if(foodMenuItem.restaurantDataItems.productCategoriesUuid[0] != lastCategoryUuid){
        lastCategoryIndex++;
        lastCategoryUuid = foodMenuItem.restaurantDataItems.productCategoriesUuid[0];
        menu.add(foodMenuTitles[lastCategoryIndex]);
      }
      print(foodMenuItem.restaurantDataItems.uuid);
      menu.add(foodMenuItem);
    });
    return menu;
  }


  // список итемов заведения
  Widget _buildScreen() {
    isLoading = false;
    // Если хавки нет
    if (restaurantDataItems.productsByStoreUuidList.length == 0) {
      return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: InkWell(
                          onTap: () async {
                            homeScreenKey =
                            new GlobalKey<HomeScreenState>();
                            if(await Internet.checkConnection()){
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
                            }else{
                              noConnection(context);
                            }
                          },
                          child: Container(
                              height: 40,
                              width: 60,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 12, bottom: 12, right: 10, left: 16),
                                child: SvgPicture.asset(
                                    'assets/svg_images/arrow_left.svg'),
                              ))),
                    ),
                  ),
                  Flexible(
                    flex: 7,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(right: 30),
                        child: Text(
                          this.restaurant.name,
                          style: TextStyle(
                              fontSize: 18,),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 0),
              child: Divider(color: Color(0xFFEEEEEE), height: 1,),
            ),
            _buildFoodCategoryList(),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 0),
              child: Divider(color: Color(0xFFEEEEEE), height: 1,),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
              child: Center(
                child: Text('Нет товаров данной категории'),
              ),
            ),
          ],
        ),
      );
    }


    // генерим список еды и названий категория
    foodMenuItems.addAll(MenuItem.fromFoodRecordsList(restaurantDataItems.productsByStoreUuidList, this));
    foodMenuTitles.addAll(MenuItemTitle.fromCategoryList(restaurant.productCategoriesUuid));
    menuWithTitles = generateMenu();

    List<Widget> sliverChildren = getSliverChildren();
    GlobalKey<SliverTextState>sliverTextKey = new GlobalKey();
    GlobalKey<SliverBackButtonState>sliverImageKey = new GlobalKey();

    // замена кастомной кнопки на кнопку и текст аппбара
    sliverScrollController.addListener(() async {
      if(sliverTextKey.currentState != null && sliverScrollController.offset > 89){
        sliverTextKey.currentState.setState(() {
          sliverTextKey.currentState.title =  new Text(this.restaurant.name, style: TextStyle(color: Colors.black),);
        });
      }else{
        if(sliverTextKey.currentState != null){
          sliverTextKey.currentState.setState(() {
            sliverTextKey.currentState.title =  new Text('');
          });
        }
      }
      if(sliverImageKey.currentState != null && sliverScrollController.offset > 89){
        sliverImageKey.currentState.setState(() {
          sliverImageKey.currentState.image =
          new SvgPicture.asset('assets/svg_images/arrow_left.svg');
          });
      }else{
        if(sliverImageKey.currentState != null){
          sliverImageKey.currentState.setState(() {
            sliverImageKey.currentState.image =  null;
          });
        }
      }

      try{
        if(!isLoading){
          // Используя силу математики, находим индекс хавки, на которую сейчас
          // смотрим
          double offset = sliverScrollController.offset;
          int i = 0;
          double defaultTitleHeight = 50;
          double defaultFoodItemHeight = 165;
          var item;
          while(offset > 0 && i < menuWithTitles.length){
            item = menuWithTitles[i];
            if(item is MenuItem){
              offset -= (item.key.currentContext != null) ? item.key.currentContext.size.height : defaultFoodItemHeight;
            } else if(item is MenuItemTitle){
              offset -= (item.key.currentContext != null) ? item.key.currentContext.size.height : defaultTitleHeight;
            }
            i++;
          }
        }
      }catch(e){
      }

    });
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        body: Stack(
          children: [
            ClipRRect(
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      getImage((restaurant.meta.images != null && restaurant.meta.images.length > 0) ? restaurant.meta.images[0] : ''),
                      fit: BoxFit.cover,
                      height: 230.0,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 40, left: 15, right: 0),
                          child: GestureDetector(
                            child: SvgPicture.asset(
                                'assets/svg_images/rest_arrow_left.svg'),
                            onTap: () async {
                              if(await Internet.checkConnection()){
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
                              }else{
                                noConnection(context);
                              }
                            },
                          ),
                        ))
                  ],
                )),
            CustomScrollView(
              anchor: 0.01,
              controller: sliverScrollController,
              slivers: [
                SliverAppBar(
                  brightness: _isAppBarExpanded ? Brightness.dark : Brightness.light,
                  expandedHeight: 140.0,
                  floating: false,
                  pinned: true,
                  snap: false,
                  stretch: true,
                  backgroundColor: Colors.white,
                  leading: Padding(
                      padding: const EdgeInsets.all(20),
                      child: InkWell(child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SliverBackButton(key: sliverImageKey, image: null,),
                      ),
                        onTap: () async {
                          homeScreenKey =
                          new GlobalKey<HomeScreenState>();
                          if(await Internet.checkConnection()){
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
                          }else{
                            noConnection(context);
                          }
                        },
                      )
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: SliverText(title: Text('', style: TextStyle(fontSize: 18),),key: sliverTextKey,),
                    background: AnnotatedRegion<SystemUiOverlayStyle>(
                      value: _isAppBarExpanded ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
                      child: ClipRRect(
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                getImage((restaurant.meta.images != null && restaurant.meta.images.length > 0) ? restaurant.meta.images[0] : ''),
                                fit: BoxFit.cover,
                                height: 230.0,
                                width: MediaQuery.of(context).size.width,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 40, left: 15),
                                    child: GestureDetector(
                                      child: SvgPicture.asset(
                                          'assets/svg_images/rest_arrow_left.svg'),
                                      onTap: () async {
                                        if(await Internet.checkConnection()){
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
                                        }else{
                                          noConnection(context);
                                        }
                                      },
                                    ),
                                  ))
                            ],
                          )),
                    ),
                  ),
                ),
                SliverStickyHeader(
                  sticky: false,
                  header: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  this.restaurant.name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF3F3F3F)),
                                ),
                              ),
                              InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: SvgPicture.asset(
                                      'assets/svg_images/rest_info.svg'),
                                ),
                                onTap: (){
                                  _restInfo();
                                },
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Container(
                                height: 26,
                                width: 51,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFFEFEFEF)
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/svg_images/star.svg',
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5),
                                          child: Text(restaurant.meta.rating.toString(),
                                            style: TextStyle(
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                height: 26,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFFEFEFEF)
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(left:8, right: 8, top: 5, bottom: 5),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 5),
                                          child: SvgPicture.asset('assets/svg_images/rest_car.svg',
                                          ),
                                        ),
                                        Text(
                                          '~' +  '${restaurant.meta.avgDeliveryTime} мин',
                                          style: TextStyle(
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 15),
                              child: Container(
                                height: 26,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFFEFEFEF)
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(left:8, right: 13, top: 5, bottom: 5),
                                    child: Text('Доставка ${restaurant.meta.avgDeliveryPrice} ₽',
                                      style: TextStyle(
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverStickyHeader(
                  sticky: true,
                  header: Container(
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: _buildFoodCategoryList(),
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index){
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white
                          ),
                          child: Column(
                              children: sliverChildren
                          ),
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                )
              ],
            ),
//            Align(
//              alignment: Alignment.bottomCenter,
//              child: Padding(
//                padding:  EdgeInsets.only(bottom: 0),
//                child: BasketButton(
//                    key: basketButtonStateKey, restaurant: restaurant),
//              ),
//            )
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    if(restaurantDataItems != null){
      return _buildScreen();
    }
    return Scaffold(
      key: _scaffoldStateKey,
      body: FutureBuilder<ProductsByStoreUuidData>(
          future: getProductsByStoreUuid(restaurant.uuid),
          initialData: null,
          builder: (BuildContext context,
              AsyncSnapshot<ProductsByStoreUuidData> snapshot) {
            print(snapshot.connectionState);
            if (snapshot.connectionState == ConnectionState.done) {
              restaurantDataItems = snapshot.data;
              return _buildScreen();
            } else {
              return Center(
                child: SpinKitFadingCircle(
                  color: Colors.green,
                  size: 50.0,
                ),
              );
            }
          }),
    );
  }
  // Подгрузка итемов с категорией
  // ignore: non_constant_identifier_names
  Future<bool> GoToCategory(int categoryIndex) async {
    if(isLoading)
      return false;
    isLoading = true;
    // находим итем с данной категорией
    MenuItemTitle targetCategory = menuWithTitles.firstWhere((element) => element is MenuItemTitle && element.title == restaurant.productCategoriesUuid[categoryIndex].name);
    if(targetCategory != null){
      while(targetCategory.key.currentContext == null) {
        await sliverScrollController.animateTo(sliverScrollController.offset+200, duration: new Duration(milliseconds: 15),
            curve: Curves.ease);
      }
      // джампаем к нему

      await Scrollable.ensureVisible(targetCategory.key.currentContext, duration: new Duration(milliseconds: 100),
          curve: Curves.ease);
      sliverScrollController.position.jumpTo(sliverScrollController.position.pixels-60);
    }
    isLoading = false;
    return true;
  }
}