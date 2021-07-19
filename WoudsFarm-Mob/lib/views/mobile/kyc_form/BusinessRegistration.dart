import 'package:flutter/material.dart';
import 'package:wouds_farm/widgets/TextInputDecoration.dart';

class BusinessRegistration extends StatefulWidget {
  const BusinessRegistration({Key? key}) : super(key: key);

  @override
  _BusinessRegistration createState() => _BusinessRegistration();
}

class _BusinessRegistration extends State<BusinessRegistration> {
  @override
  Widget build(BuildContext context) {
    String _dropDownValue = "";
    String _dropDownValue2 = "";

    final _formKey = GlobalKey<FormState>();
    String name = '';
    String email = '';
    String password = '';
    String error = '';
    String wallet = '0';
    String phone = '';
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 237, 232),

        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(right: 80.0, top: 50),
              child: Text(
                "Provide Activation Details",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Buisness Name'),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Gst Number'),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Buisness Address '),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Pincode'),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'City'),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'State'),
                      ),
                      Row(
                        children: [],
                      )
                    ],
                  ),
                )),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 150.0,
                  ),
                  child: Text(
                    "Verify your Details",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    dropdownColor: Colors.white,
                    hint: Text('Buisness Type ',
                        style: TextStyle(color: Colors.black)),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.blue),
                    items: [
                      'Proprietorship',
                      '2ndtype',
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
                          _dropDownValue = val.toString();
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    dropdownColor: Colors.white,
                    hint: Text('Pan ', style: TextStyle(color: Colors.black)),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.blue),
                    items: [
                      'Pan',
                      'Adhar',
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
                          _dropDownValue2 = val.toString();
                        },
                      );
                    },
                  ),
                ),
                TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Name As Per PAN '),
                    validator: (val) => val!.isEmpty ? 'Enter an Name ' : null,
                    onChanged: (val) {
                      setState(() => phone = val);
                    }),
                Padding(
                  padding: const EdgeInsets.only(left: 80, top: 20),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.brown),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');

                        },
                        child: Text("Skip"),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.brown),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        child: Text("Proceed"),
                      )
                    ],
                  ),
                )
              ]),
            )
          ]),
        ));
  }
}
