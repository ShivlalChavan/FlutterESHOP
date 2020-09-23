import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/constant/constants.dart';

class SettingTile extends StatelessWidget {

  String settingName;
  Function onPressed;
  Icon icon;

  SettingTile({this.settingName,this.onPressed,this.icon});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color:Colors.grey,
              blurRadius: 6.0,
              offset: Offset(0.0,8.0)
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListTile(
              title: Text(
                settingName,
                style: kbookTitle,
              ),
              trailing: Container(
                child: IconButton(
                  icon: icon,
                  onPressed: onPressed,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


