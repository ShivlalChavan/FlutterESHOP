import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterstationaryshop/constant/constants.dart';
import 'package:flutterstationaryshop/model/catergory.dart';


class DropDownRole extends StatelessWidget {

  String title;
  String hintText;
  String value;
  List<DropdownMenuItem<String>> onSaved;
  Function onChanged;
  List<String> category;

  DropDownRole({this.title,this.hintText,this.value,this.category,this.onChanged,this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16.0,
                fontFamily: 'Montserrat'
            )
        ),
        SizedBox(
          height: 5.0,
        ),
        Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 8.0,
                    spreadRadius: 0.4,
                    offset: Offset(1.0, 1.0),
                  ),
                ],
              ),
              padding: EdgeInsets.only(left: 30.0),
              child: DropdownButton(
                  dropdownColor: Colors.white,
                  onChanged: onChanged,
                  isExpanded: true,
                  hint: Text(
                      hintText,
                      style: kbookTitle
                  ),
                  items:onSaved,
                  value: value,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black54,
                  )
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 14.0, left: 4.0),
              child: Icon(
                Icons.category,
                color: Colors.redAccent,
                size: 20.0,
              ),
            ),

          ],
        ),
      ],
    );
  }

  /*
  *  Text(
            title,
           textAlign: TextAlign.start,
           style: TextStyle(
             color: Colors.black54,
             fontSize: 16.0,
             fontFamily: 'Montserrat'
           )
        ),
        SizedBox(
          height: 5.0,
        ),
        DropdownButton(
          dropdownColor: Colors.white,
          onChanged: onChanged,
          isExpanded: true,
          hint: Text(
              hintText,
              style: kbookTitle
          ),
          items:onSaved,
          value: value,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black54,
          )
        ),
  * */

}
