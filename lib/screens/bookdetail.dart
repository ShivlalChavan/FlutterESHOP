import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterstationaryshop/constant/constants.dart';
import 'package:flutterstationaryshop/model/book.dart';
import 'package:flutterstationaryshop/screens/cartscreen.dart';
import 'package:flutterstationaryshop/services/booklistdata.dart';
import 'package:flutterstationaryshop/services/networking.dart';
import 'package:provider/provider.dart';


class BookDetail extends StatefulWidget {

  final String bookId;
  final int index;
  BookDetail({@required this.bookId , @required this.index});

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {

  Book bookdata;


  @override
  void initState() {
    super.initState();
    getBookDetail(widget.bookId);
  }

  void getBookDetail(String id) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Book data = Provider.of<BookListData>(context,listen:false).getBookById(id);
      print('Book Detail-${data.title}');
      setState(() {
        bookdata = data;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children:<Widget>[
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
                             color: Colors.white,
                           ),
                           onPressed: (){
                             Navigator.pop(context);
                           },
                         ),
                        IconButton(
                         icon: Icon(
                           Icons.shopping_cart,
                           color: Colors.white,
                         ),
                         onPressed: (){
                           print('click cart');
                           Navigator.push(context, MaterialPageRoute(builder: (context){
                             return CartScreen();
                           }));
                         },
                        )
                      ],
                    ),
                    Expanded(
                      child:Hero(
                        tag: 'tagImage${widget.index}',
                        child: FadeInImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              bookdata!=null ? NetworkHelper.ImageUrl+bookdata.image : 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png'
                          ), placeholder: AssetImage('images/logo.png'),
                        ),
                      ) ,
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
                     offset: Offset(0,-1),
                     blurRadius: 5,
                     color: Colors.black54
                   )
                 ],
                 borderRadius: BorderRadius.only(
                   topLeft: Radius.circular(55.0),
                   topRight: Radius.circular(55.0)
                 ),
                 color: Colors.white
               ),
               child: Column(
                 children: <Widget>[
                   Container(
                    padding: EdgeInsets.only(left: 20.0,top: 20.0),
                    alignment: Alignment.topLeft,
                     child: Text(
                       bookdata!=null ? bookdata.title : 'book detail',
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
                           bookdata!=null ? '₹ ${bookdata.price}' : '₹',
                           style: kbookTitle,
                         ),
                         Container(
                           padding: EdgeInsets.only(right: 10.0),
                           child: RatingBarIndicator(
                             rating: bookdata!=null ? bookdata.ratings : 1.0,
                             itemBuilder: (context,index) => Icon(
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
                     padding: EdgeInsets.only(left: 20.0,right: 20.0),
                     alignment: Alignment.topLeft,
                     child: Text(
                       bookdata.description !=null ? bookdata.description : 'na',
                       style: kbookDes,
                       textAlign: TextAlign.justify,
                     ),
                   )
                 ],
               ),
             ),
           ),
           RaisedButton(
             padding: EdgeInsets.symmetric(horizontal: 48.0,vertical: 10.0),
             color: Colors.deepOrangeAccent,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(30.0),
             ),
             onPressed: (){
               print('clicked btn');
             },
             child: Text(
               'Buy Now',
               style: kbookTitle,
             ),
           )
        ],
        ),
      ),
    );
  }


}
