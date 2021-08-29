import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'Constant.dart';


class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();


  //common POST service
  static Future<String> callPostService(String tojson,String url,final header,[context]) async{
    String retValue;
    print("url :>>>>>>>>>>>>> ${url}");
      if(Constant.isHttpsCallNeeded){
      return callPostServiceHttps(tojson,url,header);
    }
    try {
      final response = await http.post(Uri.parse(url), headers: header, body: tojson).timeout(Duration(minutes: 5 ));

      if (response.statusCode == 201 || response.statusCode ==200) {
        print(response.body.toString() +"    here is data ");
        print("coming");
        return response.body;
      }else  if (response.statusCode == 500 || response.body==null || response.body.toString()=='null') {
        print("status " + response.statusCode.toString() + " bodyval " +
            response.body.toString());
        return response.statusCode.toString()+" : errorResponse";
      }

    }catch(_){
        print(_);
        return "errorResponse";
    }
      return'';
  }

//common service
  static Future<String> callGetService(String url) async{
print(url);
    if(Constant.isHttpsCallNeeded){
      return callGetServiceHttps(url);
    }
    try {
      String retValue;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 201 || response.statusCode ==200) {
        retValue = response.body;
      } else if (response.statusCode == 500 || response.body==null || response.body=='null') {
        retValue = response.statusCode.toString();
      }
      return response.body;
    } catch (e) {
      print('Server Exception!!!');
      print(e);
      return "errorResponse";
    }
  }

//common service
  static Future<String> callPostServiceHttps(String tojson,String url,final header)async{
    String responsebody ='';
    var httpclient = new HttpClient();
    try{
      httpclient.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      await httpclient.postUrl(Uri.parse(url)).then((HttpClientRequest request) {
        request.headers.set('Content-Type', 'application/json');
        request.add(utf8.encode(tojson));
        return request.close();
      }).then((HttpClientResponse response) async {
        if (response == null || response.statusCode == 500 ||
            response.toString() == 'null') {
          print("status " + response.statusCode.toString() + " bodyval " +
              response.transform(utf8.decoder).join().toString());
          return response.statusCode.toString()+" : errorResponse";
        } else if (response.statusCode == 201 || response.statusCode == 200) {

          responsebody = await response.transform(utf8.decoder).join();
          print(responsebody.toString() +"    here is data ");

        }

      });
    }catch(_){
      print(_);
      return "errorResponse";
    }
    return responsebody;
  }


  static Future<String> callGetServiceHttps(String url) async{
    String responsebody ='';
    var httpclient = new HttpClient();
    httpclient.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    try {
      await httpclient.getUrl(Uri.parse(url)).then((HttpClientRequest request) {
        request.headers.set('Content-Type', 'application/json');
        return request.close();
      }).then((HttpClientResponse response) async {
        if (response == null || response.statusCode == 500 ||
            response.toString() == 'null') {
          responsebody = "404";
        } else if (response.statusCode == 201 || response.statusCode == 200) {
          responsebody = await response.transform(utf8.decoder).join();
        }
      });
    } catch(_){}
    return responsebody;

  }



  Future<String> get(String url) {
    return http.get(Uri.parse(url)).then((http.Response response) {
      final String res = response.body;
      print(res + " yahi hai woh ");
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

}






