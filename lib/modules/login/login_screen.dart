import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout_Screen.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/networks/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener:(context,state){
            if(state is LoginSuccessStateState) {
              if (state.loginModel.status==true) {
                print(state.loginModel.status);
                print(state.loginModel.message);
                print(state.loginModel.data!.token);
                showToast(
                    text:'${state.loginModel.message}',
                    state: ToastStates.SUCCESS
                );
                CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value){
                  token='${state.loginModel.data!.token}';
                  navigateAndFinish(context, ShopLayoutScreen());
                });
             }
              else{
               print(state.loginModel.message);
               showToast(
                   text:'${state.loginModel.message}',
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
                            image:AssetImage('assets/images/login.jpg'),
                          width:250.0,
                          height: 250.0,
                        ),
                      ),
                      Text(
                        'LOGIN',
                        style:TextStyle(
                          fontSize:40.0,
                          fontWeight:FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height:10.0,
                      ),
                      Text(
                        'Login now to browse our hot offers',
                        style:TextStyle(
                          fontSize:15.0,
                          fontWeight: FontWeight.bold,
                          color:Colors.grey,
                        ),
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
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
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
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                          fillcolor:Colors.white,
                          filled:true,
                          borderradius:BorderRadius.circular(30.0),
                          borderside:BorderSide(width:2.0,color:Colors.indigo) ,
                          obscuretext:LoginCubit.get(context).isPassword,
                          keyboardtype:TextInputType.visiblePassword,
                          controller:passwordController,
                          onSubmit:(String?value){
                            if(formKey.currentState!.validate()){
                              LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
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
                          condition:state is !LoginLoadingState,
                          builder:(context)=>defaultMaterialButton(
                            onpressed: () {
                              if(formKey.currentState!.validate()){
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }

                            },
                            text:'login',
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
                      SizedBox(
                        height:20,
                      ),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                          ),
                          SizedBox(
                            width:5.0,
                          ),
                         TextButton(
                            onPressed: () {
                              navigateTo(context, RegisterScreen());
                            },
                            child: Text(
                              'REGISTER',
                            ),
                          ),
                        ],
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