import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterstationaryshop/constant/constants.dart';
import 'package:flutterstationaryshop/model/paymentMethod.dart';

class CheckBoxTile extends StatefulWidget {

   String title;
   Icon icon;
   Function onChanged;
   bool isChecked = false;
   PaymentMethod paymentData;



  CheckBoxTile({this.title,this.icon,this.onChanged,this.isChecked});

  @override
  _CheckBoxTileState createState() => _CheckBoxTileState();

}

class _CheckBoxTileState extends State<CheckBoxTile> {


  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(widget.title,style: kbookTitle,),
      value:widget.paymentData.type,
      onChanged: widget.onChanged,
      secondary: widget.icon,
      groupValue: widget.paymentData.type,
      activeColor: Colors.deepOrange,


    );
  }
}
