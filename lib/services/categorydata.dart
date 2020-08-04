import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/model/catergory.dart';
import 'networking.dart';
import 'stationaryapi.dart';

class CategoryData extends ChangeNotifier {

 List<Category> _categoryList = [
  /*  Category(categoryId:"1",categoryName:"Novel",color: Colors.lightBlueAccent),
    Category(categoryId:"2",categoryName:"Studies",color: Colors.amberAccent),
    Category(categoryId:"3",categoryName:"Cook",color: Colors.deepOrangeAccent),
   Category(categoryId:"4",categoryName:"Children",color: Colors.yellowAccent)*/
 ];

 int get categoryCount{
         return _categoryList.length;
     }

  UnmodifiableListView<Category> get categories {
      return UnmodifiableListView(_categoryList);
  }

   void getCategoryListData() async{
    Stationary stationary = Stationary();

    var categoryData =  await stationary.getCatergoryDataList();
    //Category category = new Category();
      print('$categoryData');
   }

  void updateCategory(Category category){
     if(!_categoryList.contains(category)){
       _categoryList.add(category);
     }
     notifyListeners();
  }


}