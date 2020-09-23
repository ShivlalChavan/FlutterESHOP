import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutterstationaryshop/constant/constants.dart';
import 'package:flutterstationaryshop/database/database_helper.dart';
import 'package:flutterstationaryshop/database/productmodel.dart';
import 'package:flutterstationaryshop/model/ordermodel.dart';
import 'package:flutterstationaryshop/model/paymentMethod.dart';
import 'package:flutterstationaryshop/screens/dashboard.dart';
import 'package:flutterstationaryshop/services/stationaryapi.dart';
import 'package:flutterstationaryshop/widget/checkboxtile.dart';
import 'package:flutterstationaryshop/widget/simplealert.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class CheckoutProduct extends StatefulWidget {
  @override
  _CheckoutProductState createState() => _CheckoutProductState();
}

class _CheckoutProductState extends State<CheckoutProduct> {

  static const platform = const MethodChannel("razorpay_flutter");


  Razorpay _razorpay;

  List<PaymentMethod> paymentMethodData =  List<PaymentMethod>();

  bool isLoading;
  var db;
  List<CartProduct> cartList = [];
  List<Order> orderList = [];
  double totalPrice= 0;
  bool _isLoading;

  PaymentMethod paymentMethod = PaymentMethod();



  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    db = DatabaseHelper();
    getCartProduct();

    getPaymentTypeData();


  }

  @override
  void dispose() {
    super.dispose();

    _razorpay.clear();

  }

  void getCartProduct() async {

    isLoading = true;

    await updateCartItems();

   // callApiForSaveOrder('pay_FLqXqs2PilXxZm');


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


   void getPaymentTypeData(){

     PaymentMethod cash = PaymentMethod(
       type: 'Cash On Delivery',
       icon:Icon(
       Icons.motorcycle,
       size: 48.0,
         color: Colors.redAccent,
     ));
     paymentMethodData.add(cash);

     PaymentMethod card = PaymentMethod(
         type: 'Online Payment',
         icon:Icon(
           Icons.credit_card,
           size: 48.0,
           color: Colors.redAccent,
         ));

     paymentMethodData.add(card);
   }



  Widget showCircularProgress(){
    if(_isLoading){
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
          ],
        ),
      );
    }
    return Container(
      width: 0.0,
      height: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'Payment',
          style: kbookTitle,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Container(
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
          child:ListView.builder(itemBuilder: (context,index){
             return CheckBoxTile(
               title: paymentMethodData[index].type,
               icon: paymentMethodData[index].icon,
               onChanged: (PaymentMethod value){
                 setState(() {
                   paymentMethod = value;
                   //paymentMethodData[index].toggleDone();
                 });

               },
              isChecked: paymentMethodData[index].isDone,
             );
          },itemCount: paymentMethodData.length,) ,
          ),
            RaisedButton(
              onPressed: _openCheckout,
              child: Text(
                'Place Order',
                style: kbookTitle,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _openCheckout() async {



    var options = {
      'key': 'rzp_test_zQf3REihIEWw0w',
      'amount': 2000,  // Money Should be in paise , if double convert to paise  and should be greater than 100
       'name': 'Two States',
       'description':'Novel Book',
       'prefill': {'contact': '9012345678','email': 'test@gmail.com'},
    };

    try{
      _razorpay.open(options);

    }catch (e){
      print('exception $e');
    }

  }

  _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success ${response.paymentId}');

    callApiForSaveOrder(response.paymentId);
  }

  _handlePaymentError(PaymentFailureResponse response) {
    print('Error ${response.code.toString()}');
  }

  _handleExternalWallet(ExternalWalletResponse response) {
    print('Wallet ${response.walletName}');
  }

  void callApiForSaveOrder(String paymentId)  async{

    Stationary stationary = Stationary();

    cartList.forEach((element) {
      Order order = Order(
          book: element.productId,
          price: element.price,
          user:'5f114ca49c136049089c6458',
          paid: 'true',
          paymentId: paymentId,
          itemCount: '1'
      );
      orderList.add(order);
    });

    print(' Order lits: ${orderList[0].toJson()}');

    setState(() {
      _isLoading = true;
    });


    List<Order> resorderList = await stationary.getSavedOrder(orderList);
    
    var db = DatabaseHelper();
    
     var int = await db.deleteCartable();

    print(' Order lits: ${orderList[0].toJson()}');

    setState(() {
      isLoading= false;
    });


    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              "ESHOP",
              style: kbookTitle,
            ),
            content: Text(
                "Order placed successfully.",
              style: kbookTitle,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                    "OK",
                  style: kbookTitle,
                ),
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                    return Dashboard();
                  }),(Route<dynamic> route) => false);
                },
              )
            ],

          );
        });



  }



   //TODO:Use this for converting decimal to paise .
 /* RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
 double money = totalPrice;
    double tMoney = money*100;
    String stringMoney = tMoney.toString().replaceAll(regex, '');
    int totalMoney = int.parse(stringMoney);*/


}
