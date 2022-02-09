import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modles/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/networks/end_points/end_points.dart';
import 'package:shop_app/shared/networks/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit():super(InitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);

   late LoginModel loginModel;
  userLogin({
   required String email,
   required String password,
}){
    emit(LoginLoadingState());
    DioHelper.postData(
        url:LOGIN,
        data: {
          'email':email,
          'password':password,
        }
        ).then((value){
          loginModel=LoginModel.fromJson(value.data);
emit(LoginSuccessStateState(loginModel));
    }).catchError((error){
      emit(LoginErrorState());
    });
  }
   IconData suffixIcon=Icons.visibility_outlined;
  bool isPassword=true;
  changePasswordVisibility(){
    isPassword=!isPassword;
    suffixIcon=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }


}