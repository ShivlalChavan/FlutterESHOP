import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterstationaryshop/constant/constants.dart';

class CheckBoxTile extends StatefulWidget {

   String title;
   Icon icon;
   Function onChanged;
   bool isChecked = false;



  CheckBoxTile({this.title,this.icon,this.onChanged,this.isChecked});

  @override
  _CheckBoxTileState createState() => _CheckBoxTileState();

}

class _CheckBoxTileState extends State<CheckBoxTile> {


  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.title,style: kbookTitle,),
      value:widget.isChecked,
      onChanged: widget.onChanged,
      secondary: widget.icon,
      checkColor: Colors.white,
      activeColor: Colors.deepOrange,


    );
  }
}