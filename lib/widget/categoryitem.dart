import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {

  Color cColor;
  String categoryName;
  Function onPress;


  CategoryItem({this.cColor,this.categoryName,this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Card(
        shadowColor: Colors.white30,
        elevation: 20.0,
        color: cColor,
       child: Container(
         height: 96.0,
         width: 96.0,
         padding: EdgeInsets.all(10.0),
         child: GridTile(
             child: FlatButton(
               child: Container(

               ),
               onPressed: onPress,
             ),
             footer: Text(
               categoryName,
               textAlign: TextAlign.right,
               style: TextStyle(
                 color: Colors.black,
                 fontSize: 18,
                 fontWeight: FontWeight.bold
               ),
             ),
         ),
       ),
      ),
    );
  }
}
