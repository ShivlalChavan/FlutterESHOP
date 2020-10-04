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
   String value;
   String groupValue;
   bool selectedValue;



  CheckBoxTile({this.title,this.icon,this.onChanged,this.isChecked,this.value,this.groupValue});

  @override
  _CheckBoxTileState createState() => _CheckBoxTileState();

}

class _CheckBoxTileState extends State<CheckBoxTile> {


  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(widget.title,style: kbookTitle,),
      value:widget.value,
      onChanged: widget.onChanged,
      secondary: widget.icon,
      groupValue: widget.groupValue,
      activeColor: Colors.deepOrange,
    );
  }
}
