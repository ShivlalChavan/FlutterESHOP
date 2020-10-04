import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/constant/constants.dart';
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
  double totalPrice= 0;
  var db;

  @override
  void initState() {
    super.initState();

    db = DatabaseHelper();

    getCartProduct();
  }

  void getCartProduct() async {

    isLoading = true;

    await updateCartItems();


  }

   void updateCartItems() async {

     List<CartProduct> list = await db.getProduct();
     double price=0;

     list.forEach((element)
     {
       price = price + double.parse(element.price);
     });

     setState(() {
       cartList = list;
       isLoading = false;
       totalPrice = price;
     });
   }

  @override
  Widget build(BuildContext context) {
   if ( isLoading ) {
     buildingScreen();
   }else{
     return  Scaffold(
       backgroundColor: Colors.white,
       appBar:AppBar(
         backgroundColor: Colors.redAccent,
         leading: IconButton(
           icon: Icon(Icons.arrow_back),
           onPressed: (){
             Navigator.pop(context);
           },
         ),
         title: Text(
             'Cart Details',
             style: kScreenTitle
         ),
       ),
       body:
       Column(
         children: <Widget>[
           Expanded(
             child: Container(
               child:ListView.builder(itemBuilder: (context,index){
                 return CartItem(
                   product: cartList[index],
                   onPressed: (){
                     print('Pressed on delete');
                     deleteCartItem(cartList[index]);
                   },
                 );
               },itemCount: cartList.length,),
             ),
           ),
           Container(
             height: 50,
             color: Colors.white54,
             child: Padding(
               padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Container(
                     color: Colors.black12,
                     child: Padding(
                       padding: EdgeInsets.all(10.0),
                       child: Container(
                         child: Text(
                           'Total: ₹ ${totalPrice} ',
                           style: kbookTitle.copyWith(
                             fontWeight: FontWeight.bold
                           ),
                         )
                       ),
                     ),
                   ),
                   Padding(
                     padding: EdgeInsets.all(2.0),
                     child: Container(
                         color: Colors.deepOrange,
                         child: RaisedButton(
                           padding: EdgeInsets.symmetric(horizontal: 38.0, vertical: 0.0),
                           color: Colors.red,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(10.0),
                           ),
                           onPressed: () {
                             print('clicked btn');
                             Navigator.push(context, MaterialPageRoute(builder: (context){
                               return CheckoutProduct();
                             }));
                           },
                           child: Text(
                             'Checkout',
                             style: kbookTitle.copyWith(
                                 color: Colors.white,
                                 fontWeight: FontWeight.bold
                             ),
                           ),
                         ),
                     ),
                   )
                 ],
               ),
             ),
           )
         ],
       )

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

  void deleteCartItem(CartProduct cartItem) async {

      db = DatabaseHelper();

      int update =  await db.deleteProduct(cartItem);

      updateCartItems();

  }


}

