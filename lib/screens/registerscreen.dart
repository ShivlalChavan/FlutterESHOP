import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/components/rounded_button.dart';
import 'package:flutterstationaryshop/constant/constants.dart';
import 'package:flutterstationaryshop/model/loginresponsemodel.dart';
import 'package:flutterstationaryshop/model/registerrequest.dart';
import 'package:flutterstationaryshop/screens/dashboard.dart';
import 'package:flutterstationaryshop/screens/login.dart';
import 'package:flutterstationaryshop/services/stationaryapi.dart';
import 'package:flutterstationaryshop/widget/dropdown.dart';
import 'package:flutterstationaryshop/widget/stringdropdown.dart';
import 'package:flutterstationaryshop/widget/textinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  String fullName,email,mobile,password,confirmPassword,selectedRole;
  final _formKey = GlobalKey<FormState>();
  bool showSpinner= false;
  List<String> userRole = ['user','admin'];

  @override
  Widget build(BuildContext context) {
    if(showSpinner){
      return showCircularProgress();
    }
    else {
      return Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery
                          .of(context)
                          .viewInsets
                          .bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: bookInputForm(),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          RoundedButton(
                            color: Colors.lightBlueAccent,
                            title: 'Register',
                            onPressed: () {
                              signUp();
                            },
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 2.0),
                            child: FlatButton(
                              color: Colors.white,
                              onPressed: navigateToLogin,
                              textColor: Colors.white,
                              padding: EdgeInsets.all(0.0),
                              child: Container(
                                child: Text(
                                  "Already a User. login",
                                  style: kScreenTitle.copyWith(
                                      color: Colors.blueGrey),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      );
    }
  }

  Widget bookInputForm() {
    return Column(
      children: <Widget>[
        Hero(
          tag: 'logo',
          child: Container(
            height: 160.0,
            child: Image.asset('images/logo.png'),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        TextInputField(
          type: TextInputType.text,
          maxLines: 1,
          label: 'Enter full name',
          validator: (String bookName ) {
            return !bookName.isEmpty ? null : 'Please enter book name.';
          },
          onChanged: (value){
            fullName = value;
          },
        ),
        SizedBox(
          height: 20.0,
        ),
        TextInputField(
          type: TextInputType.emailAddress,
          maxLines: 1,
          label: 'Enter your email',
          validator: (String bookAuthor){
            return bookAuthor.isEmpty ? 'Please enter book author' : null;
          },
          onChanged: (value){
            email = value;
          },
        ),
        SizedBox(
          height: 20.0,
        ),
        TextInputField(
          type: TextInputType.number,
          maxLines: 1,
          label: 'Enter phone number',
          validator: (String price){
            return price.isEmpty ? 'Please enter price' : null;
          },
          onChanged: (value){
            mobile = value;
          },
        ),
        SizedBox(
          height: 20.0,
        ),
        TextInputField(
          type: TextInputType.visiblePassword,
          maxLines: 1,
          label: 'Password',
          validator: (String description) {
            return description.isEmpty ? 'Please enter description' :  null;
          },
          onChanged: (value){
            password = value;
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        TextInputField(
          type: TextInputType.visiblePassword,
          maxLines: 1,
          label: 'Confirm password',
          validator: (String description) {
            return description.isEmpty ? 'Please enter description' :  null;
          },
          onChanged: (value){
            confirmPassword = value;
          },
        ),
        SizedBox(
          height: 10.0,
        ),
        DropDownRole(
          title: 'User Role: ',
          value: selectedRole,
          hintText: 'Select Role',
          onChanged: (String value){
            setState(() {
              selectedRole = value;
            });
          },
          onSaved: userRole.map((e) => DropdownMenuItem(
            child: Text(
              '${e}',
              style: kbookTitle,
            ),
            value: e,
          )).toList(),
        )
      ],
    );
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


  void signUp()  async{
    if(_formKey.currentState.validate()){

      setState(() {
        showSpinner = true;
      });

      Stationary stationary = Stationary();

      RegisterRequest req= RegisterRequest(name: fullName,email: email,mobile: int.parse(mobile) ,role: selectedRole,
                                           password: password,confirmPassword: confirmPassword,photo: "");

      UserBase responsePojo = await stationary.userRegister(req);

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



  void navigateToLogin() {

    Navigator.push(context,MaterialPageRoute(builder: (context){
      return LoginScreen();
    }));
  }
}
