import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout_Screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/networks/local/cache_helper.dart';
import 'package:shop_app/shared/networks/remote/dio_helper.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget?widget;
   bool onBoarding=CacheHelper.getData(key:'onBoarding');
token=CacheHelper.getData(key: 'token');
print(token);
if(onBoarding!=null){
  if(token!=null) widget=ShopLayoutScreen();

 else widget=LoginScreen();
}
else widget=OnBoardingScreen();

  runApp(MyApp(onboarding:onBoarding,startwidget:widget));

}
class MyApp extends StatelessWidget {
  bool?onboarding;
  Widget?startwidget;
  MyApp({this.onboarding, required this.startwidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create:(context)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavorites()..getUserData(),
        ),
        BlocProvider(
            create:(context)=>SearchCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner:false ,
        home:startwidget,
      ),
    );
  }
}
