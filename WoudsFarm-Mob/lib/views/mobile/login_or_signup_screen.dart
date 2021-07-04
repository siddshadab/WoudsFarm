import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wouds_farm/views/mobile/otp_page.dart';
import 'package:wouds_farm/views/mobile/search/search_screen.dart';
import 'package:wouds_farm/views/mobile/wouds_farm/wouds_farm_screen.dart';

import '../../utils/app_colors.dart';
import 'account/account_screen.dart';
import 'cart/cart_screen.dart';

class LoginOrSignUpScreen extends StatefulWidget {
  @override
  _LoginOrSignUpScreen createState() => _LoginOrSignUpScreen();
}

class _LoginOrSignUpScreen extends State<LoginOrSignUpScreen> {

    var phoneCode="";
    var phoneNumber="";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final labelTextStyle = Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 8.0);
    return Scaffold(
      body:  Form(
        onChanged: (){

        },
        key: _formKey,
        child:Container(
          color: Colors.brown[100],
              alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Login or create a new Account",
                style: TextStyle(color: Colors.brown,fontSize: 18.0),
              ),
            ),
            SizedBox(height: 30.0),
            Align(
              alignment: Alignment.centerRight,
              child: IntlPhoneField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Phone Number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                onChanged: (phone) {
                  print(phone.completeNumber);
                  phoneNumber = phone.number as String;
                },
                onCountryChanged: (phone) {
                  phoneCode=phone.countryCode as String;
                  print('Country code changed to: ' + phone.completeNumber);
                },
              ),

            ),
            SizedBox(height: 30.0),
            Align(
                alignment: Alignment.center,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: RaisedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Getting OTP on '+phoneCode+" "+phoneNumber)));
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpPage(phoneNumber: phoneCode+" "+phoneNumber),
                        ),
                      );
                    },
                    color: Colors.brown,
                    icon: Icon(
                      Icons.security,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Processed Securely",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
            ),
            SizedBox(height: 200.0),
            Container(

                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Colors.brown,
                        Colors.brown
                      ],
                    )

                ),
                alignment: Alignment.bottomCenter,


                child: new Text("By Proceeding you are agreeing with terms and condition & Our Privacy policy",
                    style: TextStyle(color: Colors.white),
                )

            ),
          ],)

          ),

    ),
    );
  }
}
