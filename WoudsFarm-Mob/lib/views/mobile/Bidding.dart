import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wouds_farm/models/BiddingModel.dart';
import 'package:wouds_farm/models/UserModel.dart';
import 'package:wouds_farm/shared/Constant.dart';
import 'package:wouds_farm/shared/NetworkUtil.dart';

String loggedInuser;
String groupcode;
String fname;
String lname;
String email;
String mobileno;


class BiddingScreen extends StatefulWidget {


  const BiddingScreen({Key key}) : super(key: key);

  @override
  BiddingScreenState createState() {
    return new BiddingScreenState();
  }
}

class BiddingScreenState extends State<BiddingScreen> {
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    getsharedPreferences();

  }

  getsharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      try {
        fname = prefs.getString('fname');
        lname = prefs.get('lname');
        email = prefs.getString('email');
        mobileno = prefs.getString('mobileno');
        groupcode = prefs.getString('groupcd');
        loggedInuser = email;
      } catch (_) {}
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 237, 232),
    body:FutureBuilder<List<UserModel>>(
      future: _fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<UserModel> data = snapshot.data;
          return  Scaffold(
              backgroundColor: const Color.fromARGB(255, 244, 237, 232),
              appBar: AppBar(title: Text('Farmer Bulk List'),backgroundColor: const Color.fromARGB(255, 244, 237, 232),
                actions: <Widget>[
                  FlatButton(
                    textColor: Colors.white,
                    onPressed: () {
                      Constant.showErrorDialog(context, 'Are you sure you want to Logout');
                    },
                    child: Text("Logout"),
                    shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                  ),
                ],
              ),
              body:listOfUsers(data));
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"),);
        }
        return new Center(child:new CircularProgressIndicator());
      },
    ),
    );
  }

  Widget listOfUsers(List<UserModel> data) {
    return  new ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, i) => new Column(
        children: <Widget>[
          new Divider(
            height: 10.0,
          ),
          new ListTile(
            onTap: (){
              Navigator.pushReplacementNamed(
                  context, '/biddingChats');
            },
            leading: new CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey,
              backgroundImage: new NetworkImage(dummyData[i].avatarUrl),
            ),
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  data[i].email,
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),

              ],
            ),
            subtitle: new Row(
              children:[
              new Text(
                data[i].mobileno,
                style: new TextStyle(color: Colors.grey, fontSize: 15.0),
              ),
                SizedBox(width: 10.0,),
                new Text(
                  data[i].firstName +" "+data[i].lastName  ,
                  style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ]
            ),

          )
        ],
      ),
    );
  }
}


Future<List<UserModel>> _fetchData() async {
  String bodyValue  = await NetworkUtil.callGetService(Constant.BASE_URL.toString()+'signin/getAllUsersonGrpCd?getUsers=${groupcode}');

  if(bodyValue.contains('errorResponse')){
    throw Exception('Failed to load jobs from API');
  }else{

    Map jsonResponse = json.decode(bodyValue);

    List<UserModel> ret = jsonResponse['data'].map<UserModel>((live) => new UserModel.fromJson(live)).toList();

    return ret;
  }

}