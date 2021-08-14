import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BusinessHome extends StatefulWidget {
  BusinessHome();

  @override
  _BusinessHome createState() {
    return new _BusinessHome();
  }
}

class _BusinessHome extends State<BusinessHome> {
  SharedPreferences prefs;
  String groupcd;
  String fname;
  String lname;
  String email;
  String mobileno;

  @override
  void initState() {
    super.initState();
    getsharedPreferences();
  }

  getsharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {

      try {
        fname = prefs.getString('fname');
        lname = prefs.get('lname');
        email = prefs.getString('email');
        mobileno = prefs.getString('mobileno');
        groupcd = prefs.getString('groupcd');
      } catch (_) {}


    });
  }

  GestureDetector gestureDetector(name, image) {
    return new GestureDetector(
      child: new RaisedButton(
          elevation: 2.0,
          highlightColor: Colors.black,
          splashColor: Colors.orange,
          colorBrightness: Brightness.dark,
          color: Colors.white,
          onPressed: () {
            if (name == "Bulk List") {
              if (groupcd == 'Farmer') {
                Navigator.pushReplacementNamed(
                    context, '/liveChickenOrderListFarmer');
              } else if (groupcd == 'Admin') {
                Navigator.pushReplacementNamed(
                    context, '/liveChickenOrderListAdmin');
              }
            } else if (name == "") {}
          },
          child: new FittedBox(
            alignment: Alignment.center,
            fit: BoxFit.none,
            child: new Column(
              children: <Widget>[
                new Image(
                  image: new AssetImage(image),
                ),
                SizedBox.fromSize(),
                new Center(
                  child: new Text(
                    name,
                    style: new TextStyle(
                      color: Color(0xff07426A),
                      fontSize: 11.0,
                    ),
                  ),
                  heightFactor: 2.0,
                )
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard'),backgroundColor: const Color.fromARGB(255, 244, 237, 232),),
      body: new Column(
        children: <Widget>[
          new Flexible(
            flex: 2,
            child: Card(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                    /*  Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            //onTap: () {},
                            child: ListTile(
                              trailing:  FlatButton(
                                textColor: Colors.white,
                                onPressed: () {
                                  showErrorDialog(context, 'Are you sure you want to Logout');
                                },
                                child: Text("Logout",style: TextStyle(color: Colors.black),),
                                shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                              ),
                              leading: CircleAvatar(
                                backgroundColor: const Color.fromARGB(255, 244, 237, 232),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text('${fname}'),
                              subtitle: Text('User Type : ${groupcd}'),
                            ),
                          ),

                        ],
                      ),*/
                    ],
                  )
                ],
              ),
            ),
          ),
          new Flexible(
            flex: 6,
            child: new GridView.count(
              primary: true,
              padding: const EdgeInsets.all(1.0),
              crossAxisCount: 3,
              //childAspectRatio: 0.80,
              mainAxisSpacing: 0.3,
              crossAxisSpacing: 0.3,
              children: <Widget>[
                gestureDetector("Bulk List", "assets/icons/blaze.png"),
                gestureDetector("Dashboard", "assets/icons/blaze.png"),
                gestureDetector("Ledger", "assets/icons/blaze.png"),
                gestureDetector("Credits", "assets/icons/blaze.png"),
                gestureDetector("Bulk List", "assets/icons/blaze.png")
              ],
            ),
          )
        ],
      ),
    );
  }

  //Alert dialogue to show error and response
  void showErrorDialog(BuildContext context, String message) {
    // set up the AlertDialog
    final CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Text('Message'),
      content: Text('\n$message'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Yes'),
          onPressed: () async{
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setString('fname','');
            sharedPreferences.setString('lname', '');
            sharedPreferences.setString('email', '');
            sharedPreferences.setString('mobileno', '');
            sharedPreferences.setString('groupcd', '');
            Navigator.pushReplacementNamed(context, '/mobileInputScreen');
          },
        )
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
