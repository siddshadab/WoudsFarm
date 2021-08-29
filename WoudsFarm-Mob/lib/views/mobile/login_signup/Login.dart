import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wouds_farm/models/UserModel.dart';
import 'package:wouds_farm/shared/Constant.dart';
import 'package:wouds_farm/shared/NetworkUtil.dart';
import 'package:wouds_farm/views/mobile/login_signup/LoginBackground.dart';
import 'package:flutter/material.dart';
import 'package:wouds_farm/widgets/mobile/already_have_an_account_acheck.dart';
import 'package:wouds_farm/widgets/mobile/rounded_button.dart';
import 'package:wouds_farm/widgets/mobile/rounded_input_field.dart';
import 'package:wouds_farm/widgets/mobile/rounded_password_field.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  UserModel model = UserModel();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 237, 232),
      body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: LoginBackground(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "LOGIN",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Image.asset(
                    'assets/images/wouds_farm.jpg',
                    height: size.height * 0.3,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                      hintText: "Your Email",
                      onChanged: (val) {
                        model.email = val;
                      }),
                  RoundedPasswordField(
                    onChanged: (val) {
                      model.password = val;
                    },
                  ),
                  RoundedButton(
                    color: Colors.brown,
                    text: "LOGIN",
                    press: () {
                      submitData();
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            //return SignUpScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }

  submitData() async {
    Constant.onLoading(context);
    print("XXXXXXXXXXXX");
    print(model);
    try {
      String json = await _toJson();
      String bodyValue = await NetworkUtil.callPostService(
          json, Constant.BASE_URL.toString() + 'signin/', Constant.headers);

      if (bodyValue.contains('errorResponse')) {
        Navigator.pop(context);
        Constant.showErrorDialog(context, 'Something went wrong');
      } else {
        Map<String, dynamic> json = Constant.JSON.decode(bodyValue);
        UserModel mod =null;
        Navigator.pop(context);
        try {
          mod = UserModel.fromJson(json['userData'][0]);
        }catch(_){}
        if (json != null && json['success'] == true) {
          setDataForSignUpInUsers(mod);

          if (json['isBusinessData'] == true && !(mod.groupcd == 'Admin')) {
            Navigator.pushReplacementNamed(context, '/businessRegistration');
          } else {
            if (mod.groupcd == 'Farmer' || mod.groupcd == 'Admin') {
              Navigator.pushReplacementNamed(context, '/businessHome');
            } else if (mod.groupcd == 'Trader') {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (mod.groupcd == 'Restaurant') {
              Navigator.pushReplacementNamed(context, '/home');
            } else {
              Navigator.pushReplacementNamed(context, '/mobileInputScreen');
            }
          }
        }else{
          print(json);
         // Navigator.pop(context);
          Constant.showErrorDialog(context, json['message']);

        }
        //Navigator.pushReplacementNamed(context, '/businessRegistration');
      }
      print(bodyValue);
    } catch (_) {}
  }

  Future<String> _toJson() async {
    var mapData = model.toJson();
    String json = Constant.JSON.encode(mapData);
    return json;
  }

  void setDataForSignUpInUsers(UserModel item) async {
    print("here");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('fname', item.firstName != null ? item.firstName : '');
    sharedPreferences.setString('lname', item.lastName != null ? item.lastName : '');
    sharedPreferences.setString('email', item.email != null ? item.email : '');
    sharedPreferences.setString(
        'mobileno', item.mobileno != null ? item.mobileno : '');
    sharedPreferences.setString(
        'groupcd', item.groupcd != null ? item.groupcd : '');
  }
}
