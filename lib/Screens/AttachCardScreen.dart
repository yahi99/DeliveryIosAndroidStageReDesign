import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/payments_methods_screen.dart';
import 'package:flutter_app/models/CardModel.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/svg.dart';

class AttachCardScreen extends StatefulWidget {
  final CardModel cardModel;

  AttachCardScreen({Key key, this.cardModel}) : super(key: key);

  @override
  AttachCardScreenState createState() =>
      AttachCardScreenState(cardModel: cardModel);
}

class AttachCardScreenState extends State<AttachCardScreen> {
  String error = '';
  var controller = new MaskedTextController(mask: '00/00');
  TextEditingController numberField = new TextEditingController();
  TextEditingController expirationField = new TextEditingController();
  TextEditingController cvvField = new TextEditingController();
  final CardModel cardModel;

  AttachCardScreenState({this.cardModel});

  @override
  Widget build(BuildContext context) {
    numberField.text = cardModel.number;
    controller.text = cardModel.expiration;
    cvvField.text = cardModel.cvv;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40, left: 0),
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
                            Navigator.pop(context);
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
                          'Новая картка',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 35, left: 15),
                child: Text('Номер карты'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0, left: 15, right: 15),
              child: TextField(
                maxLength: 12,
                keyboardType: TextInputType.number,
                controller: numberField,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Divider(
                  height: 1.0, color: Color(0xFFEDEDED)),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 15, left: 15),
                            child: Text('Срок действия'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0, left: 15, right: 15),
                          child: TextField(
                            controller: controller,
                            maxLength: 5,
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Divider(
                              height: 1.0, color: Color(0xFFEDEDED)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 15, left: 15),
                            child: Text('CVV'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0, left: 15, right: 15),
                          child: TextField(
                            maxLength: 4,
                            controller: cvvField,
                            obscureText: true,
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Divider(
                              height: 1.0, color: Color(0xFFFE534F)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text('Трехзначный код на\nобороте карты'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                  EdgeInsets.only(bottom: 10, left: 0, right: 0, top: 10),
                  child: FlatButton(
                    child: Text('Привязать карту',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    color: Color(0xFFFE534F),
                    splashColor: Color(0xFFFE534F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.only(left: 70, top: 20, right: 70, bottom: 20),
                    onPressed: () async {
                      cardModel.number = numberField.text;
                      cardModel.expiration = controller.text;
                      cardModel.cvv = cvvField.text;
                      await CardModel.saveData();
                      Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new PaymentsMethodsScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ));
  }

  String validateMobile(String value) {
    String pattern = r'(^(?:[+]?7)[0-9]{10}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Укажите норер';
    } else if (!regExp.hasMatch(value)) {
      return 'Указан неверный номер';
    }
    return null;
  }
}
