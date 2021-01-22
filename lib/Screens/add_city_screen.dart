import 'package:flutter/material.dart';
import 'package:flutter_app/Internet/check_internet.dart';
import 'package:flutter_app/Screens/autocolplete_field_list.dart';
import 'package:flutter_app/Screens/cart_screen.dart';
import 'package:flutter_app/Screens/city_autocomplete.dart';
import 'package:flutter_app/Screens/city_screen.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/models/my_addresses_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_app/Screens/address_screen.dart';
import 'address_screen.dart';
import 'my_addresses_screen.dart';

// ignore: must_be_immutable
class AddCityScreen extends StatefulWidget {
  AddressScreenState parent;

  AddCityScreen({Key key, this.parent}) : super(key: key);

  @override
  AddCityScreenState createState() =>
      AddCityScreenState(parent);
}

class AddCityScreenState extends State<AddCityScreen> {
  bool status1 = false;
  String name;
  GlobalKey<CityAutocompleteState> autoCompleteFieldKey = new GlobalKey();
  AddressScreenState parent;


  AddCityScreenState(this.parent);

  TextEditingController nameField = new TextEditingController();
  TextEditingController commentField = new TextEditingController();
  GlobalKey<CartPageState>cartPageKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 25),
                        child: Container(
                            height: 40,
                            width: 60,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 12, bottom: 12, right: 10),
                              child:SvgPicture.asset(
                                  'assets/svg_images/arrow_left.svg'),
                            )))),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 80, left: 20),
                child: Column(
                  children: <Widget>[
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: Padding(
                    //     padding: EdgeInsets.only(top: 10, bottom: 10),
                    //     child: Text('Адрес',
                    //         style: TextStyle(fontSize: 14, color: Color(0xFF9B9B9B))),
                    //   ),
                    // ),
                    CityAutocomplete(autoCompleteFieldKey, onSelected: (){
                      return;
                    },
                   )
                  ],
                ),
              )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 5),
                child: FlatButton(
                  child: Text(
                      "Добавить город",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white)
                  ),
                  color: Color(0xFF09B44D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                  EdgeInsets.only(left: 100, top: 20, right: 100, bottom: 20),
                  onPressed: () async {
                    if (await Internet.checkConnection()) {
                      selectedCity = autoCompleteFieldKey.currentState.selectedValue;
                      Navigator.pop(context);
                      Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => new CityScreen()),
                      );
                    } else {
                      noConnection(context);
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}