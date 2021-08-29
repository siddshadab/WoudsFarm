import 'package:flutter/cupertino.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  SharedPreferences prefs;
  String groupcd;
  String fname;
  String lname;
  String email;
  String mobileno;
  int currentIndex = 0;


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

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard'),backgroundColor: const Color.fromARGB(255, 244, 237, 232),),
      bottomNavigationBar: new BottomNavigationBar(
          onTap: onTabTapped, // new
          currentIndex: currentIndex,
          fixedColor: Colors.red,
          items: [
            BottomNavigationBarItem(
              icon:new Icon(FontAwesomeIcons.dashcube),
              title: Text("Dashboard"),
            ),
            BottomNavigationBarItem(
              icon:new Icon(FontAwesomeIcons.list),
              title: Text("bulkList"),
            ),
            BottomNavigationBarItem(
              icon:new Icon(FontAwesomeIcons.bitcoin),
              title: Text("Bargain"),
            )
          ]),
      body: new Column(
        children: <Widget>[
          new Expanded(
            //fit: FlexFit.tight,
            flex: 5,
            child:
                   Container(
                     height: size.height/2.5,
                     width: size.width,
                     color: const Color.fromARGB(255, 244, 237, 232),
                     child:    Card(
                        //semanticContainer: true,
                        //clipBehavior: Clip.antiAliasWithSaveLayer,
                        child:  mychart1Items("Sales by Month","421.3M","+12.9% of target"),

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

  Material mychart1Items(String title, String priceVal,String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(title, style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),),
                  ),

                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(priceVal, style: TextStyle(
                      fontSize: 30.0,
                    ),),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(subtitle, style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blueGrey,
                    ),),
                  ),

                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: new Sparkline(
                      data: data,
                      lineColor: Color(0xffff6101),
                      pointsMode: PointsMode.all,
                      pointSize: 8.0,
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
