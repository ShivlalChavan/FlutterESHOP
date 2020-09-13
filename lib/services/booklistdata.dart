import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/model/book.dart';

class BookListData extends ChangeNotifier {

  List<Book> bookDataList = [];
  Book bookData;

  void setBookList(List<Book> list){
    print('in privder${list.length}');
    this.bookDataList = list;
    notifyListeners();
  }

  int get bookListCount{
    if(bookDataList.length>0){
      return bookDataList.length;
    }
    return 0;
  }


  UnmodifiableListView<Book>  get BookList {
    return UnmodifiableListView(bookDataList);
  }

  Book getBookById(String id){
    Book book;
    for(var item in bookDataList){
      if(item.id == id){
        book = item;
      }
    }

    return book;
  }


  addBook(Book data) {
    bookData = Book();
    bookData = data;
    notifyListeners();
  }

  

  Book getSingleBook() {
    if(bookData !=null){
      return bookData;
    }
  }




}