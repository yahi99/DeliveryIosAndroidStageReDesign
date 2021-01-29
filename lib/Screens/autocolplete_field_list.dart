import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/PostData/necessary_address_data_pass.dart';
import 'package:flutter_app/models/InitialAddressModel.dart';
import 'package:flutter_app/models/RecommendationAddressModel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Localization/app_localizations.dart';

class AutoCompleteField extends StatefulWidget {
  GlobalKey<AutoCompleteFieldState> key;
  AsyncCallback onSelected;
  String initialValue;
  AutoCompleteField(this.key, {this.onSelected, this.initialValue}) : super(key: key);

  @override
  AutoCompleteFieldState createState() {
    return new AutoCompleteFieldState(onSelected, initialValue);
  }
}

class AutoCompleteFieldState extends State<AutoCompleteField> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  AutoCompleteFieldState(this.onSelected, this.initialValue);
  String initialValue;
  List<InitialAddressModel> suggestions = new List<InitialAddressModel>();
  TextEditingController controller;
  AutocompleteList autocompleteList;
  InitialAddressModel selectedValue;
  AsyncCallback onSelected;
  FocusNode node = new FocusNode();

  @override
  void initState(){
    autocompleteList = AutocompleteList(suggestions, this, new GlobalKey(), initialValue);
    controller = new TextEditingController(text: (initialValue != null) ? initialValue :  '');
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 15),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextField(
                          controller: controller,
                          focusNode: node,
                          decoration: new InputDecoration(
                            suffix: Padding(
                              padding: const EdgeInsets.only(right:8.0, top: 3),
                              child: Cross(controller, autocompleteList),
                            ),
                            contentPadding: EdgeInsets.only(left: 10, right: 5, bottom: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onChanged: (text) async {
                            var temp = await findAddress(text);
                            if(temp != null && autocompleteList.autoCompleteListKey.currentState != null){
                              autocompleteList.autoCompleteListKey.currentState.setState(() {
                                autocompleteList.autoCompleteListKey.currentState.suggestions = temp;
                              });
                            }
                          },
                        ),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  AppLocalizations.of(context).getTranslation('order_confirmation_screen.address'),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey
                                  ),
                                ),
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ],
              )
          ),
          autocompleteList
        ],
      ),
    );
  }

  Future<List<InitialAddressModel>> findAddress(String searchText) async {
    // Результирующий список
    List<InitialAddressModel> necessaryAddressDataItems;

    try {
      // Если в поле автокомплита был введен текст
      if (searchText.length > 0) {
        // то получаем релеватные подсказки с сервера
        necessaryAddressDataItems =
            (await loadNecessaryAddressData(searchText)).destinationPoints;
      } else {
        // иначе получаем список рекомендаций для заполнения с того же сервера
        List<RecommendationAddressModel> temp = await RecommendationAddress.getRecommendations("target");
        // который загоняем в подсказски автокомплита
        necessaryAddressDataItems = temp.map<InitialAddressModel>((item) => item.address).toList();
      }
    }
    catch (e) {
      print("Error getting addresses.");
    }
    return necessaryAddressDataItems;
  }
}


class AutocompleteList extends StatefulWidget {
  List<InitialAddressModel> suggestions;
  AutoCompleteFieldState parent;
  String initialValue;
  GlobalKey<AutocompleteListState> autoCompleteListKey;
  AutocompleteList(this.suggestions, this.parent, this.autoCompleteListKey, this.initialValue) : super(key: autoCompleteListKey);

  @override
  AutocompleteListState createState() {
    return new AutocompleteListState(suggestions, parent, initialValue);
  }
}

class AutocompleteListState extends State<AutocompleteList> {

  List<InitialAddressModel> suggestions = new List<InitialAddressModel>();
  AutoCompleteFieldState parent;
  String initialValue;
  AutocompleteListState(this.suggestions, this.parent, this.initialValue);


  Widget suggestionRow(){
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.65,
      child: ListView(
        padding: EdgeInsets.zero,
          children: List.generate(suggestions.length, (index){
            return InkWell(
              child: Padding(
                padding: const EdgeInsets.only(left: 5, top: 10, right: 15, bottom: 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(suggestions[index].unrestrictedValue,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('Владикавказ, Республика Северная Осетия -\nАлания, Россия',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Divider(color: Colors.grey,),
                      )
                    ],
                  ),
                )
              ),
              onTap: () async {
                parent.selectedValue = suggestions[index];
                parent.controller.text = suggestions[index].unrestrictedValue;
                // Избегаем потери фокуса и ставим курсор в конец
                parent.node.requestFocus();
                parent.controller.selection = TextSelection.fromPosition(TextPosition(offset: parent.controller.text.length));
                if(parent.onSelected != null){
                  await parent.onSelected();
                }
                FocusScope.of(context).requestFocus(new FocusNode());
              },
            );
          })
      ),
    );
  }

  Widget build(BuildContext context) {
    if(suggestions == null || suggestions.length == 0){
      return FutureBuilder(
        future: parent.findAddress((initialValue == null) ? '' : initialValue),
        builder: (BuildContext context, AsyncSnapshot<List<InitialAddressModel>> snapshot){
          if(snapshot.hasData){
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.data != null){
                suggestions = snapshot.data;
              }
              return suggestionRow();
            }
          }
          return Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
              child: SpinKitThreeBounce(
                color: Colors.green,
                size: 20.0,
              ),
            ),
          );
        },
      );
    }
    return suggestionRow();
  }
}


class Cross extends StatefulWidget {

  TextEditingController controller;
  AutocompleteList autocompleteList;
  Cross(this.controller, this.autocompleteList, {Key key}) : super(key: key);

  @override
  CrossState createState() {
    return new CrossState(controller, autocompleteList);
  }
}

class CrossState extends State<Cross> {
  TextEditingController controller;
  AutocompleteList autocompleteList;
  CrossState(this.controller, this.autocompleteList);

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {

      });
    });
  }

  Widget build(BuildContext context) {
    if(controller.text.length == 0){
      return Container();
    }
    return GestureDetector(
      child: SvgPicture.asset(
          'assets/svg_images/auto_cross.svg'),
      onTap: (){
        if(controller.text != ''){
          autocompleteList.autoCompleteListKey.currentState.suggestions.clear();
          controller.clear();
          autocompleteList.autoCompleteListKey.currentState.setState((){

          });
        }
      },
    );
  }
}