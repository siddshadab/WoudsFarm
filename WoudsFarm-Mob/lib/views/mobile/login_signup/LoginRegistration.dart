import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wouds_farm/widgets/TextInputDecoration.dart';


class LoginRegistration extends StatefulWidget {
  const LoginRegistration({Key? key}) : super(key: key);

  @override
  _LoginRegistration createState() => _LoginRegistration();
}

class _LoginRegistration extends State<LoginRegistration> {
  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    String fname = '';
    String lname = '';
    String email = '';
    String mobileno = '';
    String groupcd = '';
    String password = '';
    String tempPassword = '';

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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'First Name'),
                        inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                        validator: (val) => val!.isEmpty ? 'First Name is required' : null,
                        onSaved: (val) => fname = val as String,
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Last Name'),
                        inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                        validator: (val) => val!.isEmpty ? 'Last Name is required' : null,
                        onSaved: (val) => lname = val as String,
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Email'),
                        inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                        validator: (val) => val!.isEmpty ? 'Email is required' : null,
                        onSaved: (val) => email = val as String,
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Password'),
                        inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                        validator: (val) => val!.isEmpty ? 'Password is required' : null,
                        onSaved: (val) => password = val as String,
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Match Password'),
                        inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                        validator: (val) => val!.isEmpty ? 'Match Pasword is required' : val !=tempPassword?"Passwords Are not matching":null,
                        onSaved: (val) => tempPassword = val as String,
                      ),
                      SizedBox(height: 20.0),
                      DropdownButton(
                        dropdownColor: Colors.white,
                        hint: Text('Customer Type ',
                            style: TextStyle(color: Colors.black)),
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
                              groupcd = val.toString();
                            },
                          );
                        },
                      ),
                      Row(
                        children: [],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.brown),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Navigator.pushReplacementNamed(context, '/businessRegistration');
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
}


