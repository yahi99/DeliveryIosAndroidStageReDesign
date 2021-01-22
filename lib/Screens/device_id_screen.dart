import 'package:flutter/material.dart';
import 'package:flutter_app/Config/config.dart';
import 'package:flutter_app/Screens/city_screen.dart';
import 'package:flutter_app/Screens/home_screen.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/models/CartDataModel.dart';
import 'package:flutter_app/models/amplitude.dart';
import 'package:transparent_image/transparent_image.dart';

class DeviceIdScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder<NecessaryDataForAuth>(
        future: NecessaryDataForAuth.getData(),
        builder:
            (BuildContext context, AsyncSnapshot<NecessaryDataForAuth> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            CartDataModel.getCart().then((value) {
              currentUser.cartDataModel = value;
              print('Cnjbn');
            });
            necessaryDataForAuth = snapshot.data;
            if (necessaryDataForAuth.refresh_token == null ||
                necessaryDataForAuth.phone_number == null ||
                necessaryDataForAuth.name == null) {
              currentUser.isLoggedIn = false;
              AmplitudeAnalytics.initialize(necessaryDataForAuth.device_id).then((value){
                AmplitudeAnalytics.analytics.logEvent('open_app');
              });
              return CityScreen();
            }
            print(necessaryDataForAuth.refresh_token);
            AmplitudeAnalytics.initialize(necessaryDataForAuth.phone_number).then((value){
              AmplitudeAnalytics.analytics.logEvent('open_app');
            });
            return CityScreen();
          } else {
            return Center(
              child: Image(
                image: AssetImage('assets/images/faem.png'),
              )
            );
          }
        },
      ),
    );
  }
}