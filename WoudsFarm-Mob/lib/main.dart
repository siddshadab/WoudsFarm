// @dart=2.9
import 'package:flutter/material.dart';
import 'package:wouds_farm/views/mobile/home/OrderPage.dart';
import 'package:wouds_farm/views/mobile/kyc_form/BusinessRegistration.dart';
import 'package:wouds_farm/views/mobile/login_signup/otp_page.dart';
import 'package:wouds_farm/views/mobile/login_signup/LoginRegistration.dart';


import 'shared/app_theme.dart';

import 'views/mobile/login_signup/mobile_screen.dart';
import 'widgets/responsive.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WoudsFarm',
      debugShowCheckedModeBanner: false,
      theme: appPrimaryTheme(),
      home: Responsive(
        mobile: MobileScreen(),
      ),
      routes: <String, WidgetBuilder>{
        '/otpScreen': (BuildContext ctx) => OtpScreen(),
        '/businessRegistration':(BuildContext ctx) => BusinessRegistration(),
        '/loginRegistration':(BuildContext ctx) => LoginRegistration(),
        '/home':(BuildContext ctx) => OrderPage(),
      },
    );
  }
}
