import 'dart:convert';

class Constant{

  static const String BASE_URL = 'http://192.168.71.106:8090/api/v1/';
  static const bool isHttpsCallNeeded = false;
  static final headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();

  //FieldNames

static const fname = 'fname';
}