
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LoginReq{

   String email;
   String password;

   LoginReq({this.email,this.password});

   factory LoginReq.fromJson(Map<String,dynamic> parsedJson){
     return LoginReq(
         email:parsedJson['email'],
         password: parsedJson['password']
     );
   }

   Map<String,dynamic> toJson() {
     // final Map<String, dynamic> data =  Map<String, dynamic>();
     return {
       'email': this.email,
       'password': this.password
     };
   }

}