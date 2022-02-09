import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modles/categories_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener:(context,state){},
      builder:(context,state){
          var cubit=ShopCubit.get(context);
return Container(
  decoration:BoxDecoration(
    color:Colors.white,
    borderRadius:BorderRadius.only(
      topLeft:Radius.circular(50.0),
      topRight:Radius.circular(50.0),
      bottomLeft:Radius.circular(50.0),
      bottomRight:Radius.circular(50.0),
    ),
  ),
  child:   ListView.separated(

    physics:BouncingScrollPhysics(),

    itemBuilder:(context,index)=>buildCatItem(cubit.categoriesModel!.data!.dataList[index]),

    separatorBuilder:(context,index)=> Container(
      width:1,
      height:1,
      color:Colors.red[100],
    ),

    itemCount:cubit.categoriesModel!.data!.dataList.length,

  ),
);
      },
    );

  }

 Widget buildCatItem(DataModel?model){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image:NetworkImage('${model!.image}'),
            width: 100.0,
            height: 100.0,
            fit:BoxFit.cover,
          ),
          SizedBox(
            width:20.0,
          ),
          Text(
            '${model.name}',
            style:TextStyle(
              fontSize:20.0,
              fontWeight:FontWeight.bold,
            ),
          ),
        ],
      ),
    );
 }
}