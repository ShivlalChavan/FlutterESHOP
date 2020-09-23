
import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/constant/constants.dart';
import 'package:flutterstationaryshop/model/myorder.dart';
import 'package:flutterstationaryshop/services/stationaryapi.dart';
import 'package:flutterstationaryshop/widget/ordertile.dart';

class MyOrders extends StatefulWidget {

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {


  List<MyOrder> myOrderData = [];
  bool isLoading;

  @override
  void initState() {
    super.initState();

    setState(() {
      isLoading = true;
    });
    getMyOders();
  }

  Widget buildingScreen(){
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return buildingScreen();
    }else{
      return Scaffold(
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
                'My Order',
                style: kScreenTitle
            ),
          ),
          body:
          Container(
                  child:ListView.builder(itemBuilder: (context,index){
                    return OrderTile(
                      order: myOrderData[index],
                    );
                  },itemCount: myOrderData.length,),
                ),
      );
    }
  }

  void getMyOders() async {

   /* setState(() {
      isLoading = true;
    });*/


    Stationary stationary = Stationary();

    List<MyOrder> orderList = await stationary.getUserOrder("5f114ca49c136049089c6458");

    //print('myOrder'+orderList[0].book.title);

    if(orderList!=null){
     // print('myOrder'+orderList[0].book.title);

      setState(() {
        myOrderData = orderList;
        isLoading = false;
      });
    }else {
      buildingScreen();
    }

  }
}
