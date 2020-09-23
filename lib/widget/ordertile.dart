import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/constant/constants.dart';
import 'package:flutterstationaryshop/model/myorder.dart';
import 'package:flutterstationaryshop/model/ordermodel.dart';
import 'package:flutterstationaryshop/services/networking.dart';

class OrderTile extends StatelessWidget {

  MyOrder order;

  OrderTile({this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color:Colors.grey,
              blurRadius: 4.0,
              offset: Offset(0.0,8.0)
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListTile(
              title: Text(
                order.book.title==null ? 'Bookname' : order.book.title,
                style: kbookTitle,
              ),
              subtitle: Text(
                '₹ ${order.price}',
                style: kbookDes,
              ),
              trailing: Container(
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_basket,
                    color: Colors.grey.shade500,
                  ), onPressed: () {  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
