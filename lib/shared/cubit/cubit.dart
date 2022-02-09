import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modles/categories_model.dart';
import 'package:shop_app/modles/change_favorites_model.dart';
import 'package:shop_app/modles/home_model.dart';
import 'package:shop_app/modles/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modles/favorites_model.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/networks/end_points/end_points.dart';
import 'package:shop_app/shared/networks/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(InitialState());
  static ShopCubit get(context)=>BlocProvider.of(context);
  int bottomNavBarCurrentIndex=0;
  List<Widget>screen=[
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
  ];
  changeBottomNavBar(int index){
    bottomNavBarCurrentIndex=index;
    emit(ChangeBottomNavBarState());
  }

  IconData fabIcon=Icons.shopping_cart_sharp;
  void changeFabIcon(IconData fabIcon){
    this.fabIcon=fabIcon;
    emit(ChangeFloatingButtonState());
  }

  bool isBottomSheetShown=false;
  void changeBottomSheetShown(bool isShown){
    isBottomSheetShown=isShown;
    emit(ChangeBottomSheetState());
  }
  IconData suffixIcon=Icons.visibility_outlined;
  bool isPassword=true;
  changePasswordVisibility(){
    isPassword=!isPassword;
    suffixIcon=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }


  HomeModel?homeModel;
  Map<dynamic,dynamic> favorites={};
 void getHomeData()async{
    emit(GetHomeDataLoadingState());
  await  DioHelper.getData(
        url:HOME,
      token:token,
    ).then((value){
      homeModel=HomeModel.fromJson(value.data);
homeModel!.data!.products!.forEach((element) {
  favorites .addAll({element.id:element.inFavorites,});
});
print(favorites.toString());
      emit(GetHomeDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetHomeDataErrorState());
    });
  }

  CategoriesModel?categoriesModel;

  getCategoriesData()async{
    emit(GetCategoriesDataLoadingState());
  await  DioHelper.getData(
      url:GET_CATEGORIES,
      token:token,
    ).then((value){
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(GetCategoriesDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetCategoriesDataErrorState());
    });
  }

 late ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int ?productId ){
    favorites[productId]=!favorites[productId];
 emit(ChangeFavoritesState());
DioHelper.postData(
    url: FAVORITES,
    data:{
      'product_id':productId,
    },
token:token,
).then((value){
  changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
  print(value.data);
  if(changeFavoritesModel.status==false){
    favorites[productId]=!favorites[productId];
  }
  else{
    getFavorites();
  }
emit(ChangeFavoritesSuccessState(changeFavoritesModel));
}).catchError((error){
  favorites[productId]=!favorites[productId];
  print(error.toString());
emit(ChangeFavoritesErrorState());
});
  }

  FavoritesModel?favoritesModel;

  getFavorites()async{
    emit(GetFavoritesLoadingState());
 await  DioHelper.getData(
        url:FAVORITES,
      token:token,
    ).then((value){
      favoritesModel=FavoritesModel.fromJson(value.data);
      emit(GetFavoritesSuccessState());
    }).catchError((error){
      emit(GetFavoritesErrorState());
    });
  }

  LoginModel?userModel;

   getUserData(){
    emit(UserDataLoadingState());
    DioHelper.getData(
      url:PROFILE,
      token:token,
    ).then((value){
      userModel=LoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(UserDataSuccessState(userModel));
    }).catchError((error){
      emit(UserDataErrorState());
    });
  }


  void updateUserData({
  required String name,
  required String email,
  required String phone,
}){
    emit(UpdateUserLoadingState());
    DioHelper.updateData(
      url:UPDATE_PROFILE,
      token:token,
      data: {
         'name':name,
        'email':email,
        'phone':phone,
    },
    ).then((value){
      userModel=LoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(UpdateUserSuccessState(userModel));
    }).catchError((error){
      emit(UpdateUserErrorState());
    });
  }



}