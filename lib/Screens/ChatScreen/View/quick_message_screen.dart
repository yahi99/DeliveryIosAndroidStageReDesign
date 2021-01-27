import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/ChatScreen/API/chat.dart';
import 'package:flutter_app/Screens/ChatScreen/Model/QuickMessagesModel.dart';

class QuickMessageScreen extends StatefulWidget {
  TextEditingController messageField;

  QuickMessageScreen({Key key, this.messageField}) : super(key: key);

  @override
  QuickMessageScreenState createState() {
    return new QuickMessageScreenState(messageField: messageField);
  }
}

class QuickMessageScreenState extends State<QuickMessageScreen> with WidgetsBindingObserver{
  TextEditingController messageField;

  QuickMessageScreenState({this.messageField});

  QuickMessageItem quickMessage;
  String quickTextMessage;

  buildQuickMessages() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(quickMessage.messages.length, (index) {
        return GestureDetector(
          child: Padding(
              padding: EdgeInsets.only(left: 15, right: 5, top: 10, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4.0, // soften the shadow
                        spreadRadius: 1.0, //extend the shadow
                      )
                    ],
                    color: (quickMessage.messages[index] != quickTextMessage)
                        ? Colors.white
                        : Color(0xFF09B44D)),
                child: Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 10,
                    ),
                    child: Text(
                      quickMessage.messages[index],
                      style: TextStyle(
                          color:
                          (quickMessage.messages[index] != quickTextMessage)
                              ? Color(0x99999999)
                              : Colors.white,
                          fontSize: 15),
                    )),
              )),
          onTap: () {
            setState(() {
              quickTextMessage = quickMessage.messages[index];
              messageField.text = quickTextMessage;
            });
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (quickMessage != null) {
      return buildQuickMessages();
    }
    return FutureBuilder<QuickMessages>(
      future: Chat.getMessages(),
      builder: (BuildContext context, AsyncSnapshot<QuickMessages> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          quickMessage = snapshot.data.chatMessageList[0];
          return buildQuickMessages();
        } else {
          return Container();
        }
      },
    );
  }
}