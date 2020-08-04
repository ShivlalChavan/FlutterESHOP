import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/widget/categorylist.dart';

class DashboardScreen extends StatefulWidget {

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      body: SafeArea(
         child: Container(
           padding: EdgeInsets.all(20.0),
           child: Column(
             children: <Widget>[
               Container(
                 width: double.infinity,
                 height: 250,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: AssetImage('images/dashboardImage.jpg'),
                      fit: BoxFit.cover
                    ),
                 ),
                 child: Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(20.0),
                     gradient: LinearGradient(
                       begin: Alignment.bottomRight,
                       colors: [
                         Colors.black.withOpacity(.4),
                         Colors.black.withOpacity(.2),
                       ]
                     )
                   ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: <Widget>[
                       Text('Book Store',
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 32,
                         fontWeight:  FontWeight.bold
                       ),),
                       SizedBox(
                         height: 20.0,
                       ),
                       Container(
                         height: 48.0,
                         margin: EdgeInsets.symmetric(horizontal: 40.0),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10.0),
                           color: Colors.white
                         ),
                         child: Center(
                           child: Text(
                             'Shop Now',
                             style: TextStyle(
                               color: Colors.grey[900],
                               fontWeight: FontWeight.bold
                             ),
                           ),
                         ),
                       ),
                       SizedBox(
                         height: 30.0,
                       )
                     ],
                   ),
                 ),
               ),
               SizedBox(
                 height: 20.0,
               ),
               Expanded(
                 child: Container(
                   decoration: BoxDecoration(     //TODO:Chnage after gridview list here
                     color: Colors.white
                   ),
                   child: CategoryList(),
                 ),
               )
             ],
           ),
         ),
      )
    );
  }
}

