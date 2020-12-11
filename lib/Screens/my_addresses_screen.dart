import 'package:flutter/material.dart';
import 'package:flutter_app/Internet/check_internet.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/models/my_addresses_model.dart';
import 'package:flutter_svg/svg.dart';
import '../models/my_addresses_model.dart';
import '../models/my_addresses_model.dart';
import 'add_my_address_screen.dart';
import 'auto_complete.dart';
import 'home_screen.dart';

class MyAddressesScreen extends StatefulWidget {
  @override
  MyAddressesScreenState createState() => MyAddressesScreenState();
}

class MyAddressesScreenState extends State<MyAddressesScreen> {
  List<MyFavouriteAddressesModel> myAddressesModelList;
  GlobalKey<AutoCompleteDemoState> autoCompleteKey = new GlobalKey();
  bool addressScreenButton = false;
  bool changeMode = false;

  void _autocomplete(MyFavouriteAddressesModel myAddressesModel) {
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
              height: MediaQuery.of(context).size.height * 0.8,
              child: Container(
                child: _buildAutocompleteBottomNavigationMenu(myAddressesModel),
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                    )),
              ));
        });
  }

  _buildAutocompleteBottomNavigationMenu(MyFavouriteAddressesModel myAddressesModel) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 7),
                    child: Center(
                      child: Container(
                        width: 67,
                        height: 7,
                        decoration: BoxDecoration(
                            color: Color(0xFFEBEAEF),
                            borderRadius: BorderRadius.all(Radius.circular(11))),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 0, right: 15),
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                              top: 33,
                              bottom: 0,
                            ),
                            child: SvgPicture.asset('assets/svg_images/mini_black_ellipse.svg'),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 3,
                              left: 25,
                              bottom: 5,
                            ),
                            child: AutoComplete(
                              autoCompleteKey, 'Введите адрес дома',
                              onSelected: () async {
                                if (await Internet.checkConnection()) {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(builder: (context) {
                                      myAddressesModel.address = FavouriteAddress.fromInitialAddressModelChild(autoCompleteKey
                                          .currentState.selectedValue);
                                      return new AddMyAddressScreen(
                                          myAddressesModel: myAddressesModel);
                                    }),
                                  );
                                } else {
                                  noConnection(context);
                                }
                              },
                            ),
                          ),
                        ],
                      )),
                  Divider(
                    color: Color(0xFFEDEDED),
                    height: 1,
                    thickness: 1,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: FutureBuilder<List<MyFavouriteAddressesModel>>(
          future: MyFavouriteAddressesModel.getAddresses(),
          builder: (BuildContext context,
              AsyncSnapshot<List<MyFavouriteAddressesModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              myAddressesModelList = snapshot.data;
              if (addressScreenButton) {
                myAddressesModelList
                    .add(new MyFavouriteAddressesModel(tag: MyFavouriteAddressesModel.MyAddressesTags[0]));
                myAddressesModelList
                    .add(new MyFavouriteAddressesModel(tag: MyFavouriteAddressesModel.MyAddressesTags[1]));
                myAddressesModelList
                    .add(new MyFavouriteAddressesModel(tag: MyFavouriteAddressesModel.MyAddressesTags[2]));
                addressScreenButton = false;
              }
              if(myAddressesModelList.isEmpty){
                return Stack(
                  children: [
                    Center(
                      child: Text('У вас еще нет ни одного\nсохранённого адреса',
                      textAlign: TextAlign.center,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0, right: 10, left: 10),
                        child: FlatButton(
                          child: Text('Добавить адрес',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white)),
                          color: Color(0xFFE6E6E6),
                          splashColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.only(left: 100, top: 20, right: 100, bottom: 20),
                          onPressed: () async {
                            if (await Internet.checkConnection()) {
                              setState(() {
                                addressScreenButton = true;
                              });
                            } else {
                              noConnection(context);
                            }
                          },
                        ),
                      ),
                    )
                  ],
                );
              }
              return Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 0, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  height: 40,
                                  width: 60,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 12, bottom: 12, right: 10),
                                    child: SvgPicture.asset(
                                        'assets/svg_images/arrow_left.svg'),
                                  )
                              )
                          ),
                          onTap: () {
                            homeScreenKey = new GlobalKey<HomeScreenState>();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                    (Route<dynamic> route) => false);
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0, left: 0, bottom: 0),
                          child: Text('Мои адреса',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF424242))),
                        ),
                        InkWell(
                          child: (changeMode) ? Text('Готово') : Text('Изменить'),
                          onTap: () async {
                            setState(() {
                              changeMode = !changeMode;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children:
                      List.generate(myAddressesModelList.length, (index) {
                        if (myAddressesModelList[index].uuid ==
                            null || myAddressesModelList[index].uuid == "") {
                          return Column(
                            children: <Widget>[
                              GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 15, left: 30, bottom: 15),
                                            child: GestureDetector(
                                                child: Row(
                                                  children: <Widget>[
                                                    Image(
                                                      image: AssetImage(
                                                          'assets/images/plus_icon.png'),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      EdgeInsets.only(left: 20),
                                                      child: Text(
                                                        (myAddressesModelList[index].tag == MyFavouriteAddressesModel.MyAddressesTags[0]) ?
                                                        "Добавить адрес работы" : ((myAddressesModelList[index].tag == MyFavouriteAddressesModel.MyAddressesTags[1]) ?
                                                        "Добавить адрес дома" : "Добавить адрес"),
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                            Colors.grey),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                onTap: () async {
                                                  if (await Internet
                                                      .checkConnection()) {
                                                    _autocomplete(
                                                        myAddressesModelList[
                                                        index]);
                                                  } else {
                                                    noConnection(context);
                                                  }
                                                })),
                                      ),
                                    ],
                                  )),
                              Divider(height: 1.0, color: Color(0xFFEDEDED)),
                            ],
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10, bottom: 10),
                          child: GestureDetector(
                            child: Container(
                              height: 110,
                              width: MediaQuery.of(context).size.width,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 30, right: 20),
                                        child: Container(
                                          height: 70,
                                          child: Column(
                                            children: [
                                              //(myAddressesModelList[index].tag = "Дом") != null ? SvgPicture.asset('assets/svg_images/home_my_addresses.svg') : SvgPicture.asset('assets/svg_images/star_my_addresses.svg'),
                                              (myAddressesModelList[index].tag == MyFavouriteAddressesModel.MyAddressesTags[0]) ?
                                              SvgPicture.asset('assets/svg_images/work.svg') : ((myAddressesModelList[index].tag == MyFavouriteAddressesModel.MyAddressesTags[1]) ?
                                              SvgPicture.asset('assets/svg_images/home_my_addresses.svg') : SvgPicture.asset('assets/svg_images/star_my_addresses.svg')),
                                              Text(
                                                (myAddressesModelList[index].name != " ") ?
                                                myAddressesModelList[index].name
                                                    :
                                                "-",
                                                style:
                                                TextStyle(fontSize: 10, color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Container(
                                          height: 80,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 10, bottom: 5),
                                                  child: Text(
                                                    myAddressesModelList[index].address.unrestrictedValue,
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                  'г.Владикавказ, республика Северная Осетия-Алания, Россия',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(fontSize: 11, color: Color(0xFF9B9B9B))),
                                            ],
                                          ),
                                        ),
                                      ),
                                      (changeMode) ? GestureDetector(
                                        child: SvgPicture.asset('assets/svg_images/Icon.svg'),
                                        onTap: () async {
                                          await myAddressesModelList[index].delete();
                                          setState((){

                                          });
                                        },
                                      ) : Container()
                                    ],
                                  )
                                ],
                              ),
                            ),
                            onTap: () async {
                              if (await Internet.checkConnection()) {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) {
                                        return new AddMyAddressScreen(
                                          myAddressesModel:
                                          myAddressesModelList[index],
                                        );
                                      }),
                                );
                              } else {
                                noConnection(context);
                              }
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                  (addressScreenButton) ? Container() : Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, right: 10, left: 10),
                    child: FlatButton(
                      child: Text('Добавить адрес',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white)),
                      color: Color(0xFFE6E6E6),
                      splashColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.only(left: 100, top: 20, right: 100, bottom: 20),
                      onPressed: () async {
                        if (await Internet.checkConnection()) {
                          setState(() {
                            addressScreenButton = true;
                          });
                        } else {
                          noConnection(context);
                        }
                      },
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}