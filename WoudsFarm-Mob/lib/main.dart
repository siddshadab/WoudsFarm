// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wouds_farm/DummyCharts.dart';
import 'package:wouds_farm/models/UserModel.dart';
import 'package:wouds_farm/views/mobile/Bidding.dart';
import 'package:wouds_farm/views/mobile/BiddingChats.dart';
import 'package:wouds_farm/views/mobile/home/BusinessHome.dart';
import 'package:wouds_farm/views/mobile/home/OrderPage.dart';
import 'package:wouds_farm/views/mobile/kyc_form/BusinessRegistration.dart';
import 'package:wouds_farm/views/mobile/live_to_live/admin/AdminBulkDetailedAndQuotes.dart';
import 'package:wouds_farm/views/mobile/live_to_live/admin/AdminBulkList.dart';
import 'package:wouds_farm/views/mobile/live_to_live/farmer/FarmerBulkDetailedAndQuotes.dart';
import 'package:wouds_farm/views/mobile/live_to_live/farmer/FarmerBulkList.dart';
import 'package:wouds_farm/views/mobile/live_to_live/trader/TraderBulkDetailedList.dart';
import 'package:wouds_farm/views/mobile/live_to_live/trader/TraderBulkList.dart';
import 'package:wouds_farm/views/mobile/live_to_live/trader/place_order.dart';
import 'package:wouds_farm/views/mobile/login_signup/Login.dart';
import 'package:wouds_farm/views/mobile/login_signup/MobileInputScreen.dart';
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
        '/businessHome':(BuildContext ctx) => BusinessHome(),
        '/otpScreen': (BuildContext ctx) => OtpScreen(),
        '/businessRegistration':(BuildContext ctx) => BusinessRegistration(),
        '/loginRegistration':(BuildContext ctx) => LoginRegistration(),
        '/login': (BuildContext ctx) => Login(),
        '/home':(BuildContext ctx) => OrderPage(),
        '/placeLiveChickenOrder':(BuildContext ctx) => PlaceLiveChickenOrder(),
        '/liveChickenOrderListTrader':(BuildContext ctx) => TraderBulkList(),
        '/liveChickenOrderDetailedListTrader':(BuildContext ctx) => TraderBulkDetailedList(),
        '/liveChickenOrderListFarmer':(BuildContext ctx) => FarmerBulkList(),
        '/liveChickenOrderDetailedListFarmer':(BuildContext ctx) => FarmerBulkDetailedList(),
        '/liveChickenOrderListAdmin':(BuildContext ctx) => AdminBulkList(),
        '/liveChickenOrderDetailedListAdmin':(BuildContext ctx) => AdminBulkDetailedList(),
        '/mobileInputScreen':(BuildContext ctx) => MobileInputScreen(),
        '/bidding':(BuildContext ctx) => BiddingScreen(),
        '/biddingChats':(BuildContext ctx) => BiddingChats(),
        '/dashboard':(BuildContext ctx) => DummyCharts(),
      },
    );
  }
}
