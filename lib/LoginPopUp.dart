import 'package:flutter/material.dart';

import 'colors/MyColors.dart';

class LoginPopUp extends StatelessWidget {
  const LoginPopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 10, top: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            new Text("For accessing this feature you need to login.",
              style: TextStyle(
                  fontSize: 16
              ),
            ),
            new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                new TextButton(
                    onPressed: () {
                      Navigator.pop(context, "cancel");
                    },
                    child: Text("Cancel",
                      style: TextStyle(
                          color: MyColors.colorPrimary
                      ),
                    )
                ),
                new TextButton(
                    onPressed: () {
                      Navigator.pop(context, "login");
                    },
                    child: Text("Login",
                      style: TextStyle(
                          color: MyColors.colorPrimary
                      ),
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
