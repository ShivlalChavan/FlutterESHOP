import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/localization/demo_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';


const  String LANGUAGE_CODE = 'languageCode';

const String ENGLISH = 'en';
const String HINDI = 'hi';
const String MARATHI = 'mr';

Future<Locale> setLocale(String langaugecode) async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LANGUAGE_CODE, langaugecode);
  return _locale(langaugecode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LANGUAGE_CODE) ?? "en";
  return _locale(languageCode);
}

 Locale _locale(String langaugecode) {
  switch(langaugecode){
    case ENGLISH:
      return Locale(ENGLISH,'US');
    case HINDI:
      return Locale(HINDI,"IN");
    case MARATHI:
      return Locale(MARATHI,"IN");
    default :
      return Locale(ENGLISH,'US');
  }
}

String getTranslated(BuildContext context,String key){
return DemoLocalization.of(context).translate(key);
}