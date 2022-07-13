import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shop24u/Screens/Home.dart';
import 'package:shop24u/Screens/Signup.dart';
import 'package:shop24u/colors/MyColors.dart';
import 'package:shop24u/model/LoginResponse.dart';
import 'package:shop24u/size/MySize.dart';

import '../api/APIService.dart';


class Login extends StatefulWidget {

  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  SharedPreferences? sharedPreferences;
  bool _passwordVisible = false;

  late bool email_validate, pass_validate;
  late String email_error, pass_error;
  bool rem = false;

  @override
  void initState() {
    email_validate = pass_validate = false;
    email_error = pass_error = "";
    _passwordVisible = false;
    super.initState();
  }

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: MyColors.white,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: MySize.sizeh4(context), horizontal: MySize.size7(context)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Log In",
                      style: TextStyle(fontSize: MySize.font20(context)),
                    ),
                    SizedBox(
                      height: MySize.sizeh3(context),
                    ),
                    Text(
                      "Welcome back! Sign in to your account.",
                      style: TextStyle(fontSize: MySize.font15(context)),
                    ),
                    SizedBox(
                      height: MySize.sizeh6(context),
                    ),
                    TextField(
                      textInputAction: TextInputAction.next,
                      controller: email,
                      decoration: InputDecoration(
                          errorText: email_validate ? email_error : null,
                          label: Text("Email ID"),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                        )
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: MySize.sizeh1(context),
                    ),
                    TextField(textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      controller: password,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        errorText: pass_validate ? pass_error : null,
                        labelText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock_outline,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            // color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: MySize.sizeh2(context)),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {

                          },
                          child: Text(
                            "Lost your Password ?",
                            style: TextStyle(
                              color: MyColors.colorAccent1
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: MySize.sizeh2(context)),
                      child: Row(
                        children: [
                          Checkbox(
                            value: rem,
                            checkColor: MyColors.white,
                            activeColor: MyColors.colorSecondary,
                            onChanged: (bool? value) {
                              rem = value ?? !rem;
                              setState((){

                              });
                            },
                          ),
                          Text(
                            "Remember me",
                          ),
                        ]
                      ),
                    ),
                    Container(
                      height: MySize.sizeh6(context),
                      margin: EdgeInsets.only(top: MySize.sizeh3(context)),
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () {
                            if (validate() == 0) {
                              login();
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(MyColors.colorSecondary),
                          ),
                          child: Text(
                              "LOGIN",
                            style: TextStyle(
                              color: MyColors.white
                            ),
                          )
                      ),
                    ),
                    SizedBox(
                      height: MySize.sizeh4(context),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                              text: TextSpan(
                                  text: 'New to Shop24U? ',
                                  style:
                                      TextStyle(color: MyColors.black, fontSize: MySize.font14(context)),
                                  children: [
                                TextSpan(
                                  text: 'Register',
                                  style: TextStyle(
                                    color: MyColors.colorAccent1, fontSize: MySize.font14(context)
                                  ),
                                  recognizer: TapGestureRecognizer()..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
                                  },
                                ),
                              ])),
                    )
                  ],
                ),
            ),
          ),
        ),
      ),
    );
  }

  //Call login api
  void login() async {
    Map<String, dynamic> data = new Map();
    data['username'] = email.text;
    data['password'] = password.text;
    print("LoginData $data");

    LoginResponse loginResponse = await APIService().login(data);
    // print(loginResponse.message);
    // print(loginResponse.toJson());
    // print(loginResponse.data?.first.accessToken??"");
    if (loginResponse?.status??false) {
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences?.setString("id", (loginResponse.data?.id??"").toString());
      sharedPreferences?.setString("name", loginResponse.data?.data?.displayName??"");
      sharedPreferences?.setString("email", loginResponse.data?.data?.userEmail??"");
      sharedPreferences?.setString("status", "logged in");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please, try again later")));
      // print(loginResponse.message);
    }
  }

  //validation
  int validate() {
    int cnt = 0;
    if (!email.text.isEmpty) {
      email_validate = true;
      email_error = "Enter email";
    } else if (!EmailValidator.validate(email.text)) {
      email_validate = true;
      email_error = "Enter valid email address";
    } else {
      email_validate = false;
      email_error = "";
    }
    if (password.text.isEmpty) {
      setState(() {
        pass_validate = true;
        pass_error = "Enter Password";
      });
      cnt++;
    } else {
      pass_validate = false;
      pass_error = "";
    }
    return cnt;
  }
}
