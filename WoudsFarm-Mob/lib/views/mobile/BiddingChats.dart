import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wouds_farm/models/BiddingChatsModel.dart';
import 'package:wouds_farm/shared/Constant.dart';
import 'package:wouds_farm/shared/NetworkUtil.dart';

String loggedInuser;
String groupcd;
String fname;
String lname;
String email;
String mobileno;
String reciever ='Dummy';
final focusNode = FocusNode();

class BiddingChats extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  _BiddingChatsState createState() => _BiddingChatsState();
}

class _BiddingChatsState extends State<BiddingChats> {
  final controller = TextEditingController();
  //// final _auth = FirebaseAuth.instance;
  bool isEmojiVisible = false;
  bool isKeyboardVisible = false;
  var messageText;

  SharedPreferences prefs;

  getsharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      try {
        fname = prefs.getString('fname');
        lname = prefs.get('lname');
        email = prefs.getString('email');
        mobileno = prefs.getString('mobileno');
        groupcd = prefs.getString('groupcd');
        loggedInuser = email;
      } catch (_) {}
    });
  }

  @override
  void initState() {
    super.initState();
    getsharedPreferences();
    reciever = 'Dummy';
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool isKeyboardVisible) {
      setState(() {
        this.isKeyboardVisible = isKeyboardVisible;
      });

      if (isKeyboardVisible && isEmojiVisible) {
        setState(() {
          isEmojiVisible = false;
        });
      }
    });
  }

  Future toggleEmojiKeyboard() async {
    if (isKeyboardVisible) {
      FocusScope.of(context).unfocus();
    }

    setState(() {
      isEmojiVisible = !isEmojiVisible;
    });
  }

  Future<bool> onBackPress() {
    if (isEmojiVisible) {
      toggleEmojiKeyboard();
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  @override
  void dispose() async {
    super.dispose();
    //await _auth.signOut();
  }

  void onEmojiSelected(String emoji) => setState(() {
        controller.text = controller.text + emoji;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                // _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('Messages'),
        backgroundColor: const Color.fromARGB(255, 244, 237, 232),
      ),
      body: SafeArea(
        child: WillPopScope(
          onWillPop: onBackPress,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(),
              Container(
                width: double.infinity,
                height: 50.0,
                decoration: new BoxDecoration(
                    border: new Border(
                        top:
                            new BorderSide(color: Colors.blueGrey, width: 0.5)),
                    color: Colors.white),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Material(
                      child: new Container(
                        margin: new EdgeInsets.symmetric(horizontal: 1.0),
                        child: new IconButton(
                          icon: new Icon(isEmojiVisible
                              ? Icons.keyboard_rounded
                              : Icons.emoji_emotions),
                          onPressed: onClickedEmoji,
                          color: Colors.blueGrey,
                        ),
                      ),
                      color: Colors.white,
                    ),
                    Flexible(
                      child: Container(
                        child: TextField(
                          textInputAction: TextInputAction.send,
                          keyboardType: TextInputType.multiline,
                          focusNode: focusNode,
                          onSubmitted: (value) async {
                            controller.clear();
                            BiddingChatsModel biddingChatsModel =
                                new BiddingChatsModel();
                            biddingChatsModel.email = email;
                            biddingChatsModel.sender = groupcd=='Admin'?'ADMIN':email;
                            biddingChatsModel.message = messageText;
                            biddingChatsModel.reciever =  groupcd=='Admin'?reciever:'ADMIN';

                            await submitMessageData(biddingChatsModel)
                                .then((value) => setState(() {}));
                          },
                          maxLines: null,
                          controller: controller,
                          onChanged: (value) {
                            messageText = value;
                          },
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 15.0),
                          //decoration: kMessageTextFieldDecoration,
                        ),
                      ),
                    ),
                    Material(
                      child: new Container(
                        margin: new EdgeInsets.symmetric(horizontal: 8.0),
                        child: new IconButton(
                          icon: new Icon(Icons.send),
                          onPressed: () async {
                            controller.clear();
                            BiddingChatsModel biddingChatsModel =
                            new BiddingChatsModel();
                            biddingChatsModel.email = email;
                            biddingChatsModel.sender = groupcd=='Admin'?'ADMIN':email;
                            biddingChatsModel.message = messageText;
                            biddingChatsModel.reciever =  groupcd=='Admin'?reciever:'ADMIN';

                            await submitMessageData(biddingChatsModel)
                                .then((value) => setState(() {}));
                          },
                          color: Colors.blueGrey,
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onClickedEmoji() async {
    if (isEmojiVisible) {
      focusNode.requestFocus();
    } else if (isKeyboardVisible) {
      await SystemChannels.textInput.invokeMethod('TextInput.hide');
      await Future.delayed(Duration(milliseconds: 100));
    }
    toggleEmojiKeyboard();
  }
}

String giveUsername(String email) {
  return fname + " " + lname;
}

Future<void> submitMessageData(BiddingChatsModel biddingChatsModel) async {
  try {
    String json = await _toJson(biddingChatsModel);
    await NetworkUtil.callPostService(
        json, Constant.BASE_URL.toString() + 'biddingChats/', Constant.headers);
  } catch (_) {}
}

Future<String> _toJson(BiddingChatsModel biddingChatsModel) async {
  var mapData = biddingChatsModel.toJson();
  String json = Constant.JSON.encode(mapData);
  return json;
}

Future<List<BiddingChatsModel>> getMessages() async {
  String bodyValue = await NetworkUtil.callGetService(
      Constant.BASE_URL.toString() +
          'biddingChats/?sender=${groupcd=='Admin'?'ADMIN':email}&reciever=${groupcd=='Admin'?reciever:'ADMIN'}');

  if (bodyValue.contains('errorResponse')) {
    throw Exception('Failed to load jobs from API');
  } else {
    Map jsonResponse = json.decode(bodyValue);

    List<BiddingChatsModel> ret = jsonResponse['data']
        .map<BiddingChatsModel>(
            (live) => new BiddingChatsModel.fromServerJson(live))
        .toList();

    return ret;
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BiddingChatsModel>>(
      future: getMessages(),
      builder: (context, snapshot) {
        // If we do not have data yet, show a progress indicator.
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        // Create the list of message widgets.

        // final messages = snapshot.data.documents.reversed;
        List<Widget> messageWidgets = snapshot.data.map<Widget>((m) {
          return MessageBubble(
            sender: m.sender,
            reciever: m.reciever,
            message: m.message,
            mcreateddt: m.metadata.mcreateddt,
            isMe:  email == m.email,
            mlastupdatedt: m.metadata.mlastupdatedt,
          );
        }).toList();

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {this.sender,
      this.message,
      this.isMe,
      this.reciever,
      this.mlastupdateby,
      this.mcreateddt,
      this.mcreatedby,
      this.mlastupdatedt});
  final String sender;
  final String reciever;
  final String mcreatedby;
  final String mlastupdateby;
  final String mcreateddt;
  final String mlastupdatedt;
  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(
        DateTime.parse(mcreateddt).second * 1000);
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${giveUsername(sender)}",
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Colors.grey : Colors.lightBlue,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: isMe ? Colors.white : Colors.black54,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      "${DateFormat('h:mm a').format(dateTime)}",
                      style: TextStyle(
                        fontSize: 9.0,
                        color: isMe
                            ? Colors.white.withOpacity(0.5)
                            : Colors.black54.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
