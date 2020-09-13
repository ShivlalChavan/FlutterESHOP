import 'package:flutter/cupertino.dart';

class PaymentMethod {

   String type;
   Icon icon;
   bool isDone = false;

   PaymentMethod({this.type,this.icon});

   void toggleDone(){
      isDone = !isDone;
   }
}