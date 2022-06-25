import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop24u/Screens/Login.dart';
import 'package:shop24u/colors/MyColors.dart';
import 'package:shop24u/model/SignUpResponse.dart';
import 'package:shop24u/size/MySize.dart';

import '../api/APIService.dart';

class SignUp extends StatefulWidget {

  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _passwordVisible = false;
  bool _cpasswordVisible = false;


  late bool name_validate,
      email_validate,
      pass_validate;

  late String name_error,
      email_error,
      pass_error;

  @override
  void initState() {
    super.initState();
    name_validate = pass_validate =
        email_validate = false;
    _passwordVisible = false;
    name_error =
        pass_error = email_error = "";
  }

  TextEditingController name = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController email = new TextEditingController();

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
                    "Register",
                    style: TextStyle(fontSize: MySize.font20(context)),
                  ),
                  SizedBox(
                    height: MySize.sizeh3(context),
                  ),
                  Text(
                    "Create new account today to reap the benefits of a personalized shopping experience.",
                    style: TextStyle(fontSize: MySize.font15(context)),
                  ),
                  SizedBox(
                    height: MySize.sizeh6(context),
                  ),
                  TextField(
                    textInputAction: TextInputAction.next,
                    controller: name,
                    decoration: InputDecoration(
                        errorText: name_validate ? name_error : null,
                        label: Text("Username"),
                        prefixIcon: Icon(
                          Icons.person_outline,
                        )
                    ),
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(
                    height: MySize.sizeh1(context),
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
                  Container(
                    height: MySize.sizeh6(context),
                    margin: EdgeInsets.only(top: MySize.sizeh10(context)),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: () {
                          if (validate() == 0) {
                            signUp(context);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(MyColors.colorSecondary),
                        ),
                        child: Text(
                          "REGISTER",
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
                            text: 'Already have an account? ',
                            style:
                            TextStyle(color: MyColors.black, fontSize: MySize.font14(context)),
                            children: [
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                    color: MyColors.colorAccent1, fontSize: MySize.font14(context)
                                ),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
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
  void signUp(BuildContext context) async {
    Map<String, dynamic> data = new Map();
    data['username'] = name.text;
    data['email'] = email.text;
    data['password'] = password.text;
    print("signup $data");

    SignUpResponse response = await APIService().signup(data);

    if (response.status??false) {
      successDialog();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Wrong Data")));
    }
  }

  void successDialog() {
    BuildContext dialogContext;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        dialogContext = context;
        return Dialog(
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 10, top: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new Text(
                  "You have been successfully registered.",
                  style: TextStyle(fontSize: 16),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(color: MyColors.colorSecondary),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int validate() {
    int cnt = 0;

    if (name.text.isEmpty) {
      setState(() {
        name_validate = true;
        name_error = "Enter Name";
      });
      cnt++;
    } else {
      setState(() {
        name_validate = false;
        name_error = "";
      });
    }
    if (email.text.isEmpty) {
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
          pass_error = "Enter password";
        });
        cnt++;
      } else {
        setState(() {
          pass_validate = false;
          pass_error = "";
        });
      }

    return cnt;
  }
}
