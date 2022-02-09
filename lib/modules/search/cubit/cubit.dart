
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modles/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/networks/end_points/end_points.dart';
import 'package:shop_app/shared/networks/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(InitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);
SearchModel?searchModel;


search({
    required String text,
}){
     emit(SearchLoadingState());
     DioHelper.postData(
        url: PRODUCTS_SEARCH,
        token:token,
        data: {
          'text':text,
        }
    ).then((value){
       searchModel=SearchModel.fromJson(value.data);
emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
emit(SearchErrorState());
    });
  }

}