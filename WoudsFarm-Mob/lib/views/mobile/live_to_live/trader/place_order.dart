import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wouds_farm/models/item.dart';
import 'package:wouds_farm/models/live_chicken_model.dart';
import 'package:wouds_farm/shared/Constant.dart';
import 'package:wouds_farm/shared/NetworkUtil.dart';
import 'package:wouds_farm/widgets/TextInputDecoration.dart';

// import 'package:lokalgrub/utilities/colors.dart';
// import 'package:lokalgrub/widgets/common_widgets.dart';

class PlaceLiveChickenOrder extends StatefulWidget {
  @override
  _PlaceLiveChickenOrder createState() => _PlaceLiveChickenOrder();
}

class _PlaceLiveChickenOrder extends State<PlaceLiveChickenOrder> {

  LiveChickenModel model = LiveChickenModel();
  List _items =  new List<LiveChickenModel>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();// to store Live chicken data

  final myController = TextEditingController();

  void _addComment() {
    setState(() {
        _items.add(model);
        model= new LiveChickenModel();
        _formKey = GlobalKey<FormState>();// add new Chicken Type and weight to the existing list
      });
  }

  double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 237, 232),
      body:
            Container(
                padding: EdgeInsets.all(15),
                child: Column(children: [
                  SizedBox(height: 40.0),
                  Text(
                    "Live Chicken Quotes",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(height: 40.0),
                Form(
                    key: _formKey,
                    child:Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 40.0,),
                        Expanded(
                            child: DropdownButton(
                              dropdownColor: Colors.white,
                              hint: Text('Chicken Weight  ', style: TextStyle(color: Colors.black)),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(color: Colors.blue),
                              items: [
                                '1.1','1.2','1.3','1.5','2.0','3.0'
                              ].map(
                                    (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(
                                      val,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                   model.type = val.toString();

                              },
                            ),),
                        SizedBox(width: 40.0,),
                        Expanded(
                            child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Weight in Ton '),
                                validator: (val) => val.isEmpty ? 'Enter  Weight ' : null,
                                onSaved: (val){
                                  model.weight = double.parse(val);
                                },
                                onChanged: (val) {
                                   _formKey.currentState.save();
                                }

                                ),),


                      ]),
                ),
                  SizedBox(height: 20),
                  MaterialButton(
                    onPressed: () {
                      _addComment();
                    },
                    color: Colors.brown,
                    elevation: 0,
                    child: Text(
                      'Add to cart',
                      style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    height: 50,
                    minWidth: screenWidth - 150,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45)),
                  ),


                  SizedBox(height: 10),
                  Expanded(
                      child: ListView.builder(
                          itemCount: _items?.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Card(
                              color: const Color.fromARGB(255, 244, 237, 232),
                              elevation: 0.7,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
                              child:Container(
                                width: screenWidth,
                                height: 60,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.brown,
                                      //backgroundImage: AssetImage(_food.image),
                                    ),
                                    Text('${_items[index].type}',
                                        style: TextStyle(color: Colors.brown, fontSize: 16)),
                                    Text('x', style: TextStyle(color: Colors.brown, fontSize: 16)),
                                    Container(
                                      width: screenWidth * 0.5,
                                      child: Text('${_items[index].weight}',
                                          maxLines: 2,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(color: Colors.brown, fontSize: 16)),
                                    ),
                                    Text('\$${(0).toStringAsFixed(2)}',
                                        style: TextStyle(color: Colors.brown, fontSize: 16)),

                                  ],
                                ),
                              ),
                            );
                          })),
                  SizedBox(height: 20),
                  MaterialButton(
                    onPressed: () {
                      submitData();
                    },
                    color: Colors.brown,
                    elevation: 0,
                    child: Text(
                      'Place Quote',
                      style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    height: 50,
                    minWidth: screenWidth - 150,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45)),
                  ),
                ])),

         // ],
       // ),
      //),
    );
  }

  submitData() async{
    print("XXXXXXXXXXXX");
    print(model);
    try {
      String json = await _toJson();
      String bodyValue  = await NetworkUtil.callPostService(json,Constant.BASE_URL.toString()+'LiveToLive/',Constant.headers);
      if(bodyValue.contains('errorResponse')){

      }else{
        Navigator.pushReplacementNamed(context, '/home');
      }
      print(bodyValue);
    } catch(_){}

  }

  Future<String> _toJson() async{

    List send = List();
    for(int i=0;i<_items.length;i++){
      _items[i].isActive = true;
      _items[i].inQueue = 'Admin';
      _items[i].isActive = true;
      _items[i].mobileNo = '9987272169';
      print(model);
      var mapData =  _items[i].toJson();
      send.add(mapData);
    }

    String json = Constant.JSON.encode(send);
    return json;

  }
}
