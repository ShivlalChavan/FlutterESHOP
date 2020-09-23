class CartProduct{

  String id;
  String productId;
  String userId;
  String productname;
  String productAuthor;
  String productImage;
  String price;
  String quantity;

  CartProduct({this.userId,this.productId,this.productname,this.productAuthor,this.productImage,this.price,this.quantity});

  CartProduct.map(dynamic obj) {
    this.userId = obj["userId"];
    this.productId = obj['productid'];
    this.productname = obj["productname"];
    this.productAuthor = obj["productauthor"];
    this.productImage = obj["image"];
    this.price = obj["price"];
    this.quantity = obj["quantity"];
  }

  Map<String, dynamic> toMap(){
    var map = Map<String,dynamic>();
    map["userId"] = this.userId;
    map['productid']=this.productId;
    map["productname"] = productname;
    map["productauthor"] = productAuthor;
    map["image"] = productImage;
    map["price"] = price;
    map["quantity"] = quantity;

    return map;
  }

  void setProductId(String id) {
    this.id = id;
  }



}