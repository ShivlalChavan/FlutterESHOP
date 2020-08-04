import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterstationaryshop/services/categorydata.dart';
import 'categoryitem.dart';


class CategoryList extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryData>(
    builder: (context,bookdata,child){
     return GridView.builder(
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (MediaQuery.of(context).orientation == Orientation.portrait ? 2:3),
         ),
       itemBuilder: (context, index){
        return CategoryItem(
          categoryName: (bookdata.categories[index].categoryName != null ? bookdata.categories[index].categoryName :''),
         // cColor: (bookdata.categories[index].color !=null ? bookdata.categories[index].color : Colors.lightBlueAccent),
          onPress: (){
            print('Item click ${bookdata.categories[index].categoryName}');
          },
        );
       },
       itemCount: bookdata.categoryCount,
     );
    },
    );
  }
}
