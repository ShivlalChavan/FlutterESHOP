import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/constant/constants.dart';
import 'package:flutterstationaryshop/database/database_helper.dart';
import 'package:flutterstationaryshop/database/productmodel.dart';
import 'package:flutterstationaryshop/model/book.dart';
import 'package:flutterstationaryshop/screens/bookdetail.dart';
import 'package:flutterstationaryshop/screens/cartscreen.dart';
import 'package:flutterstationaryshop/services/booklistdata.dart';
import 'package:flutterstationaryshop/services/stationaryapi.dart';
import 'package:flutterstationaryshop/widget/booktile.dart';
import 'package:provider/provider.dart';


class BookList extends StatefulWidget {
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {

  List<Book> bookListData;
  List<Book> filterBookList = [];
  List<CartProduct> _cartList;
  bool showSpinner = true,isLoading;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    getBookList();
    //getCartDetail();
  }

  void getCartDetail() async {

  //  isLoading = true;

    var db = DatabaseHelper();

    List<CartProduct> cartList = await db.getProduct();

    setState(() {
      _cartList = cartList;
      showSpinner = false;
    });

  }

  void getBookList()  async {
    Stationary stationary = Stationary();

    List<Book> booklist = await stationary.getBookList();

     setState(() {
      bookListData = booklist;
     // showSpinner = false;
    });

     getCartDetail();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<BookListData>(context ,listen:false).setBookList(bookListData);
    });

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

    if(showSpinner){
      return buildingScreen();
    }
    else
      {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.redAccent,
          title: Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Text(
              'Novel',
              style:TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800
              ) ,
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, top: 2.0),
                  child: GestureDetector(
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Icon(
                          Icons.shopping_cart,
                          size: 32.0,
                          color: Colors.white,
                        ),
                        if (_cartList.length > 0)
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: CircleAvatar(
                              radius: 8.0,
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                              child: Text(
                                _cartList.length.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.0,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    onTap: () {
                      if (_cartList.isNotEmpty)
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return CartScreen();
                            }));
                    },
                  ),
                ),
              ],
            )
          ],
        ),
        body: buildBody(),
        resizeToAvoidBottomPadding: true,
      );
    }

  }

  Widget buildBody(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SearchBox(),
        SizedBox(
          height: 1.0,
        ),
        Expanded(
          child:filterBookList.length!=0 || controller.text.isNotEmpty
              ? filteredList() : bookList(),
        ),
      ],
    );
  }

  //seacrh bar
  Widget SearchBox(){
    return Container(
      height: 82,
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child: Card(
        color: Colors.white,
        elevation: 10.0,
        shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
        ) ,
        child: ListTile(
          leading: Icon(
            Icons.search,
            color: Colors.black54,
          ),
          title: TextField(
            style: TextStyle(
                color: Colors.black
            ),
            decoration: kSearchTextFieldInputDec,
            controller: controller,
            onChanged: onSearchTextChanged,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.black54,
            ),
            onPressed: (){
              controller.clear();
              onSearchTextChanged('');
            },
          ),
        ),
      ),
    );
  }

  //data list ui
  Widget bookList(){
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        shrinkWrap: false,
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                      (context,index) => BookTile(
                        heroTag: 'tagImage$index',
                         book: bookListData[index],
                        onPressed: (){
                          print('pressed${bookListData[index].title}');
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return BookDetail(
                              bookId:bookListData[index].id,
                              index: index,
                            );
                          }));
                        },
               ),
                  childCount: bookListData.length
              ),
            ),
          )
        ],
      ),
    );
  }

  //filtered list ui
  Widget filteredList() {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        shrinkWrap: false,
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                      (context,index) => BookTile(
                        heroTag: 'tagImage$index',
                          book:filterBookList[index],
                          onPressed: (){
                            print('pressed${filterBookList[index].title} // $index');
                          },
                      ),
                  childCount: filterBookList.length
              ),
            ),
          )
        ],
      ),
    );
  }



  void onSearchTextChanged(String inputtext) async {
        filterBookList.clear();
       List<Book> seachList =[];
       if(inputtext.isEmpty){
         setState(() {
         });
         return;
       }

       bookListData.forEach((element) {
          if(element.title.trim().toLowerCase().contains(inputtext)){
            seachList.add(element);
          }
       });

       if(seachList.isNotEmpty)(
           setState(() {
             filterBookList = seachList;
           })
       );

  }
}


