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

  Widget gestureDetector(name, image) {
    if(groupcd == 'Farmer' && (name == 'Ledger' || name == 'Bargain' || name == 'Bulk List' || name == 'Credits')){
      return Container();
    }


    return new GestureDetector(
      child: new RaisedButton(
          elevation: 6.0,
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
            } else if (name == "Bidding") {

              Navigator.pushReplacementNamed(
                  context, '/bidding');
            }else if (name == "Dashboard") {

              Navigator.pushReplacementNamed(
                  context, '/dashboard');
            }
          },
          child: new FittedBox(
            alignment: Alignment.center,
            fit: BoxFit.cover,
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard'),backgroundColor: const Color.fromARGB(255, 244, 237, 232),),
      body: new Column(
        children: <Widget>[
          new Expanded(
            //fit: FlexFit.tight,
            flex: 4,
            child:
                   Container(
                     height: size.height/3,
                     width: size.width,
                     color: const Color.fromARGB(255, 244, 237, 232),
                     child:    Card(
                        //semanticContainer: true,
                        //clipBehavior: Clip.antiAliasWithSaveLayer,
                        child:Image.asset(
                          'assets/images/wouds_farm.jpg',
                          fit: BoxFit.fill,
                        ),
                         shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10.0),
                         ),
                        elevation: 5,
                        //margin: EdgeInsets.all(10),
                      ),
                       )
          ),
          new Expanded(
            flex: 8,
            child: new GridView.count(
              primary: true,
              padding: const EdgeInsets.all(1.0),
              crossAxisCount: 3,
              //childAspectRatio: 0.80,
              mainAxisSpacing: 0.3,
              crossAxisSpacing: 0.3,
              children: <Widget>[
                gestureDetector("Bulk List", "assets/icons/hen.png"),
                gestureDetector("Dashboard", "assets/icons/dashboard.png"),
                gestureDetector("Ledger", "assets/icons/ledger.png"),
                gestureDetector("Credits", "assets/icons/cashback.png"),
                gestureDetector("Bidding", "assets/icons/bidding.png"),
                gestureDetector("Bidding History", "assets/icons/more.png"),
                gestureDetector("Bargain", "assets/icons/bidding.png"),
                gestureDetector("todays Paper rate", "assets/icons/bidding.png"),
                gestureDetector("Later", "assets/icons/bidding.png"),
                gestureDetector("Later", "assets/icons/bidding.png"),
                gestureDetector("Later", "assets/icons/bidding.png"),
                gestureDetector("Later", "assets/icons/bidding.png"),
                gestureDetector("Later", "assets/icons/bidding.png"),
                gestureDetector("Later", "assets/icons/bidding.png"),
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
