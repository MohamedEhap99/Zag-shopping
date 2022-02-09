import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modles/login_model.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/networks/end_points/end_points.dart';
import 'package:shop_app/shared/networks/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>{

  RegisterCubit():super(initialState());
  static RegisterCubit get(context)=>BlocProvider.of(context);

   late LoginModel loginModel;
  userRegister({
    required String name,
   required String email,
   required String password,
   required String phone,
}){
    emit(RegisterLoadingState());
    DioHelper.postData(
        url:REGISTER,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        }
        ).then((value){
          loginModel=LoginModel.fromJson(value.data);
emit(RegisterSuccessStateState(loginModel));
    }).catchError((error){
      emit(RegisterErrorState());
    });
  }
   IconData suffixIcon=Icons.visibility_outlined;
  bool isPassword=true;
  changePasswordShow(){
    isPassword=!isPassword;
    suffixIcon=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ChangePasswordShowState());
  }


}