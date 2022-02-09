import 'package:shop_app/modles/login_model.dart';

abstract class LoginStates{}

class InitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessStateState extends LoginStates{
 late final LoginModel loginModel;
  LoginSuccessStateState(this.loginModel);
}

class LoginErrorState extends LoginStates{}

class ChangePasswordVisibilityState extends LoginStates{}