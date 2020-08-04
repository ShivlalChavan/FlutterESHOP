import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterstationaryshop/constant/constants.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class CheckoutProduct extends StatefulWidget {
  @override
  _CheckoutProductState createState() => _CheckoutProductState();
}

class _CheckoutProductState extends State<CheckoutProduct> {
  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay;


  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();

    _razorpay.clear();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'Payment',
          style: kbookTitle,
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: _openCheckout,
              child: Text(
                'PAY',
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
  }

  _handlePaymentError(PaymentFailureResponse response) {
    print('Error ${response.code.toString()}');
  }

  _handleExternalWallet(ExternalWalletResponse response) {
    print('Wallet ${response.walletName}');
  }

   //TODO:Use this for converting decimal to paise .
  /*
  * RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
 double money = double.parse(widget.totalMoney);
    double tMoney = money*100;
    String stringMoney = tMoney.toString().replaceAll(regex, '');
    int totalMoney = int.parse(stringMoney);
    * */

}
