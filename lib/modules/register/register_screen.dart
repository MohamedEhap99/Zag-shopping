import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout_Screen.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/networks/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var phoneController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener:(context,state){
          if(state is RegisterSuccessStateState) {
            if (state.registerModel.status==true) {
              print(state.registerModel.status);
              print(state.registerModel.message);
              print(state.registerModel.data!.token);
              showToast(
                  text:'${state.registerModel.message}',
                  state: ToastStates.SUCCESS
              );
              CacheHelper.saveData(key: 'token', value: state.registerModel.data!.token).then((value){
                token='${state.registerModel.data!.token}';
                navigateAndFinish(context, ShopLayoutScreen());
              });
            }
            else{
              print(state.registerModel.message);
              showToast(
                text:'${state.registerModel.message}',
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder:(context,state){
          return Scaffold(
            backgroundColor:Colors.white,
            appBar:AppBar(
              backgroundColor:Colors.white,
              elevation:0.0,
            ),
            body:SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key:formKey,
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.center,
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal:25.0,
                        ),
                        child: Image(
                          image:AssetImage('assets/images/register.jpg'),
                          width:250.0,
                          height: 250.0,
                        ),
                      ),
                      SizedBox(
                        height:10.0,
                      ),
                      defaultFormField(
                          labeltext:'name',
                          prefixicon:Icons.person,
                          fillcolor:Colors.white,
                          filled:true,
                          borderradius:BorderRadius.circular(30.0),
                          borderside:BorderSide(width:2.0,color:Colors.indigo) ,
                          obscuretext:false,
                          keyboardtype:TextInputType.name,
                          controller:nameController,
                          onSubmit:(String?value){
                            if(formKey.currentState!.validate()){
                              RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                              );
                            }
                          },
                          validate:(String?value ){
                            if(value!.isEmpty){
                              return 'required';
                            }
                            return null;
                          }
                      ),
                      SizedBox(
                        height:20.0,
                      ),
                      defaultFormField(
                          labeltext:'Email Address',
                          prefixicon:Icons.email,
                          fillcolor:Colors.white,
                          filled:true,
                          borderradius:BorderRadius.circular(30.0),
                          borderside:BorderSide(width:2.0,color:Colors.indigo) ,
                          obscuretext:false,
                          keyboardtype:TextInputType.emailAddress,
                          controller:emailController,
                          onSubmit:(String?value){
                            if(formKey.currentState!.validate()){
                              RegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          validate:(String?value ){
                            if(value!.isEmpty){
                              return 'required';
                            }
                            return null;
                          }
                      ),
                      SizedBox(
                        height:20.0,
                      ),
                      defaultFormField(
                          labeltext:'Password',
                          prefixicon:Icons.lock_outline_rounded,
                          suffixicon:Icons.visibility_outlined,
                          suffixpressed:(){
                            RegisterCubit.get(context).changePasswordShow();
                          },
                          fillcolor:Colors.white,
                          filled:true,
                          borderradius:BorderRadius.circular(30.0),
                          borderside:BorderSide(width:2.0,color:Colors.indigo) ,
                          obscuretext:RegisterCubit.get(context).isPassword,
                          keyboardtype:TextInputType.visiblePassword,
                          controller:passwordController,
                          onSubmit:(String?value){
                            if(formKey.currentState!.validate()){
                              RegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          validate:(String?value ){
                            if(value!.isEmpty){
                              return 'required';
                            }
                            return null;
                          }
                      ),
                      SizedBox(
                        height:20,
                      ),
                      defaultFormField(
                          labeltext:'phone',
                          prefixicon:Icons.phone,
                          fillcolor:Colors.white,
                          filled:true,
                          borderradius:BorderRadius.circular(30.0),
                          borderside:BorderSide(width:2.0,color:Colors.indigo) ,
                          obscuretext:false,
                          keyboardtype:TextInputType.phone,
                          controller:phoneController,
                          onSubmit:(String?value){
                            if(formKey.currentState!.validate()){
                              RegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          validate:(String?value ){
                            if(value!.isEmpty){
                              return 'required';
                            }
                            return null;
                          }
                      ),
                      SizedBox(
                        height:20,
                      ),
                      ConditionalBuilder(
                        condition:state is !RegisterLoadingState,
                        builder:(context)=>defaultMaterialButton(
                          onpressed: () {
                            if(formKey.currentState!.validate()){
                              RegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          text:'register',
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
                        fallback:(context)=>Center(child: CircularProgressIndicator()),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}