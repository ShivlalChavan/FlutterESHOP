import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/localization/language.dart';
import 'package:flutterstationaryshop/localization/language_constant.dart';

import '../main.dart';


class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          Padding(
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
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[

          ],
        ),
      ),

    );
  }

  void _changedLanguage(Language languae) async{
    Locale _locale = await setLocale(languae.langaugeCode);
    App.setLocale(context, _locale);
  }
}
