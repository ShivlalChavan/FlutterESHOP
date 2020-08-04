import 'package:flutter/material.dart';

class Category {

  String categoryId;
  String categoryName;
 // Color color;
  Category({
      this.categoryId,
      this.categoryName,
  });

factory Category.fromJson(Map<String,dynamic> parsedJson){
        return Category(
               categoryId:parsedJson['_id'],
               categoryName: parsedJson['categoryName']
        );
 }

}