import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterstationaryshop/constant/constants.dart';
import 'package:flutterstationaryshop/database/database_helper.dart';
import 'package:flutterstationaryshop/model/book.dart';
import 'package:flutterstationaryshop/screens/cartscreen.dart';
import 'package:flutterstationaryshop/services/booklistdata.dart';
import 'package:flutterstationaryshop/services/networking.dart';
import 'package:provider/provider.dart';
import 'package:flutterstationaryshop/database/productmodel.dart';


class BookDetail extends StatefulWidget {

  final String bookId;
  final int index;
  BookDetail({@required this.bookId , @required this.index});

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {

  Book bookdata;
  List<CartProduct> _cartList;
  bool isLoading;
  bool cartStatus;

  @override
  void initState() {
    super.initState();
    getBookDetail(widget.bookId);

    getCartDetail();

  }

   void getCartDetail() async {

     isLoading = true;

    var db = DatabaseHelper();

     List<CartProduct> cartList = await db.getProduct();

     setState(() {
       _cartList = cartList;
       isLoading = false;
     });

  }

  void getBookDetail(String id) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Book data = Provider.of<BookListData>(context,listen:false).getBookById(id);
      print('Book Detail-${data.title}');
      setState(() {
        bookdata = data;
        cartStatus = bookdata.addedToCart;
      });
    });
  }


  Widget buildingScreen(){
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  void addToCart() async {
    isLoading = true;

    var db = DatabaseHelper();

    CartProduct cartProduct = CartProduct(userId: "",productId: bookdata.id,productname: bookdata.title,
                                  productAuthor: bookdata.author,productImage: bookdata.image,
                                  price:  bookdata.price.toString(),quantity: "1");

    var int  = await db.createProduct(cartProduct);

    List<CartProduct> cartList = await db.getProduct();

    setState(() {
      _cartList = cartList;
      isLoading = false;
      cartStatus=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(isLoading){
      buildingScreen();
    }else {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white70,
          body: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.white70,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ), Padding(
                            padding: const EdgeInsets.only(
                                right: 16.0, top: 2.0),
                            child: GestureDetector(
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: <Widget>[
                                  Icon(
                                    Icons.shopping_cart,
                                    size: 32.0,
                                    color: Colors.grey,
                                  ),
                                  if (_cartList.length > 0)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: CircleAvatar(
                                        radius: 8.0,
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        child: Text(
                                          _cartList.length.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              onTap: () {
                                if (_cartList.isNotEmpty)
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return CartScreen();
                                      }));
                              },
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Hero(
                          tag: 'tagImage${widget.index}',
                          child: FadeInImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                bookdata != null
                                    ? NetworkHelper.ImageUrl + bookdata.image
                                    : 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png'
                            ), placeholder: AssetImage('images/logo.png'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, -1),
                            blurRadius: 5,
                            color: Colors.black54
                        )
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)
                      ),
                      color: Colors.white
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 20.0, top: 20.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          bookdata != null ? bookdata.title : 'book detail',
                          style: kbookTitle,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              bookdata != null ? '₹ ${bookdata.price}' : '₹',
                              style: kbookTitle,
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 10.0),
                              child: RatingBarIndicator(
                                rating: bookdata != null
                                    ? bookdata.ratings
                                    : 1.0,
                                itemBuilder: (context, index) =>
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                itemCount: 5,
                                itemSize: 24,
                                unratedColor: Colors.amber.shade100,
                                direction: Axis.horizontal,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Description :',
                          style: kbookTitle,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          bookdata.description != null
                              ? bookdata.description
                              : 'na',
                          style: kbookDes,
                          textAlign: TextAlign.justify,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 38.0, vertical: 10.0),
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {
                          print('clicked btn');
                        },
                        child: Text(
                          'Buy Now',
                          style: kbookTitle.copyWith(
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0,right: 10.0),
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 38.0, vertical: 10.0),
                        color: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {
                          print('clicked btn');
                          if(bookdata.addedToCart==false){
                            addToCart();
                          }
                        },
                        child: Text(
                          cartStatus==false ? 'Add To Cart':'Added',
                          style:  kbookTitle.copyWith(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }


}
