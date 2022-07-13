import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop24u/LoginPopUp.dart';
import 'package:shop24u/Screens/HomeScreen.dart';
import 'package:shop24u/Screens/Login.dart';
import 'package:shop24u/Screens/MyCart.dart';
import 'package:shop24u/size/MySize.dart';
import '../colors/MyColors.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _State();
}

class _State extends State<Home> {
  bool? load;
  int _currentIndex = 0;
  PageController? _pageController;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences? sharedPreferences;

  @override
  void initState()
  {
    start();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: MyColors.colorPrimary,
        title: Padding(
          padding:  EdgeInsets.only(top: 25.0),
          child: Image.asset("assets/appbar.png"),
        ),
        iconTheme:IconThemeData(color: MyColors.black),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: MySize.size3(context)),
            child: GestureDetector(
              onTap: () {

              },
              child: Icon(
                Icons.search,
                color: Colors.black,
                size: MySize.sizeh4(context),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: MySize.size2(context)),
            child: GestureDetector(
              onTap: () {
                if(sharedPreferences?.getString("status") == "logged in") {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) =>
                      MyCart())
                  );
                }
                else {
                  loginPopUp();
                }
              },
              child: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.black,
                size: MySize.sizeh4(context),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: MyColors.colorTertiary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 20, bottom: 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: MyColors.white
                    ),
                    child: Text(
                      (sharedPreferences?.getString("name")??" ").substring(0,1).toUpperCase(),
                      style: TextStyle(
                          color: MyColors.black,
                          fontSize: 18
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(sharedPreferences?.getString("name")??"",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(sharedPreferences?.getString("email")??"",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // SizedBox(
            //   height: 10,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       _currentIndex = 0;
            //     });
            //     closeDrawer();
            //   },
            //   child: ListTile(
            //     textColor: MyColors.black,
            //     iconColor: MyColors.black,
            //     title: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Image.asset(
            //           "assets/drawer/menu.png",
            //           height: MySize.size18(context),
            //           width: MySize.size18(context),
            //         ),
            //         SizedBox(
            //           width: MySize.size14(context),
            //         ),
            //         Text(
            //           "Menu",
            //           style: TextStyle(
            //             fontSize: MySize.font13(context),
            //             fontWeight: FontWeight.w400
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Divider(
            //   thickness: 1,
            //   color: Colors.grey,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       _currentIndex = 1;
            //     });
            //     closeDrawer();
            //
            //     // Navigator.push(
            //     //   context, MaterialPageRoute(builder: (context) => MyProfile()
            //     //   )
            //     // ).then((value) => {
            //     //   _currentIndex = 0,
            //     //   setState((){
            //     //
            //     //   })
            //     // });
            //   },
            //   child: ListTile(
            //     textColor: MyColors.black,
            //     iconColor: MyColors.black,
            //     title: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Image.asset(
            //           "assets/drawer/myprofile.png",
            //           height: MySize.size18(context),
            //           width: MySize.size18(context),
            //         ),
            //         SizedBox(
            //           width: MySize.size14(context),
            //         ),
            //         Text(
            //           "My Profile",
            //           style: TextStyle(
            //               fontSize: MySize.font13(context),
            //               fontWeight: FontWeight.w400
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Divider(
            //   thickness: 1,
            //   color: Colors.grey,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       _currentIndex = 2;
            //     });
            //     closeDrawer();
            //
            //     // Navigator.push(
            //     //     context, MaterialPageRoute(builder: (context) => MyOrders()
            //     // )
            //     // ).then((value) => {
            //     //   _currentIndex = 0,
            //     //   setState((){
            //     //
            //     //   })
            //     // });
            //   },
            //   child: ListTile(
            //     textColor: MyColors.black,
            //     iconColor: MyColors.black,
            //     title: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Image.asset(
            //           "assets/drawer/myorder.png",
            //           height: MySize.size18(context),
            //           width: MySize.size18(context),
            //         ),
            //         SizedBox(
            //           width: MySize.size14(context),
            //         ),
            //         Text(
            //           "My Order",
            //           style: TextStyle(
            //               fontSize: MySize.font13(context),
            //               fontWeight: FontWeight.w400
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Divider(
            //   thickness: 1,
            //   color: Colors.grey,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       _currentIndex = 3;
            //     });
            //     closeDrawer();
            //
            //     // Navigator.push(
            //     //     context, MaterialPageRoute(builder: (context) => StoreLocation()
            //     // )
            //     // ).then((value) => {
            //     //   _currentIndex = 0,
            //     //   setState((){
            //     //
            //     //   })
            //     // });
            //   },
            //   child: ListTile(
            //     textColor: MyColors.black,
            //     iconColor: MyColors.black,
            //     title: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Image.asset(
            //           "assets/drawer/tandc.png",
            //           height: MySize.size18(context),
            //           width: MySize.size18(context),
            //         ),
            //         SizedBox(
            //           width: MySize.size14(context),
            //         ),
            //         Text(
            //           "Terms & Conditions",
            //           style: TextStyle(
            //               fontSize: MySize.font13(context),
            //               fontWeight: FontWeight.w400
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Divider(
            //   thickness: 1,
            //   color: Colors.grey,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       _currentIndex = 4;
            //     });
            //     closeDrawer();
            //
            //     // Navigator.push(
            //     //     context, MaterialPageRoute(builder: (context) => HelpSupport()
            //     // )
            //     // ).then((value) => {
            //     //   _currentIndex = 0,
            //     //   setState((){
            //     //
            //     //   })
            //     // });
            //   },
            //   child: ListTile(
            //     textColor: MyColors.black,
            //     iconColor: MyColors.black,
            //     title: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Image.asset(
            //           "assets/drawer/contactus.png",
            //           height: MySize.size18(context),
            //           width: MySize.size18(context),
            //         ),
            //         SizedBox(
            //           width: MySize.size14(context),
            //         ),
            //         Text(
            //           "Contact Us",
            //           style: TextStyle(
            //               fontSize: MySize.font13(context),
            //               fontWeight: FontWeight.w400
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      body: HomeScreen(),
    );
  }

  void closeDrawer() {
    if (_scaffoldKey?.currentState?.isDrawerOpen??true) Navigator.of(context).pop();
  }

  loginPopUp() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return LoginPopUp();
      },
    ).then((value) {
      if(value=="login")
        logout();
    });
  }

  Future<void> logout() async {
    sharedPreferences?.setString("status", "logged out");
    sharedPreferences?.setString("id", "");
    sharedPreferences?.setString("name", "");
    sharedPreferences?.setString("email", "");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => Login()),
            (Route<dynamic> route) => false
    );
  }


}
