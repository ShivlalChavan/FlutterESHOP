import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/screens/addbookimage.dart';
import 'package:flutterstationaryshop/screens/addnewbook.dart';
import 'package:flutterstationaryshop/screens/demo.dart';
import 'package:flutterstationaryshop/screens/login.dart';
import 'package:flutterstationaryshop/widget/booklist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterstationaryshop/screens/demogrid.dart';
import 'package:flutterstationaryshop/screens/dashboard.dart';



enum AuthStatus {
  NOT_DETERMINED,
 NOT_LOGGED_IN,
 LOGGED_IN
}


class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String userId="";
  String loginEmail="";

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String user = null , email=null;
     setState(() {
      user = (pref.getString('isLogin')?? null);
      email = (pref.getString('userEmail')?? null);

       if(user!=null && email!=null){
         userId= user;
         loginEmail= email;
         authStatus = user == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
       }
      authStatus = user == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;

     });
  }

  Widget buildingScreen(){
   return Scaffold(
     body: Container(
       alignment: Alignment.center,
       child: CircularProgressIndicator(),
     ),
   );
  }



  @override
  Widget build(BuildContext context) {
    switch(authStatus){

      case AuthStatus.NOT_DETERMINED:
       return buildingScreen();
       break;

      case AuthStatus.NOT_LOGGED_IN:
        return  Dashboard();
        break;

      case AuthStatus.LOGGED_IN:
        return DashboardScreen();
        break;
    }
  }


}
