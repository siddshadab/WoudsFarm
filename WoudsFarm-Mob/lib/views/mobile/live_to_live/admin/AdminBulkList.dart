import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wouds_farm/models/live_chicken_model.dart';
import 'package:wouds_farm/shared/Constant.dart';
import 'package:wouds_farm/shared/NetworkUtil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:wouds_farm/models/live_chicken_model.dart';
import 'package:wouds_farm/shared/Constant.dart';
import 'package:wouds_farm/shared/NetworkUtil.dart';
import 'package:intl/intl.dart';

class AdminBulkList extends StatefulWidget {
  @override
  _AdminBulkList createState() => _AdminBulkList();
}

class _AdminBulkList extends State<AdminBulkList> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 237, 232),
      body: FutureBuilder<List<LiveChickenModelFromServer>>(
        future: _fetchJobs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<LiveChickenModelFromServer> data = snapshot.data;
            return  Scaffold(
                backgroundColor: const Color.fromARGB(255, 244, 237, 232),
                appBar: AppBar(title: Text('Admin Bulk List'),backgroundColor: const Color.fromARGB(255, 244, 237, 232),),
                body:_LiveChickenListView(data));
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

    if(bodyValue.contains('errorResponse')){
      throw Exception('Failed to load jobs from API');
    }else{

      Map jsonResponse = json.decode(bodyValue);

      List<LiveChickenModelFromServer> ret = jsonResponse['data'].map<LiveChickenModelFromServer>((live) => new LiveChickenModelFromServer.fromServerJson(live)).toList();

      return ret;
    }

  }

  ListView _LiveChickenListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          print(data);
          return _list(data[index]);
        });
  }

  Widget _list(data){
    double c_width = MediaQuery.of(context).size.width * 10;
    return new GestureDetector(
      onTap: () async{
        await Navigator.pushNamed(context, '/liveChickenOrderDetailedListTrader', arguments: data);
      },
      child: new Card(
        //color Color(0xff2f1f4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 25.0,
        child: new Padding(
          padding: new EdgeInsets.only(
            left: 3.0,
            right: 3.0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 3.0),

                // width: c_width,
                child: Container(
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          Colors.brown,
                          Colors.orange,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  //color: color,
                  child: Column(
                    children: <Widget>[
                      new Text(
                        data.mobileNo,
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      new Container(
                          padding: EdgeInsets.only(left: 8.0),
                          //color: Colors.green,
                          child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[

                              Flexible(
                                  flex :7,
                                  child:  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child:Text(
                                      "Bulk Time:" +
                                          DateFormat("yyyy, MM, dd")
                                              .format(DateTime.parse(data.metadata.mcreateddt)),
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.white),
                                    ),)


                              ),

                              Flexible(
                                flex : 3,
                                child:Padding(
                                  padding: new EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      new Icon(
                                        FontAwesomeIcons.userCircle,
                                        color: Colors.white,
                                        size: 16.0,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        "Trader1",
                                        style: TextStyle(
                                            fontSize: 12.0, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              )

                            ],
                          )),

                    ],
                  ),
                ),
              ),

              new Container(
                width: c_width,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 5.0,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              children: <Widget>[
                                data.id != null ||
                                    data.id != ""
                                    ? Text(
                                  "Id :" +
                                      data.id.toString(),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey[500],
                                  ),
                                )
                                    : Text(
                                  "Id :",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.0,
                            ),


                          ],
                        ),
                      ],
                    ),
                    new ButtonTheme(
                      padding: new EdgeInsets.all(2.0),
                      child: new ButtonBar(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new IconButton(
                            icon: new Icon(
                              FontAwesomeIcons.clipboardCheck,

                            ),
                            onPressed: () async {

                            },
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  ListTile _tile(LiveChickenModelFromServer data,String title, String subtitle, IconData icon) => ListTile(
    onTap: ()async{
      await Navigator.pushNamed(context, '/liveChickenOrderDetailedListTrader', arguments: data);
    },
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