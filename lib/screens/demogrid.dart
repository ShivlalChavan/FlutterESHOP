import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/model/book.dart';
import 'package:flutterstationaryshop/model/catergory.dart';
import 'package:flutterstationaryshop/services/stationaryapi.dart';
import 'package:flutterstationaryshop/widget/categorylist.dart';
import 'package:flutterstationaryshop/services/categorydata.dart';

class Demo extends StatefulWidget {

  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<Demo> {

  @override
  void initState() {
    super.initState();

    getCategoryList();

  }

  void getCategoryList() async{

    Stationary stationary = Stationary();

    //var categoryData =  await stationary.getCatergoryDataList();

    List<Book> booklist = await stationary.getBookList();

    print('Book Data -: ${booklist[0].title}');

   /* Category category = Category();
    category.categoryName = categoryData[]*/

  }


  @override
  Widget build(BuildContext context) {
    return (
       Text('demo')
    );
  }


}

