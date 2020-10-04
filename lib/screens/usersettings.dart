import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/constant/constants.dart';
import 'package:flutterstationaryshop/localization/language.dart';
import 'package:flutterstationaryshop/localization/language_constant.dart';
import 'package:flutterstationaryshop/screens/login.dart';
import 'package:flutterstationaryshop/screens/myordersscreen.dart';
import 'package:flutterstationaryshop/widget/settingtile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';


class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text(
            'Settings',
            style: kScreenTitle
        ),
        actions: <Widget>[
         /* Padding(
            padding: EdgeInsets.all(8.0),
            child: DropdownButton<Language>(
              underline: SizedBox(),
              icon: Icon(
                Icons.language,
                color: Colors.white,
              ),
              onChanged: (Language languae){
                _changedLanguage(languae);
              },
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                      (e) => DropdownMenuItem<Language>(
                    value: e,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          e.flag,
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(e.name)
                      ],
                    ),
                  )).toList(),
            ),
          )*/
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: ListTile(
                  title: Text(
                    'Language',
                    style: kbookTitle,
                  ),
                  trailing: DropdownButton<Language>(
                    dropdownColor: Colors.white,
                    underline: SizedBox(),
                    icon: Icon(
                      Icons.language,
                      color: Colors.redAccent,
                    ),
                    onChanged: (Language languae){
                      _changedLanguage(languae);
                    },
                    items: Language.languageList()
                        .map<DropdownMenuItem<Language>>(
                            (e) => DropdownMenuItem<Language>(
                          value: e,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                e.flag,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,

                                ),


                              ),
                              Text(e.name,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black
                                ),)
                            ],
                          ),
                        )).toList(),
                  ),
            ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.0),
              child: Divider(
                color: Colors.black45,
                height: 1,
                thickness: 0.5,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: ListTile(
                title: Text(
                  'Orders',
                  style: kbookTitle,
                ),
                trailing: Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.redAccent,
                    ),
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return MyOrders();
                          }));
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.0),
              child: Divider(
                color: Colors.black45,
                height: 1,
                thickness: 0.5,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: ListTile(
                title: Text(
                  'Logout',
                  style: kbookTitle,
                ),
                trailing: Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.power_settings_new,
                      color: Colors.redAccent,
                    ),
                    onPressed: (){
                       _logoutUser();
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _changedLanguage(Language languae) async{
    Locale _locale = await setLocale(languae.langaugeCode);
    App.setLocale(context, _locale);
  }

  void _logoutUser() async {

    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString('authToken', null);
    pref.setString('isLogin', null);
    pref.setString('userEmail', null);
    pref.setString('userData', null);

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
      return LoginScreen();
    }),(Route<dynamic> route) => false);

  }
}
