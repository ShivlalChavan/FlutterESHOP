import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/components/rounded_button.dart';
import 'package:flutterstationaryshop/constant/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool showSpinner = false;
  String email,password;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
         padding: EdgeInsets.symmetric(horizontal: 24.0),
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
           Hero(
             tag: 'logo',
            child: Container(
              height: 200.0,
              child: Image.asset('images/logo.png'),
            ),
           ),
           SizedBox(
            height: 48.0,
           ),
           TextField(
             keyboardType: TextInputType.emailAddress,
             textAlign: TextAlign.center,
             onChanged: (value){
               email = value;
             },
             style: TextStyle(
              color: Colors.black,
             ),
             decoration: kTypeInputDecoration.copyWith(
               hintText: 'Enter your email.',
             ),
           ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
            obscureText: true,
            textAlign: TextAlign.center,
            onChanged: (value){
             password = value;
            },
             style: TextStyle(
               color: Colors.black,
             ),
             decoration: kTypeInputDecoration.copyWith(
               hintText: 'Enter your password',
             ),
            ),
            SizedBox(
              height: 20.0,
            ),
            RoundedButton(
              color: Colors.lightBlueAccent,
              title: 'Login',
              onPressed: (){
                print('clicked login');
              },
            )
           ],
         ),
        ),
      ),
    );
  }
}
