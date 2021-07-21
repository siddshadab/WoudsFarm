import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wouds_farm/models/live_chicken_model.dart';
import 'package:wouds_farm/shared/Constant.dart';
import 'package:wouds_farm/shared/NetworkUtil.dart';

class OrderListView extends StatefulWidget {
  @override
  _OrderListView createState() => _OrderListView();
}

class _OrderListView extends State<OrderListView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 237, 232),
    body: FutureBuilder<List<LiveChickenModelFromServer>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<LiveChickenModelFromServer> data = snapshot.data;
          return _LiveChickenListView(data);
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"),);
        }
        return new Center(child:new CircularProgressIndicator());
      },
    ),
    );
  }

  Future<List<LiveChickenModelFromServer>> _fetchJobs() async {
      String bodyValue  = await NetworkUtil.callGetService(Constant.BASE_URL.toString()+'LiveToLive/?mobileNo=9987272169');

      print(bodyValue);
      if(bodyValue.contains('errorResponse')){
        throw Exception('Failed to load jobs from API');
      }else{

        Map jsonResponse = json.decode(bodyValue);
         print(jsonResponse);
        List<LiveChickenModelFromServer> ret = jsonResponse['data'].map<LiveChickenModelFromServer>((live) => new LiveChickenModelFromServer.fromServerJson(live)).toList();
        print('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
        print(ret.toString());
        return ret;
      }

  }

  ListView _LiveChickenListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(data[0].data[index].isActive.toString(), data[0].data[index].inQueue, Icons.work);
        });
  }

  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
    title: Text(title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: Colors.blue[500],
    ),
  );
}