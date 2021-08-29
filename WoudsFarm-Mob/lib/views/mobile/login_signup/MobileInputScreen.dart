import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wouds_farm/shared/Constant.dart';
import 'package:wouds_farm/shared/NetworkUtil.dart';
import 'package:wouds_farm/views/mobile/login_signup/otp_page.dart';





class MobileInputScreen extends StatefulWidget {
  @override
  _MobileInputScreen createState() => _MobileInputScreen();
}

class _MobileInputScreen extends State<MobileInputScreen> {
  final _contactEditingController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _dialCode="";
  var phoneNumber="";

  //Login click with contact number validation
  Future<void> clickOnLogin(BuildContext context) async {
    Constant.onLoading(context);
    if (phoneNumber.isEmpty) {
      showErrorDialog(context, 'Contact number can\'t be empty.');
    } else {
      bool isMobilePresent = await submitData('$_dialCode${phoneNumber}');
      Navigator.pop(context);
      if(isMobilePresent){
        Navigator.pushNamed(context, '/login', arguments: '$_dialCode${phoneNumber}');
      }else{
        final responseMessage = //Call OTP Channel
        await Navigator.pushNamed(context, '/otpScreen', arguments: '$_dialCode${phoneNumber}');
        //Navigator.pushReplacementNamed(context, '/home');
        if (responseMessage != null) {
          showErrorDialog(context, responseMessage as String);
        }
      }

    }
  }

  Future<bool> submitData(mobileno) async{
    try {
      String json = await _toJson(mobileno);
      String bodyValue  = await NetworkUtil.callPostService(json,Constant.BASE_URL.toString()+'signin/mobileCheck',Constant.headers);
      if(bodyValue.contains('errorResponse')){

      }else {
        print(bodyValue);
        Map<String, dynamic> json = Constant.JSON.decode(bodyValue);
        bool IsMobieAvalable  = json['IsMobieAvalable'];
        if ( IsMobieAvalable == true) {
          return true;
        }else{
          return false;
        }
      }
      print(bodyValue);
    } catch(_){}

  }

  Future<String> _toJson(mobileno) async{
    var mapData =  toJson(mobileno);
    String json = Constant.JSON.encode(mapData);
    return json;

  }

  Map<String, dynamic> toJson(mobileNo) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileno'] = mobileNo;
    return data;
  }
  //callback function of country picker
  void _callBackFunction(String name, String dialCode, String flag) {
    _dialCode = dialCode;
  }

  //Alert dialogue to show error and response
  void showErrorDialog(BuildContext context, String message) {
    // set up the AlertDialog
    final CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Text('Error'),
      content: Text('\n$message'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop();
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

  //build method for UI Representation
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 237, 232),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.05,
                ),

                Image.asset(
                  'assets/images/wouds_farm.jpg',
                  height: screenHeight * 0.3,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 28, color: Colors.black),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                const Text(
                  'Enter your mobile number to receive a verification code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth > 600 ? screenWidth * 0.2 : 16),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 244, 237, 232),
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        height: 60,

                        child: IntlPhoneField(
                         initialCountryCode: 'IN',
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
                            _dialCode=phone.countryCode as String;
                          },
                          onCountryChanged: (phone) {
                            _dialCode=phone.countryCode as String;
                            print('Country code changed to: ' + phone.completeNumber);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(36),
                        ),
                        alignment: Alignment.center,
                        child: CustomButton(clickOnLogin),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 50,),
                Column(mainAxisAlignment: MainAxisAlignment.end,children: [Container(

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

                )],),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final clickOnLogin;

  // ignore: sort_constructors_first
  const CustomButton(this.clickOnLogin);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        clickOnLogin(context);
      },
      child: Container(
          margin: const EdgeInsets.all(8),
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.brown,
            borderRadius: BorderRadius.circular(36),
          ),
          alignment: Alignment.center,
          child:Directionality(
            textDirection: TextDirection.rtl,
            child: RaisedButton.icon(
              onPressed: () {
                clickOnLogin(context);
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
    );
  }
}






