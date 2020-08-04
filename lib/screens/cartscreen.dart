import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/database/database_helper.dart';
import 'package:flutterstationaryshop/database/productmodel.dart';
import 'package:flutterstationaryshop/screens/checkout_product.dart';
import 'package:flutterstationaryshop/widget/cartlisttile.dart';


class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  List<CartProduct> cartList = [];
  bool isLoading;

  @override
  void initState() {
    super.initState();

    getCartProduct();
  }

  void getCartProduct() async {
    isLoading = true;

    var db = DatabaseHelper();

    List<CartProduct> list = await db.getProduct();

    setState(() {
      cartList = list;
      isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
   if ( isLoading ) {
     buildingScreen();
   }else{
     return  Scaffold(
       body: Container(
         child:ListView.builder(itemBuilder: (context,index){
           return CartItem(
             product: cartList[index],
             onPressed: (){
               print('Pressed on delete');
               Navigator.push(context, MaterialPageRoute(builder: (context){
                   return CheckoutProduct();
               }));
             },
           );
         },itemCount: cartList.length,),
       ),
     );
   }

  }




  Widget buildingScreen(){
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }


}

