import 'package:flutter/material.dart';
import 'package:flutterstationaryshop/constant/constants.dart';
import 'package:flutterstationaryshop/model/book.dart';
import 'package:flutterstationaryshop/model/catergory.dart';
import 'package:flutterstationaryshop/screens/addbookimage.dart';
import 'package:flutterstationaryshop/services/booklistdata.dart';
import 'package:flutterstationaryshop/services/stationaryapi.dart';
import 'package:flutterstationaryshop/widget/dropdown.dart';
import 'package:flutterstationaryshop/widget/textinput.dart';
import 'package:provider/provider.dart';



class AddNewBook extends StatefulWidget {
  @override
  _AddNewBookState createState() => _AddNewBookState();
}

class _AddNewBookState extends State<AddNewBook>  {

  String bookName,bookAuthor,bookPrice,description;
  List<Category> categoryData = null;
  Category categoryValue;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading;
  int _currentIndex= 0 ;
  PageController _pageController;



  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    getCategoryList();

  }

     getCategoryList() async {

    setState(() {
      _isLoading = true;
    });

    Stationary stationary = Stationary();
    List<Category> categoryDatalist = await stationary.getCatergoryDataList();

    if(categoryDatalist!=null){

      print('in Add Book- ${categoryDatalist}');

      setState(() {
        _isLoading = false;
        categoryData = categoryDatalist;
      });
    }

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
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
      backgroundColor: Colors.redAccent,
       leading: IconButton(
         icon: Icon(Icons.arrow_back),
         onPressed: (){
          Navigator.pop(context);
         },
       ),
       title: Text(
         'Add Book',
         style: kScreenTitle
       ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey  ,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: bookInputForm() ,
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: RaisedButton(
                         onPressed: saveBook,
                         textColor: Colors.white,
                         padding: EdgeInsets.all(0.0),
                         child: Container(
                           decoration:  BoxDecoration(
                             gradient: LinearGradient(
                               colors: <Color>[
                                 Colors.red,
                                 Colors.redAccent,
                                 Colors.deepOrangeAccent
                               ],
                             ),
                           ),
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Save Book',
                             style: kScreenTitle,
                          ),
                         ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  /*SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: bookInputForm() ,
              )
            ],
          ),
        ),
      )*/

  Widget bookInputForm() {
    return Column(
      children: <Widget>[
        TextInputField(
          type: TextInputType.text,
          maxLines: 1,
          label: 'Enter book name',
          validator: (String bookName ) {
            return !bookName.isEmpty ? null : 'Please enter book name.';
          },
          onChanged: (value){
            bookName = value;
          },
        ),
        SizedBox(
          height: 20.0,
        ),
        TextInputField(
          type: TextInputType.text,
          maxLines: 1,
          label: 'Enter book author',
          validator: (String bookAuthor){
            return bookAuthor.isEmpty ? 'Please enter book author' : null;
          },
          onChanged: (value){
            bookAuthor = value;
          },
        ),
        SizedBox(
          height: 20.0,
        ),
        TextInputField(
          type: TextInputType.number,
          maxLines: 1,
          label: 'Enter book price',
          validator: (String price){
            return price.isEmpty ? 'Please enter price' : null;
          },
          onChanged: (value){
            bookPrice = value;
          },
        ),
        SizedBox(
          height: 20.0,
        ),
        TextInputField(
          type: TextInputType.multiline,
          maxLines: 3,
          label: 'Enter book description',
          validator: (String description) {
            return description.isEmpty ? 'Please enter description' :  null;
          },
          onChanged: (value){
            description = value;
          },
        ),
       SizedBox(
         height: 10.0,
       ),
        categoryData == null ? Text('Spinner' ,style: kbookTitle,) :
        DropDown(
         title: 'Category: ',
         value: categoryValue,
         hintText: 'Select Category',
         onChanged: (Category value){
           setState(() {
             categoryValue = value;
           });
         },
         onSaved: categoryData.map((e) => DropdownMenuItem(
           child: Text(
             '${e.categoryName}',
             style: kbookTitle,
           ),
           value: e,
         )).toList(),
        )
      ],
    );
  }




  void saveBook() async {

    if(_formKey.currentState.validate()){
      Stationary stationary = Stationary();

      setState(() {
        _isLoading = true;
      });

      Book book = Book(
          title: bookName,
          author:bookAuthor,
          price: double.parse(bookPrice),
          description:description,
          categoryId:categoryValue.categoryId
         );

        var bookJson = book.toJson();
        print('while uploading book - $bookJson');

      Book cdata = await stationary.addNewBook(bookJson);
      print('in addnew Book $cdata');

      if (cdata!=null) {
        resetfields();

        setState(() {
          _isLoading = false;
        });
        Provider.of<BookListData>(context,listen:false).addBook(cdata);

        Navigator.push(context, MaterialPageRoute(builder: (context){
          return AddBookImage(bookId: cdata.id,);
        }));
      }

    }
  }

  void resetfields() {
    bookName = "";
    bookAuthor = "";
    bookPrice ="";
    description ="";
    _formKey.currentState.reset();
  }

}
