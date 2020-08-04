import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterstationaryshop/constant/constants.dart';
import 'package:flutterstationaryshop/model/book.dart';
import 'package:flutterstationaryshop/services/stationaryapi.dart';
import 'package:image_picker/image_picker.dart';

class AddBookImage extends StatefulWidget {

  String bookId;

  AddBookImage({@required this.bookId});

  @override
  _AddBookImageState createState() => _AddBookImageState();
}

class _AddBookImageState extends State<AddBookImage> {

  File  cameraImage;
  bool imageSeletecd = false;
  bool _isLoading;

  @override
  void initState() {
    super.initState();

    _isLoading = false;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
         child: Stack(
           alignment:Alignment.center,
           children: <Widget>[
             Container(
               margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
               child: Padding(
                 padding: EdgeInsets.all(20.0),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                     Container(
                       child: Text(
                           'Add  Book Image',
                         style: kbookTitle,
                       ) ,
                     ),
                     imageSeletecd == true ?
                     displayImage(cameraImage) :
                     Container(width: 200,height: 200,
                     child: Image.asset('images/image_preview.png',fit: BoxFit.fill,),),
                     Container(
                       padding: EdgeInsets.all(20.0),
                       child: RaisedButton(
                         onPressed: bookImageSelection,
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
                             'Select Image',
                             style: kScreenTitle,
                           ),
                         ),
                       ),
                     ),
                     SizedBox(
                       height: 10.0,
                     ),
                     Container(
                       padding: EdgeInsets.symmetric(horizontal: 8.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           Text(
                             'Apply Rating: ',
                             style: kbookTitle,
                           ),
                           Container(
                             padding: EdgeInsets.only(right: 0.0),
                             child: RatingBar(
                               initialRating: 1.1,
                               minRating: 1.1,
                               allowHalfRating: true,
                               itemBuilder: (context,index) => Icon(
                                 Icons.star,
                                 color: Colors.amber,
                               ),
                               onRatingUpdate: (rating){
                                 print('rating- $rating');
                               },
                               itemCount: 5,
                               itemSize: 30,
                               unratedColor: Colors.amber.shade100,
                               direction: Axis.horizontal,
                             ),
                           ),
                         ],
                       ),
                     ),
                     SizedBox(
                       height: 20.0,
                     ),
                     Container(
                       padding: EdgeInsets.all(20.0),
                       child: RaisedButton(
                         onPressed:  saveBook ,
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
                             'Upload Book',
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

    );
  }

  void saveBook() async{

    setState(() {
      _isLoading = true;
    });

    if(cameraImage !=null){

      Stationary stationary = Stationary();

      try {

        Book bookObject = await stationary.addBookImage(cameraImage, "2.1", widget.bookId);
        print('response- ${bookObject.toJson()}');
        if(bookObject!= null){
          setState(() {
            _isLoading = false;

          });

          Navigator.pop(context);
        }


      } catch (e) {
        print(e);
      }

    }
    else {
      showAlertDialog(context);
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

  Widget bookImageSelection() {
     showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) => SingleChildScrollView(
          child: Container(
           padding: EdgeInsets.all(20.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Container(
                 padding: EdgeInsets.all(20.0),
                 child: RaisedButton(
                   onPressed: galleyImageSelect,
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
                     padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                     child: Text(
                       'Gallery',
                       style: kScreenTitle,
                     ),
                   ),
                 ),
               ),
               Container(
                 padding: EdgeInsets.all(20.0),
                 child: RaisedButton(
                   onPressed: cameraImageSelect,
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
                     padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                     child: Text(
                       'Camera',
                       style: kScreenTitle,
                     ),
                   ),
                 ),
               ),
             ],
           ),
          ),
        )
    );
  }


   cameraImageSelect() async {
     Navigator.pop(context);
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    File imageFile ;
    try {
      imageFile = File(pickedFile.path);
    } catch (e) {
      print(e);
    }

    print('picked image - ${pickedFile.path}');

    setState(() {
      cameraImage = imageFile;
      imageSeletecd = true;
    });


  }

  void galleyImageSelect() async {
    Navigator.pop(context);

    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    File imageFile ;
    try {
      imageFile = File(pickedFile.path);
    } catch (e) {
      print(e);
    }
    print('picked Galleryimage - ${pickedFile.path}');
    setState(() {
      cameraImage = imageFile;
      imageSeletecd = true;
    });

  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK",style: kErrorTitle),
      onPressed: () { Navigator.of(context).pop();},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: Text("E-Shop",style: kbookTitle,),
      content: Text("Please select image" ,style: kErrorTitle,),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

 Widget displayImage(File file) {
    return SizedBox(
      height: 200.0,
      width: 200.0,
      child: imageSeletecd == false ? Text('Nothing Selected') : Image.file(file),
    );
 }

}
