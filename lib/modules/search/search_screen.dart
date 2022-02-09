import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit,SearchStates>(
      listener:(context,state){

      },
      builder:(context,state){
        return  Scaffold(
          backgroundColor:Colors.white,
          appBar:AppBar(
            backgroundColor:Colors.white,
            elevation:0.0,
          ) ,
          body:Form(
            key:formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
defaultFormField(
    labeltext: 'Search',
    prefixicon: Icons.search,
    controller: searchController,
    keyboardtype: TextInputType.text,
    obscuretext:false,
    onSubmit:(String text){
SearchCubit.get(context).search(
    text: text,
);
    },
    validate: (String?value){
      if(value!.isEmpty){
        return 'enter text to search';
      }
      return null;
    },
    borderradius:BorderRadius.circular(20.0),
    borderside: BorderSide(width:2.0,color:Colors.indigo),
),
                  SizedBox(
                    height:10.0,
                  ),
                  if(state is SearchLoadingState)
                  LinearProgressIndicator(),
                  SizedBox(
                    height:10.0,
                  ),
                  if(state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                      physics:BouncingScrollPhysics(),
                      itemBuilder:(context,index)=>buildListProduct(
                        SearchCubit.get(context).searchModel!.data!.data[index],
                        context,
                        isOldPrice: false,
                      ),
                      separatorBuilder:(context,index)=>SizedBox(height:2.0),
                      itemCount:SearchCubit.get(context).searchModel!.data!.data.length ,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
