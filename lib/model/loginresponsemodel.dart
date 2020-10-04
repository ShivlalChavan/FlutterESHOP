
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserBase{

  String status;
  String token;
  UserLogin data;


  UserBase({this.status,this.token,this.data,});

  factory UserBase.fromJson(Map<String,dynamic> parsedJson){
    return UserBase(
        status: parsedJson['status'],
        token: parsedJson['token'],
        data: UserLogin.fromJson(parsedJson['data']['user'])

    );
  }

  Map<String,dynamic> toJson() {
    // final Map<String, dynamic> data =  Map<String, dynamic>();
    return {
      'status':this.status,
      'token': this.token,
      'data': this.data
    };
  }
}


@JsonSerializable()
class UserData{

  UserLogin user;

  UserData({this.user});

  factory UserData.fromJson(Map<String,dynamic> parsedJson){
    return UserData(
      user: UserLogin.fromJson(parsedJson['user']),
    );
  }

  Map<String,dynamic> toJson() {
    // final Map<String, dynamic> data =  Map<String, dynamic>();
    return {
      'user':this.user
    };
  }
}


@JsonSerializable()
class UserLogin{

  String role;
  String id;
  String name;
  String email;
  int mobile;
  int v;

  UserLogin({this.role,this.id,this.email,this.name,this.mobile,this.v});

  factory UserLogin.fromJson(Map<String,dynamic> parsedJson){
    return UserLogin(
         role: parsedJson['role'],
         id: parsedJson['_id'],
         name: parsedJson['name'],
         email:parsedJson['email'],
         mobile: parsedJson['mobile'],
         v: parsedJson['__v'],

    );
  }

  Map<String,dynamic> toJson() {
    // final Map<String, dynamic> data =  Map<String, dynamic>();
    return {
      '_id':this.id,
      'email': this.email,
      'name': this.name,
       'mobile':this.mobile,
      'role':this.role
    };
  }
}