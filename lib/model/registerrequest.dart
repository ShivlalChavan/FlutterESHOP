
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class RegisterRequest{

  String name;
  String email;
  String photo;
  int mobile;
  String role;
  String password;
  String confirmPassword;

  RegisterRequest({this.name,this.photo,this.mobile,this.role,this.confirmPassword,this.email,this.password});

  factory RegisterRequest.fromJson(Map<String,dynamic> parsedJson){
    return RegisterRequest(
        name:parsedJson['name'],
        email:parsedJson['email'],
        photo:parsedJson['photo'],
        mobile:parsedJson['mobile'],
        role:parsedJson['role'],
        password:parsedJson['password'],
        confirmPassword: parsedJson['confirmPassword']
    );
  }

  Map<String,dynamic> toJson() {
    // final Map<String, dynamic> data =  Map<String, dynamic>();
    return {
      'name':this.name,
      'email': this.email,
      'photo':this.photo,
      'mobile':this.mobile,
      'role':this.role,
      'password': this.password,
      'confirmPassword':this.confirmPassword
    };
  }

}