import 'package:shop_app/modles/change_favorites_model.dart';
import 'package:shop_app/modles/login_model.dart';

abstract class ShopStates{}

class InitialState extends ShopStates{}

class ChangePasswordVisibilityState extends ShopStates{}

class ChangeFloatingButtonState extends ShopStates{}

class ChangeBottomSheetState extends ShopStates{}

class ChangeBottomNavBarState extends ShopStates{}

class GetHomeDataLoadingState extends ShopStates{}

class GetHomeDataSuccessState extends ShopStates{}

class GetHomeDataErrorState extends ShopStates{}

class GetCategoriesDataLoadingState extends ShopStates{}

class GetCategoriesDataSuccessState extends ShopStates{}

class GetCategoriesDataErrorState extends ShopStates{}

class ChangeFavoritesState extends ShopStates{}

class ChangeFavoritesSuccessState extends ShopStates{
   final ChangeFavoritesModel?model;
  ChangeFavoritesSuccessState(this.model);
}

class ChangeFavoritesErrorState extends ShopStates{}

class GetFavoritesLoadingState extends ShopStates{}

class GetFavoritesSuccessState extends ShopStates{}

class GetFavoritesErrorState extends ShopStates{}

class UserDataLoadingState extends ShopStates{}

class UserDataSuccessState extends ShopStates{
  final LoginModel?userModel;

  UserDataSuccessState(this.userModel);
}

class UserDataErrorState extends ShopStates{}

class UpdateUserLoadingState extends ShopStates{}

class UpdateUserSuccessState extends ShopStates{
  final LoginModel?userModel;

  UpdateUserSuccessState(this.userModel);
}

class UpdateUserErrorState extends ShopStates{}



