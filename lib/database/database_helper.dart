import 'dart:async';
import 'dart:io' as io;
import 'package:flutterstationaryshop/database/productmodel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {

  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db  async {
    if(_db != null) return _db;

    _db = await initDB();
    
    return _db;
  }

  DatabaseHelper.internal();

  initDB()  async{

    io.Directory documentaryDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentaryDirectory.path,"main.db");
    var theDb = await openDatabase(path,version: 1,onCreate: _onCreate);
    return theDb;
  }


  void _onCreate(Database db, int version) async {
    await db.execute(
       "CREATE TABLE Product(id INTEGER PRIMARY KEY, userId TEXT, productname TEXT, productauthor TEXT, price TEXT, image TEXT, quantity TEXT)"
    );
  }

  Future<int> createProduct(CartProduct product) async{
    var dbclient = await db;
    int res = await dbclient.insert("Product", product.toMap());
    return res;
  }


  Future<List<CartProduct>> getProduct() async {
    var dbclient = await db;
    List<Map> list = await dbclient.rawQuery('SELECT * FROM Product');
    List<CartProduct> product = List();

    for(int i = 0; i< list.length; i++) {
      //var cart =  CartProduct(list[i]["userId"],list[i]["productname"],list[i]["productauthor"],list[i]["image"],list[i]["price"],list[i]["quantity"]);
      CartProduct cart = CartProduct();
      cart.userId = list[i]["userId"];
      cart.productname = list[i]["productname"];
      cart.productAuthor = list[i]["productauthor"];
      cart.productImage = list[i]["image"];
      cart.price = list[i]["price"];
      cart.quantity = list[i]["quantity"];

      cart.setProductId(list[i]["id"].toString());
      product.add(cart);
    }

    return product;
  }

  Future<int> deleteProduct(CartProduct product) async{

    var dbclient = await db;

    int res = await dbclient.rawDelete('DELETE FROM Product WHERE id = ?', [product.id]);
    return res;

  }

  Future<bool>  updateProduct(CartProduct product) async {
    var dbQuery = await db;

    int res = await dbQuery.update("Product", product.toMap(),where: " id = ?",whereArgs: <int>[product.id as int]);

    return res > 0 ? true : false ;
  }


}