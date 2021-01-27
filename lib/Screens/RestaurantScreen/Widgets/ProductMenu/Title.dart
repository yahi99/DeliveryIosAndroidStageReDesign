import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/HomeScreen/Model/FilteredStores.dart';

class MenuItemTitle extends StatefulWidget {
  MenuItemTitle({
    this.key,
    this.title,
  }) : super(key: key);
  final String  title;
  final GlobalKey<MenuItemTitleState> key;

  @override
  MenuItemTitleState createState() {
    return new MenuItemTitleState(title);
  }

  static List<MenuItemTitle> fromCategoryList(List<CategoriesUuid> categories){
    List<MenuItemTitle> result = new List<MenuItemTitle>();
    categories.forEach((element) {
      result.add(new MenuItemTitle(key: new GlobalKey<MenuItemTitleState>(), title: element.name,));
    });
    return result;
  }
}

class MenuItemTitleState extends State<MenuItemTitle>{
  final String  title;

  MenuItemTitleState(this.title);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 10, left: 15),
        child: Text(title[0].toUpperCase() + title.substring(1),
          style: TextStyle(
            color: Color(0xFF424242),
            fontSize: 21,
          ),
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}