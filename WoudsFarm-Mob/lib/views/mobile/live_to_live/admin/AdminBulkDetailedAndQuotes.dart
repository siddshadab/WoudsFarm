import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:wouds_farm/models/live_chicken_model.dart';
import 'package:wouds_farm/shared/Constant.dart';
import 'package:wouds_farm/shared/NetworkUtil.dart';
import 'package:intl/intl.dart';

class AdminBulkDetailedList extends StatefulWidget {
  bool _isInit = true;
  LiveChickenModelFromServer data ;

  @override
  _AdminBulkDetailedList createState() => _AdminBulkDetailedList();
}

class _AdminBulkDetailedList extends State<AdminBulkDetailedList> {

  //this is method is used to initialize data
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Load data only once after screen load
    if (widget._isInit) {
      widget.data = ModalRoute.of(context).settings.arguments as LiveChickenModelFromServer;
      // generateOtp(widget._contact);
      widget._isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 237, 232),
      appBar: AppBar(title: Text('Admin Records Wise Checkout'),backgroundColor: const Color.fromARGB(255, 244, 237, 232),),
      body: FutureBuilder<LiveChickenModelFromServer>(
        builder: (context, snapshot) {
          return _LiveChickenListView(widget.data);
        },
      ),
    );
  }


  ListView _LiveChickenListView(data) {
    return ListView.builder(
        itemCount: data.data.length,
        itemBuilder: (context, index) {
          return _list(data,data.data[index]);
        });
  }

  Widget _list(LiveChickenModelFromServer data, LiveChickenModel model){
    double c_width = MediaQuery.of(context).size.width * 10;
    return new GestureDetector(
      onTap: () {
        //_onTapItem(context, items[index]);
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
                          padding: EdgeInsets.only(left: 5.0),
                          //color: Colors.green,
                          child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[

                              Flexible(
                                  flex :7,
                                  child:  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child:Text(
                                      "Record Time:" +
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
                                        Icons.add,
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
                      new Container(
                          padding: EdgeInsets.only(left: 5.0),
                          //color: Colors.green,
                          child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[

                              Flexible(
                                flex : 3,
                                child:Padding(
                                  padding: new EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      new Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 16.0,
                                      ),

                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        "Admin",
                                        style: TextStyle(
                                            fontSize: 12.0, color: Colors.white),
                                      ),


                                    ],
                                  ),
                                ),
                              )

                            ],
                          )),
                      new Container(
                          padding: EdgeInsets.only(left: 5.0),
                          //color: Colors.green,
                          child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[



                              Flexible(
                                flex : 3,
                                child:Padding(
                                  padding: new EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      new Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 16.0,
                                      ),

                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        "Farmer",
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
                            Row(
                              children: <Widget>[
                                model.farmerQuote != null ||
                                    model.farmerQuote != ""
                                    ? Text(
                                  "Farmer quote :" +
                                      model.farmerQuote.toString(),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey[500],
                                  ),
                                )
                                    : Text(
                                  "Farmer Quote :",
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
                            Row(
                              children: <Widget>[
                                model.type != null ||
                                    model.type != ""
                                    ? Text(
                                  "Chiken Size :" +
                                      model.type.toString(),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey[500],
                                  ),
                                )
                                    : Text(
                                  "Chiken Size :",
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
                            SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              children: <Widget>[
                                model.serverWeight != null ||
                                    model.serverWeight != ""
                                    ? Text(
                                  "Chiken Quantity in Tons :" +
                                      model.serverWeight.toString(),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey[500],
                                  ),
                                )
                                    : Text(
                                  "Chiken Quantity in Tons :",
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
  Widget _tile(String title, String subtitle, IconData icon) => ListTile(
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