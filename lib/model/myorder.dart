





import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class OrderBook {
  String id;
  String title;
  String  iid;


  OrderBook({
    this.id,
    this.title,
    this.iid
  });



  factory OrderBook.fromJson(Map<String,dynamic> parsedJson){
    return OrderBook(
        id: parsedJson['id'],
        title: parsedJson['title'],
        iid: parsedJson['_id']
    );
  }


  Map<String,dynamic> toJson() {
    return {
      'id': this.id,
      'title': this.title,
      '_id': this.iid
    };
  }
}



@JsonSerializable()
class User {
  String id;
  String role;
  String  name;
  String  email;
  int  v;


  User({
    this.id,
    this.role,
    this.name,
    this.email,
    this.v

  });



  factory User.fromJson(Map<String,dynamic> parsedJson){
    return User(
        id: parsedJson['_id'],
        role: parsedJson['role'],
        name: parsedJson['name'],
      email: parsedJson['email'],
      v: parsedJson['__v'],
    );
  }


  Map<String,dynamic> toJson() {
    return {
      '_id': this.id,
      'role': this.role,
      'name': this.name,
      'email': this.email,
      '__v': this.v

    };
  }
}


@JsonSerializable()
class MyOrder {

  OrderBook book;
  User user;
  double price;
  String paymentId;
  int itemCount;
  bool paid;
  String createdAt;
  String id;
  int v;

  MyOrder({
    this.book,
    this.user,
    this.price,
    this.paymentId,
    this.itemCount,
    this.paid,
    this.id,
    this.v
  });



  factory MyOrder.fromJson(Map<String,dynamic> parsedJson){
    return MyOrder(
        book: OrderBook.fromJson(parsedJson['book']),
        user: User.fromJson(parsedJson['user']),
        price: parsedJson['price'],
        paymentId: parsedJson['paymentId'],
        itemCount: parsedJson['itemCount'],
        paid: parsedJson['paid'],
        id:parsedJson['_id'],
        v: parsedJson['__v']
    );
  }


  Map<String,dynamic> toJson() {
    return {
      'book': this.book,
      'user': this.user,
      'price': this.price,
      'paymentId': this.paymentId,
      'itemCount' : this.itemCount,
      'paid': this.paid
    };
  }


}