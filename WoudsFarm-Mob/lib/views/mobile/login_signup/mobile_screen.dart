import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wouds_farm/models/UserModel.dart';
import 'package:wouds_farm/views/mobile/login_signup/MobileInputScreen.dart';

class MobileScreen extends StatefulWidget {
  @override
  _MobileScreen createState() => _MobileScreen();
}

Widget widget;

class _MobileScreen extends State<MobileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    route(context);
  }

  Future<Widget> route(BuildContext context) async {
    UserModel user = new UserModel();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      user.fname = sharedPreferences.getString('fname');
      user.lname = sharedPreferences.get('lname');
      user.email = sharedPreferences.getString('email');
      user.mobileno = sharedPreferences.getString('mobileno');
      user.groupcd = sharedPreferences.getString('groupcd');
    } catch (_) {}

    if (user.groupcd == 'Farmer' || user.groupcd == 'Admin') {
      widget =
          Navigator.pushReplacementNamed(context, '/businessHome') as Widget;
    } else if (user.groupcd == 'Trader') {
      widget = Navigator.pushReplacementNamed(context, '/home') as Widget;
    } else if (user.groupcd == 'Restaurant') {
      widget = Navigator.pushReplacementNamed(context, '/home') as Widget;
    } else {
      widget = Navigator.pushReplacementNamed(context, '/mobileInputScreen')
          as Widget;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget != null
        ? widget
        : new Center(
            child: Text('Loading'),
          );
  }
}
