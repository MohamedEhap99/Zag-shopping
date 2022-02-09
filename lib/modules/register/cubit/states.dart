import 'package:shop_app/modles/login_model.dart';

abstract class RegisterStates{}

class initialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessStateState extends RegisterStates{
 late final LoginModel registerModel;
  RegisterSuccessStateState(this.registerModel);
}

class RegisterErrorState extends RegisterStates{}

class ChangePasswordShowState extends RegisterStates{}