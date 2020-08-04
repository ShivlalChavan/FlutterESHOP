import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/constant/constants.dart';
import 'package:flutterstationaryshop/database/productmodel.dart';
import 'package:flutterstationaryshop/services/networking.dart';

class CartItem extends StatelessWidget {

  CartProduct product;
  Function onPressed;

  CartItem({this.product,this.onPressed});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color:Colors.grey,
              blurRadius: 6.0,
              offset: Offset(0.0,8.0)
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.2,
            child: Container(
                height:100 ,
                margin: EdgeInsets.all(8.0),
                child:Image.network(NetworkHelper.ImageUrl+product.productImage)
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                product.productname,
                style: kbookTitle,
              ),
              subtitle: Text(
                '₹ ${product.price}',
                style: kbookDes,
              ),
              trailing: Container(
                child: IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.grey.shade500,
                  ),
                  onPressed: onPressed,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
