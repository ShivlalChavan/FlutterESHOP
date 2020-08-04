import 'package:flutter/material.dart';
import  'package:flutterstationaryshop/constant/constants.dart';

class TextInputField extends StatelessWidget {

  String label;
  Function onChanged;
  TextInputType type;
  int maxLines;
  Function validator;



  TextInputField({this.label,this.onChanged,this.type,this.maxLines,this.validator});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
     maxLines: maxLines,
     onChanged: onChanged,
     style: TextStyle(
      color: Colors.black
     ),
     decoration: kTypeInputTextDecoration.copyWith(
       hintText: label
     ),
     validator:validator ,
    );
  }
}
