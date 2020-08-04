import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class Book {

 String id;
 String title;
 String description;
 String author;
 String categoryId;
 String image;
 double price;
 double ratings;


 Book({
       this.id,
       this.title,
       this.description,
       this.image,
       this.author,
       this.price,
       this.categoryId,
       this.ratings
 });


 factory Book.fromJson(Map<String,dynamic> parsedJson){
   return Book(
        id:parsedJson['_id'],
        title: parsedJson['title'],
        description: parsedJson['description'],
        author: parsedJson['authorName'],
        categoryId: parsedJson['category'],
        image: parsedJson['image'],
        price: parsedJson['price'],
        ratings: parsedJson['ratings']
   );
 }

 Map<String,dynamic> toJson() {
  // final Map<String, dynamic> data =  Map<String, dynamic>();
   return {
     'title': this.title,
     'description': this.description,
     'authorName': this.author,
     'category': this.categoryId,
     'price': this.price,
   };
 }

 //Map<String, dynamic> toJson() => _$BookToJson();

}