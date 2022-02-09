import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){},
      builder:(context,state){
        return ConditionalBuilder(
                condition:state is !GetFavoritesLoadingState ,
                builder: (BuildContext context) =>ListView.separated(
                  physics:BouncingScrollPhysics(),
                  itemBuilder:(context,index)=>Container(color:Colors.white,child: buildListProduct(ShopCubit.get(context).favoritesModel!.data!.favourites[index]!.product, context)),
                  separatorBuilder:(context,index)=>Container(
                    width:1,
                    height:1,
                    color:Colors.red[100],
                  ),
                  itemCount:ShopCubit.get(context).favoritesModel!.data!.favourites.length ,
                ),
                fallback: (BuildContext context)=>Center(child: CircularProgressIndicator()),

              );



      },

    );
  }



}