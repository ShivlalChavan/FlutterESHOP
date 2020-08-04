import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




const kTypeInputDecoration = InputDecoration(
   hintText:'Enter your value',
   hintStyle: TextStyle(
    color:Colors.grey,
   ),
  contentPadding:
   EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
   border: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(20.0)),
   ),
   enabledBorder: OutlineInputBorder(
     borderSide:BorderSide(color: Colors.lightBlueAccent , width:1.0),
     borderRadius:BorderRadius.all(Radius.circular(28.0))
   ),
  focusedBorder: OutlineInputBorder(
    borderSide:BorderSide(color: Colors.lightBlueAccent,width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(28.0))
  )
);

const kTypeInputTextDecoration = InputDecoration(
    hintText:'Enter your value',
    hintStyle: TextStyle(
      color:Colors.grey,
    ),
    contentPadding:
    EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    enabledBorder: OutlineInputBorder(
        borderSide:BorderSide(color: Colors.black54 , width:1.0),
        borderRadius:BorderRadius.all(Radius.circular(10.0))
    ),
    focusedBorder: OutlineInputBorder(
        borderSide:BorderSide(color: Colors.black54,width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(10.0))
    )
);



const kbookTitle = TextStyle(
  color: Colors.black,
  fontSize: 16.0,
  fontWeight: FontWeight.w400,
  fontFamily: 'Montserrat'
);

const kScreenTitle = TextStyle(
    color: Colors.white,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    fontFamily: 'Montserrat'
);

const kErrorTitle = TextStyle(
    color: Colors.redAccent,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    fontFamily: 'Montserrat'
);

const kbookDes = TextStyle(
  color: Colors.black54,
  fontSize: 14.0,
  fontFamily: 'Montserrat'
);

const kbookSub = TextStyle(
    color: Colors.black54,
    fontSize: 12.0,
    fontFamily: 'Montserrat'
);

const kSearchTextFieldInputDec = InputDecoration(
    filled: true,
    fillColor:Colors.white,
    hintText: 'Seach book',
     hintStyle: TextStyle(
      color: Colors.black54
     ),
     border: OutlineInputBorder(
       borderSide:BorderSide.none
     )
);
