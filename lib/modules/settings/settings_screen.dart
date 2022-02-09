import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout_Screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){},
      builder:(context,state){
        var model=ShopCubit.get(context).userModel;
        nameController.text='${model!.data!.name}';
        emailController.text='${model.data!.email}';
        phoneController.text='${model.data!.phone}';
        return Scaffold(
          backgroundColor:Colors.white,
          appBar:AppBar(
            backgroundColor:Colors.white,
            elevation:0.0,
            leading: IconButton(
                  onPressed:(){
                    navigateTo(context, ShopLayoutScreen());
                  },
                  icon:Icon(
                    Icons.arrow_back,
                    color:Colors.indigo,
                  ),
              ),

          ),
          body: ConditionalBuilder(
            condition: ShopCubit.get(context).userModel!=null,
            builder: (BuildContext context)=>Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key:formKey,
                child: Column(
                  children: [
                    defaultFormField(
                        labeltext: 'Name',
                        prefixicon:Icons.person,
                        keyboardtype:TextInputType.name,
                        controller: nameController,
                        obscuretext: false,
                        borderside:BorderSide(width:2.0,color:Colors.indigo),
                        borderradius: BorderRadius.circular(30.0),
                        onSubmit:(String?value){},
                        validate:(String?value){
                          if(value!.isEmpty){
                            return 'Required';
                          }
                          return null;
                        }
                    ),
                    SizedBox(
                      height:20.0,
                    ),
                    defaultFormField(
                        labeltext: 'Email Address',
                        prefixicon:Icons.email,
                        keyboardtype:TextInputType.emailAddress,
                        controller: emailController,
                        obscuretext: false,
                        borderside:BorderSide(width:2.0,color:Colors.indigo),
                        borderradius: BorderRadius.circular(30.0),
                        onSubmit:(String?value){},
                        validate:(String?value){
                          if(value!.isEmpty){
                            return 'Required';
                          }
                          return null;
                        }
                    ),
                    SizedBox(
                      height:20.0,
                    ),
                    defaultFormField(
                        labeltext: 'Phone',
                        prefixicon:Icons.phone,
                        keyboardtype:TextInputType.phone,
                        controller: phoneController,
                        obscuretext: false,
                        borderside:BorderSide(width:2.0,color:Colors.indigo),
                        borderradius: BorderRadius.circular(30.0),
                        onSubmit:(String?value){},
                        validate:(String?value){
                          if(value!.isEmpty){
                            return 'Required';
                          }
                          return null;
                        }
                    ),
                    SizedBox(
                      height:20.0,
                    ),

                      defaultMaterialButton(
                        onpressed: () {
                       signOut(context);
                        },
                        text:'logout',
                        style:TextStyle(
                          color:Colors.white,
                        ),
                        shape:RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(25.0) ,
                        ),
                        color:Colors.indigo,
                        minwidth:400.0,
                        height:50.0,
                      ),



                  ],
                ),
              ),
            ),
            fallback: (BuildContext context)=>Center(child: CircularProgressIndicator()),

          ),
        );
      },
    );
  }
}
