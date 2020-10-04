import 'package:flutter/cupertino.dart';

class PaymentMethod {

   String type;
   Icon icon;
   bool isDone ;

   PaymentMethod({this.type,this.icon,this.isDone});

   void toggleDone(){
      isDone = !isDone;
   }
}