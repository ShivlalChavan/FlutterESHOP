import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/components/rounded_button.dart';
import 'package:flutterstationaryshop/constant/constants.dart';
import 'package:flutterstationaryshop/model/loginrequestmodel.dart';
import 'package:flutterstationaryshop/model/loginresponsemodel.dart';
import 'package:flutterstationaryshop/screens/dashboard.dart';
import 'package:flutterstationaryshop/screens/registerscreen.dart';
import 'package:flutterstationaryshop/services/stationaryapi.dart';
import 'package:flutterstationaryshop/widget/textinput.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool showSpinner = false;
  String email,password;
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    if(showSpinner){
      return showCircularProgress();
    }
    else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: Form(
                key: _formKey,
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
                      TextInputField(
                        label: 'Enter your email',
                        type: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        validator: (String email) {
                          return !email.isEmpty
                              ? null
                              : 'Please enter email address';
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextInputField(
                        label: 'Enter your password',
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (String password) {
                          return !password.isEmpty
                              ? null
                              : 'Please enter password';
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RoundedButton(
                        color: Colors.lightBlueAccent,
                        title: 'Login',
                        onPressed: () {
                          print('clicked login');
                          _userLogin();
                        },
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 1.0),
                        child: FlatButton(
                          color: Colors.white,
                          onPressed: navigateToRegister,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(0.0),
                          child: Container(
                            child: Text(
                              "Don't have Account? Register",
                              style: kScreenTitle.copyWith(
                                  color: Colors.blueGrey),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }


  Widget showCircularProgress(){
    if(showSpinner){
      return Container(
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
          ],
        ),
      );
    }
    return Container(
      width: 0.0,
      height: 0.0,
    );
  }


  void _userLogin() async{
    if(_formKey.currentState.validate()){

      setState(() {
        showSpinner = true;
      });

      Stationary stationary = Stationary();

      LoginReq requestPojo = LoginReq(email: email , password: password);

      UserBase responsePojo = await stationary.userLogin(requestPojo);

      if(responsePojo!=null) {

        String token = responsePojo.token;
        UserLogin userData = responsePojo.data;

        if(token.isNotEmpty){

          SharedPreferences pref = await SharedPreferences.getInstance();

          pref.setString('authToken', token);
          pref.setString('isLogin', 'login');
          pref.setString('userEmail', userData.email);

          if(userData!=null){
            String uerData = jsonEncode(userData);
            pref.setString('userData', uerData);
          }

          setState(() {
            showSpinner = false;
          });

          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
            return Dashboard();
          }),(Route<dynamic> route) => false);


        }

      }

    }
  }



  void navigateToRegister() {
    Navigator.push(context,MaterialPageRoute(builder: (context){
      return RegisterScreen();
    }));
  }
}
