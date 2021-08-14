import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wouds_farm/models/UserModel.dart';
import 'package:wouds_farm/shared/Constant.dart';
import 'package:wouds_farm/shared/NetworkUtil.dart';
import 'package:wouds_farm/widgets/TextInputDecoration.dart';

class LoginRegistration extends StatefulWidget {
  const LoginRegistration({Key key}) : super(key: key);

  @override
  _LoginRegistration createState() => _LoginRegistration();
}

class _LoginRegistration extends State<LoginRegistration> {
  final _formKey = GlobalKey<FormState>();
  UserModel model = UserModel();
  String tempPassword;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 237, 232),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(right: 80.0, top: 50),
              child: Text(
                "Provide Login Details",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Enter First Name',
                              labelText: 'First Name'),
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(30)
                          ],
                          validator: (val) =>
                              val.isEmpty ? 'First Name is required' : null,
                          onSaved: (val) {
                            model.fname = val;
                          },
                          onChanged: (val) {
                            _formKey.currentState.save();
                          }),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Enter Last Name',
                            labelText: 'Last Name'),
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(30)
                        ],
                        validator: (val) =>
                            val.isEmpty ? 'Last Name is required' : null,
                        onSaved: (val) async {
                          model.lname = val;
                        },
                        onChanged: (val) {
                          _formKey.currentState.save();
                        },
                        strutStyle: StrutStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          height: 1.7,
                          leading: 1.7,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Enter Email', labelText: 'Email'),
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(30)
                          ],
                          validator: Constant.validateEmail,
                          onSaved: (val) {
                            model.email = val;
                          },
                          onChanged: (val) {
                            _formKey.currentState.save();
                          }),
                      SizedBox(height: 20.0),
                      TextFormField(
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Enter Password',
                              labelText: 'Password'),
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(30)
                          ],
                          validator: (val) =>
                              val.isEmpty ? 'Password is required' : null,
                          onSaved: (val) {
                            model.password = val;
                          },
                          onChanged: (val) {
                            _formKey.currentState.save();
                          }),
                      SizedBox(height: 20.0),
                      TextFormField(
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Enter Match Password',
                              labelText: 'Match Password'),
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(30)
                          ],
                          validator: (val) {
                            print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
                            print(model);
                            print(model.toString());
                            print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXENDS");
                            if (val.isEmpty) {
                              return 'Match Pasword is required';
                            } else if (val != model.password) {
                              return 'Passwords Are not matching';
                            }
                            return null;
                          },
                          onSaved: (val) {
                            tempPassword = val;
                          },
                          onChanged: (val) {
                            _formKey.currentState.save();
                          }),
                      SizedBox(height: 20.0),
                      DropdownButtonFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Type Of Customer',
                            labelText: 'Customer Type'),
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        iconSize: 30.0,
                        style: TextStyle(color: Colors.blue),
                        items: [
                          'Farmer',
                          'Trader',
                          'Restaurant ',
                          'Retailer',
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
                          setState(
                            () {
                              model.groupcd = val.toString();
                            },
                          );
                        },
                      ),
                      Row(
                        children: [],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.brown),
                        onPressed: () async {
                          print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
                          print(model);
                          print(model.toString());
                          print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXENDS");

                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            await submitData();
                          }
                        },
                        child: Text("Proceed"),
                      )
                    ],
                  ),
                )),
          ]),
        ));
  }

  submitData() async {
    print("XXXXXXXXXXXX");
    print(model);
    try {
      String json = await _toJson();
      String bodyValue = await NetworkUtil.callPostService(
          json, Constant.BASE_URL.toString() + 'signup/', Constant.headers);
      if (bodyValue.contains('errorResponse')) {
      } else {
        //Navigator.pushReplacementNamed(context, '/businessRegistration');
        Navigator.pushReplacementNamed(context, '/login');
      }
      print(bodyValue);
    } catch (_) {}
  }

  Future<String> _toJson() async {
    var mapData = model.toJson();
    String json = Constant.JSON.encode(mapData);
    return json;
  }
}
