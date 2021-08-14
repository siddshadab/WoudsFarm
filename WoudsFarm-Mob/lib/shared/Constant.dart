import 'dart:convert';

class Constant{

  static const String BASE_URL = 'http://192.168.71.106:8090/api/v1/';
  static const bool isHttpsCallNeeded = false;
  static final headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();

  //FieldNames

static const fname = 'fname';


  static String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return 'Enter a valid email address';
    else
      return null;
  }

}