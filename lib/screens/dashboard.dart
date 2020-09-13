import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/constant/constants.dart';
import 'package:flutterstationaryshop/database/database_helper.dart';
import 'package:flutterstationaryshop/database/productmodel.dart';
import 'package:flutterstationaryshop/localization/language.dart';
import 'package:flutterstationaryshop/localization/language_constant.dart';
import 'package:flutterstationaryshop/screens/addnewbook.dart';
import 'package:flutterstationaryshop/screens/demogrid.dart';
import 'package:flutterstationaryshop/screens/usersettings.dart';
import 'package:flutterstationaryshop/widget/booklist.dart';

import '../main.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int _currentIndex= 0 ;
  PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    checkDb();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index){
            setState(() {
              _currentIndex = index;
            });
          },
        children: <Widget>[
          BookList(),
          AddNewBook(),
          Settings()
        ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index){
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        backgroundColor: Colors.white,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text(getTranslated(context, 'home'),style: kScreenTitle.copyWith(color: Colors.redAccent,fontSize:14.0,fontWeight: FontWeight.bold ),),
            icon: Icon(Icons.home),
            activeColor: Colors.redAccent,
            inactiveColor: Colors.deepOrangeAccent.shade100
          ),
          BottomNavyBarItem(
              title: Text(getTranslated(context, 'add_book'),style: kScreenTitle.copyWith(color: Colors.redAccent,fontSize:14.0,fontWeight: FontWeight.bold ),),
              icon: Icon(Icons.add_box),
              activeColor: Colors.redAccent,
              inactiveColor: Colors.deepOrangeAccent.shade100
          ),
          BottomNavyBarItem(
              title: Text(getTranslated(context, 'settings'),style: kScreenTitle.copyWith(color: Colors.redAccent,fontSize:14.0,fontWeight: FontWeight.bold ),),
              icon: Icon(Icons.settings),
              activeColor: Colors.redAccent,
              inactiveColor: Colors.deepOrangeAccent.shade100
          ),
        ],
      ),
    );
  }

  void checkDb() async {

    /*var db = DatabaseHelper();
    var product = CartProduct("5f114ca49c136049089c6458","Two States","Chetan Bhagat","book-5f1d7f2d44642b3f58dd1843-1595768649068.jpeg","220.5","1");
    await db.createProduct(product);
    */

    var db = DatabaseHelper();

    List<CartProduct> list = await db.getProduct();
    print('GOT List - ${list[0].toMap()}');

  }

  void _changedLanguage(Language languae) async{
    Locale _locale = await setLocale(languae.langaugeCode);
    App.setLocale(context, _locale);
  }
}
