import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Promotion extends StatelessWidget {

  Promotion({Key key}) : super(key: key);

  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        height: 110,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Padding(
                padding:  EdgeInsets.only(left: 22, right: 8, top: 8, bottom: 8),
                child: Image(
                  image: AssetImage('assets/images/share_image.png'),
                )
            ),
            Padding(
                padding:  EdgeInsets.only(right: 8, top: 8, bottom: 8),
                child: Image(
                  image: AssetImage('assets/images/share_image.png'),
                )
            ),
            Padding(
                padding:  EdgeInsets.only(right: 8, top: 8, bottom: 8),
                child: Image(
                  image: AssetImage('assets/images/share_image.png'),
                )
            ),
          ],
        ),
      ),
    );
  }
}
