
import 'package:json_annotation/json_annotation.dart';



@JsonSerializable()
class Order {

  String book;
  String user;
  String price;
  String paymentId;
  String itemCount;
  String paid;
  String createdAt;
  String id;
  String v;

  Order({
     this.book,
     this.user,
     this.price,
     this.paymentId,
     this.itemCount,
     this.paid,
    this.id,
    this.v
  });



  factory Order.fromJson(Map<String,dynamic> parsedJson){
    return Order(
    book: parsedJson['book'],
    user: parsedJson['user'],
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