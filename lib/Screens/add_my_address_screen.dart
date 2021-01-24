import 'package:flutter/material.dart';
import 'package:flutter_app/Internet/check_internet.dart';
import 'package:flutter_app/Localization/app_localizations.dart';
import 'package:flutter_app/Screens/autocolplete_field_list.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/models/my_addresses_model.dart';
import 'package:flutter_svg/svg.dart';
import 'my_addresses_screen.dart';

// ignore: must_be_immutable
class AddMyAddressScreen extends StatefulWidget {
  MyFavouriteAddressesModel myAddressesModel;

  AddMyAddressScreen({Key key, this.myAddressesModel}) : super(key: key);

  @override
  AddMyAddressScreenState createState() =>
      AddMyAddressScreenState(myAddressesModel);
}

class AddMyAddressScreenState extends State<AddMyAddressScreen> {
  bool status1 = false;
  String name;
  MyFavouriteAddressesModel myAddressesModel;
  GlobalKey<AutoCompleteFieldState> autoCompleteFieldKey = new GlobalKey();

  AddMyAddressScreenState(this.myAddressesModel);

  TextEditingController nameField = new TextEditingController();
  TextEditingController commentField = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameField.text = myAddressesModel.name;
    commentField.text = myAddressesModel.description;
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(AppLocalizations.of(context).getTranslation('my_addresses.title'),
                          style: TextStyle(fontSize: 14, color: Color(0xFF9B9B9B))),
                    ),
                    Container(
                      height: 30,
                      child: Padding(
                        padding: EdgeInsets.only(top: 0, left: 0, right: 0),
                        child: TextField(
                          textCapitalization: TextCapitalization.sentences,
                          controller: nameField,
                          onEditingComplete: (){
                            myAddressesModel.name = nameField.text;
                            FocusScope.of(context).unfocus();
                          },
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Divider(height: 1.0, color: Color(0xFFEDEDED)),
                    ),
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: Padding(
                    //     padding: EdgeInsets.only(top: 10, bottom: 10),
                    //     child: Text(AppLocalizations.of(context).getTranslation('my_addresses.address'),
                    //         style: TextStyle(fontSize: 14, color: Color(0xFF9B9B9B))),
                    //   ),
                    // ),
                    AutoCompleteField(autoCompleteFieldKey, onSelected: (){
                      myAddressesModel.address = FavouriteAddress.fromInitialAddressModelChild(autoCompleteFieldKey.currentState.selectedValue);
                      return;
                    }, initialValue: (myAddressesModel.address == null) ? '' : myAddressesModel.address.unrestrictedValue,)
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
                      AppLocalizations.of(context).getTranslation('my_addresses.button_text'),
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
                      if(myAddressesModel.address == null){
                        return;
                      }
                      myAddressesModel.name = nameField.text;
                      myAddressesModel.description = commentField.text;
                      await myAddressesModel.ifNoBrainsSave();
                      Navigator.pushAndRemoveUntil(context,
                          new MaterialPageRoute(builder: (context) => new MyAddressesScreen()),
                              (route) => route.isFirst);
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