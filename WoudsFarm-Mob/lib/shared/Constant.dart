import 'dart:convert';

class Constant{

  static const String BASE_URL = 'http://10.0.2.2:8090/api/v1/';
  static const bool isHttpsCallNeeded = false;
  static final headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();

  //FieldNames

static const fname = 'fname';
}