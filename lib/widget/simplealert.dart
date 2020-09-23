import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AlertDailogg extends StatelessWidget {

  String title;
  String msg;
  String subMsg;
  Function onPressed;
  
  AlertDailogg({this.title,this.msg,this.subMsg,this.onPressed});

  @override
  Widget build(BuildContext context) {
     showDialog(
      context:context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(
            title
          ),
          content: Text(
            msg
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "OK"
              ),
              onPressed: onPressed,
            )
          ],
        );
      },
    );
  }





}


