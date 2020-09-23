import 'dart:io';
import 'package:flutterstationaryshop/model/book.dart';
import 'package:flutterstationaryshop/model/catergory.dart';
import 'package:flutterstationaryshop/model/myorder.dart';
import 'package:flutterstationaryshop/model/ordermodel.dart';
import 'package:flutterstationaryshop/services/networking.dart';

const BaseUrl = "http://192.168.15.207:3000/api/v1";


class Stationary {

  Future<dynamic> getCategoryList() async {

    NetworkHelper networkHelper = NetworkHelper('$BaseUrl/category');

    var categoryData = await networkHelper.getData();

    //print(categoryData);

    return categoryData;

  }


  Future<List<Category>> getCatergoryDataList() async {

    List<Category> categoryList = null;
    NetworkHelper networkHelper = NetworkHelper('$BaseUrl/category');

    List<dynamic> categoryData = await networkHelper.getData();

    try{
      if(categoryData!=null){

        categoryList = (categoryData).map((listItem) => Category.fromJson(listItem)).toList();
        print('Category List - ${categoryList}');

         return categoryList;
      }
    }catch(e){
      print(e.toString());
    }

    return categoryList;
  }


  Future<Book> addNewBook(Map<String,dynamic> bodyData) async {

    NetworkHelper  networkHelper = NetworkHelper('$BaseUrl/book');

    Map data = await networkHelper.addNewBook(bodyData);


    Book cadata = Book.fromJson(data);

    // Book cadata = (data).map((item) => Book.fromJson(item));

    print('in Stationary- $cadata');

    return cadata;

  }


  Future<List<Book>> getBookList() async {

    List<Book> bookList = null;
    NetworkHelper networkHelper = NetworkHelper('$BaseUrl/book');

    List<dynamic> bookdata = await networkHelper.getBookData();

    try {
      if(bookdata!=null){

            //bookList = (jsonDecode(bookdata)as List).map((e) => Book.fromJson(e)).toList();
           // var data = bookdata.map((list) => json.decode(list)).toList();

            bookList = (bookdata).map((listItem) => Book.fromJson(listItem)).toList();
            return bookList;

          }
    } catch (e) {
      print(e);
    }

    return bookList;
  }


  Future<Book> addBookImage(File filePath, String ratings,String bookId) async{

    NetworkHelper networkHelper = NetworkHelper('$BaseUrl/book/$bookId');

    try {

      Map response = await networkHelper.addBookImage(filePath, ratings);

      print('in Stationary image $response');
      Book cadata = Book.fromJson(response);

      return cadata;

    } catch (e) {
      print(e);
    }

  }

  Future<List<Order>> getSavedOrder(List<Order> bodyData) async{
    List<Order> orderList = null;

    NetworkHelper networkHelper = NetworkHelper('$BaseUrl/bookings');

    List<dynamic> orderdata = await networkHelper.saveOrder(bodyData);
    try {

      if(orderdata!=null){

        orderList = (orderdata).map((listItem) => Order.fromJson(listItem)).toList();
        return orderList;

      }
    } catch (e) {
      print(e);
    }

    return orderList;

  }

  Future<List<MyOrder>>  getUserOrder(String userId) async {

    List<MyOrder> userOrderData= null;

    NetworkHelper networkHelper = NetworkHelper('$BaseUrl/bookings');

    List<dynamic> orderdata = await networkHelper.getMyOrders(userId);

    try{

      if(orderdata!=null){

        userOrderData = (orderdata).map((item) =>MyOrder.fromJson(item)).toList();

        return userOrderData;
      }
    }catch(e){
      print(e);
    }


   }
}