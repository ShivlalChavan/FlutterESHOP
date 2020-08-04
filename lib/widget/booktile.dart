import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/constant/constants.dart';
import 'package:flutterstationaryshop/model/book.dart';
import 'package:flutterstationaryshop/services/networking.dart';

class BookTile extends StatelessWidget {

   String heroTag;
   final Book book;
   Function onPressed;


   BookTile({this.heroTag,this.book, this.onPressed});

  @override
  Widget build(BuildContext context) {

    final bookthumnail = Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: Hero(
        tag: heroTag,
        child: FadeInImage(
        width: 90.0,
        height: 90.0,
        fit: BoxFit.fill,
        image: NetworkImage(
          NetworkHelper.ImageUrl+book.image,
        ), placeholder: AssetImage('images/logo.png'),
        ),
      )
    );

    final bookContent = Container(
      margin: EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 4.0,
          ),
          Flexible(
            child: RichText(
              overflow: TextOverflow.ellipsis,
              strutStyle: StrutStyle(fontSize: 14.0),
              text: TextSpan(
                text: book.title !=null ? book.title : ' ',
                style: kbookTitle,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Price:',
                      style: kbookSub,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '₹ ${book.price.toString()}',
                      style: kbookSub,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Rating:',
                      style: kbookSub,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      book.ratings.toString(),
                      style: kbookSub,
                    ),
                  ],
                )
              ),
            ],
          ),
          SizedBox(
            height:10.0 ,
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    'Preview: ',
                     style: kbookSub,
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Flexible(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    strutStyle: StrutStyle(fontSize: 12.0),
                    text: TextSpan(
                      text: book.description !=null ? book.description : 'No Data',
                      style: kbookSub,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );


    final bookCard = Container(
      child:bookContent,
      height: 150.0,
      margin: EdgeInsets.only(left: 46.0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
          color:Colors.grey,
          blurRadius: 8.0,
          offset: Offset(0.0,8.0)
        ),
        ],
      ),
    );

    /*return Card(
      color: Colors.white,
      margin: EdgeInsets.all(10.0),
      elevation: 10.0,
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
            ),
          ],
        ),
      ),
    );*/

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 120.0,
        margin: EdgeInsets.symmetric(vertical: 16.0,horizontal: 24.0),
        child:Stack(
          children: <Widget>[
            bookCard,
            bookthumnail
          ],
        ) ,
      ),
    );
  }
}
