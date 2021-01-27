import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/ChatScreen/Model/ChatHistoryModel.dart';

class ChatMessageScreen extends StatefulWidget {
  ChatMessage chatMessage;

  ChatMessageScreen({Key key, this.chatMessage}) : super(key: key);

  @override
  ChatMessageScreenState createState() {
    return new ChatMessageScreenState(chatMessage);
  }
}

class ChatMessageScreenState extends State<ChatMessageScreen> with WidgetsBindingObserver {
  ChatMessage chatMessage;

  ChatMessageScreenState(this.chatMessage);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      setState(() {

      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          (chatMessage.to == 'client')
              ? Padding(
            padding: EdgeInsets.only(right: 15),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFE5E6EA),
                        borderRadius: BorderRadius.circular(17.0),
                        border:
                        Border.all(width: 1.0, color: Color(0xFFE5E6EA))),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        chatMessage.message,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            decoration: TextDecoration.none),
                      ),
                    )),
              ),
            ),
          )
              : Padding(
            padding: EdgeInsets.only(left: 15),
            child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF09B44D),
                          borderRadius: BorderRadius.circular(17.0),
                          border: Border.all(
                              width: 1.0, color: Color(0xFF09B44D))),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          chatMessage.message,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              decoration: TextDecoration.none),
                        ),
                      )),
                )),
          ),
          (chatMessage.to != 'client') ?
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: (chatMessage.ack ) ? Align(
              alignment: Alignment.centerRight,
              child: Text('Прочитано',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ): Align(
              alignment: Alignment.centerRight,
              child: Text('Доставлено',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ),
          ) :
          Container(height: 0,)
        ],
      ),
    );
  }
}