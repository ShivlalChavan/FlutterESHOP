import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/model/ordermodel.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class NetworkHelper {

  final String url;
  static  final String  ImageUrl = "http://192.168.15.207:3000/";

  NetworkHelper(this.url);

 Future getData() async{

    http.Response response = await http.get(url);

    if(response.statusCode == 200){

      var data = jsonDecode(response.body);
      var categorydata = data['data']['data'];

     // print('category ${categorydata}');

      List<dynamic> cData = categorydata;

      return cData;
    }
    else {
       print(response.statusCode);
    }

 }

 Future getBookData() async{

   http.Response response = await http.get(url);

   if(response.statusCode ==200){

     var bookData = jsonDecode(response.body);

     var booklist = bookData['data']['data'];

   //  print('list :-  $booklist');

     List<dynamic> body = booklist;

     return body;
   }

 }

 Future<dynamic> addNewBook(Map<String,dynamic> jsonModel) async {

   var bodyData = jsonEncode(jsonModel);
   var value ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVmMTE1NzZkMDg1NzNkNGJkNDQ4MzQ0YSIsImlhdCI6MTU5NTA0NzY3MywiZXhwIjoxNjAyODIzNjczfQ.vDVasu1PRSamVojze3cw1zBQFH39E88AV2ZVBgzZqpc";

   http.Response response = await http.post(
                                      url,body: bodyData,
                                    headers: {
                                      "Content-Type": "application/json",
                                      "Authorization": "Bearer $value"
                                    });

   if(response.statusCode == 201){

     var resposedata = jsonDecode(response.body);

     print('add book- $resposedata');

     var bookdata = resposedata['data']['data'];

     dynamic  data = bookdata;

     return data;


   }else if(response.statusCode == 500){
     print('$response');
   }


 }

 Future<dynamic> addBookImage(File filePath,String ratings) async {

   var value ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVmMTE1NzZkMDg1NzNkNGJkNDQ4MzQ0YSIsImlhdCI6MTU5NTA0NzY3MywiZXhwIjoxNjAyODIzNjczfQ.vDVasu1PRSamVojze3cw1zBQFH39E88AV2ZVBgzZqpc";
   Map<String, String> headers = { "Authorization": "Bearer $value" ,};

   final mimeType = lookupMimeType(filePath.path,headerBytes: [0xFF, 0xD8]).split('/');

   var request = http.MultipartRequest('PATCH',Uri.parse(url));
   final fileLength = await filePath.length();
   request.headers.addAll(headers);
   request.files.add(await http.MultipartFile.fromPath('image', filePath.path,
                         contentType: MediaType(mimeType[0],mimeType[1])));
   request.fields['ratings'] = ratings;


   try {
     http.Response response = await http.Response.fromStream(await request.send());

    /* response.stream.transform(utf8.decoder).listen((event) {

       print('Image response- $value');

      });*/

     if(response.statusCode == 200){

       var responsedata = jsonDecode(response.body);
       print('in 200 - $responsedata');
       var imageresponse =  responsedata['data']['data'];

       dynamic  data = imageresponse;

       return data;
     }

   } catch (e) {
     print(e);
   }
 }

 Future<dynamic> saveOrder(List<Order> jsonModel) async  {

   var bodyData = jsonEncode(jsonModel);
   print('post order${bodyData}');
   var value ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVmMTE1NzZkMDg1NzNkNGJkNDQ4MzQ0YSIsImlhdCI6MTU5NTA0NzY3MywiZXhwIjoxNjAyODIzNjczfQ.vDVasu1PRSamVojze3cw1zBQFH39E88AV2ZVBgzZqpc";

   http.Response response = await http.post(
       url,body: bodyData,
       headers: {
         "Content-Type": "application/json",
         "Authorization": "Bearer $value"
       });

   if(response.statusCode == 201){

     var resposedata = jsonDecode(response.body);

     print('add book- $resposedata');

     var bookdata = resposedata['data']['data'];

     dynamic  data = bookdata;

     return data;


   }else if(response.statusCode == 500){
     print('$response');
   }

 }


 Future<dynamic>  getMyOrders(String userId) async {

   var value ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVmMTE1NzZkMDg1NzNkNGJkNDQ4MzQ0YSIsImlhdCI6MTU5NTA0NzY3MywiZXhwIjoxNjAyODIzNjczfQ.vDVasu1PRSamVojze3cw1zBQFH39E88AV2ZVBgzZqpc";

   http.Response response = await http.get(
       url+"/"+userId,
       headers: {
         "Content-Type": "application/json",
         "Authorization": "Bearer $value"
       });

   if(response.statusCode == 201){

     var resposedata = jsonDecode(response.body);

     print('orders- $resposedata');

     var bookdata = await resposedata['data']['data'];

     dynamic  data = bookdata;

     return data;


   }else if(response.statusCode == 401){
     print('$response');
   }
 }




}