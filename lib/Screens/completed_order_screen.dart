import 'package:flutter/material.dart';
import 'package:flutter_app/Internet/check_internet.dart';
import 'package:flutter_app/PostData/service_data_pass.dart';
import 'package:flutter_app/data/data.dart';
import 'package:flutter_app/models/TicketModel.dart';
import 'package:flutter_svg/svg.dart';
import 'home_screen.dart';

class CompletedOrderScreen extends StatefulWidget {

  CompletedOrderScreen({Key key}) : super(key: key);

  @override
  CompletedOrderScreenState createState() =>
      CompletedOrderScreenState();
}

class CompletedOrderScreenState extends State<CompletedOrderScreen> {

  CompletedOrderScreenState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    children: [
                      Text(
                        'Спасибо за заказ!',
                        style: TextStyle(color: Color(0xFF424242), fontSize: 24),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Оставьте свой отзыв, это поможет\nсделать приложение лучше! ',
                          style: TextStyle(color: Color(0xFF424242), fontSize: 18), textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Estimate()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 222,
                        width: 339,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(width: 1.0, color: Colors.grey[200])),
                        child: TextField(
                          minLines: 1,
                          maxLines: 100,
                          textCapitalization: TextCapitalization.sentences,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 14),
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            hintText: 'Оставьте свой отзыв',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16
                            ),
                            contentPadding: EdgeInsets.all(15),
                            border: InputBorder.none,
                            counterText: '',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(left: 0, top: 20, bottom: 20),
                  child: FlatButton(
                    child: Text(
                      "Оценить заказ",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Color(0xFF09B44D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:
                    EdgeInsets.only(left: 110, top: 20, right: 110, bottom: 20),
                    onPressed: () async {
                      if (await Internet.checkConnection()) {
                        Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => new HomeScreen(),
                          ),
                        );
                      } else {
                        noConnection(context);
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class Estimate extends StatefulWidget {

  Estimate({Key key}) : super(key: key);

  @override
  EstimateState createState() {
    return new EstimateState();
  }
}

class EstimateState extends State<Estimate>{

  EstimateState();

  List<bool> selectedStars = List.generate(5, (index) => false);


  @override
  Widget build(BuildContext context) {

    return Container(
        padding: EdgeInsets.only(),
        height: 60,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          children: List.generate(5,(index){
            return InkWell(
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
                child: (!selectedStars[index]) ? SvgPicture.asset('assets/svg_images/estimate_star.svg') :
                SvgPicture.asset('assets/svg_images/estimate_star.svg', color: Color(0xFF09B44D),),
              ),
              onTap: (){
                setState(() {
                  selectedStars[index] = !selectedStars[index];
                });
              },
            );
          }),
        )
    );
  }
}
