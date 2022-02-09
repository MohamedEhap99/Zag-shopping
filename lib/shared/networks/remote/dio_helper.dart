import 'package:dio/dio.dart';

class DioHelper{
  static Dio?dio;

  static init(){
    dio=Dio(
        BaseOptions(
          baseUrl:'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError:true,
        ),
    );
  }
  static Future<Response> getData({
    required String url,
    Map<String,dynamic>?query,
    String lang='en',
    String?token,
  })async{
    dio!.options.headers={
      'lang':lang,
      'Content-Type':'application/json',
      'Authorization':token,
    };
    return await dio!.get(url,queryParameters:query);
  }

  static Future<Response>postData({
    required String url,
   required Map<String,dynamic> data,
    String lang='en',
    String?token,
})async{
    dio!.options.headers={
      'lang':lang,
      'Content-Type':'application/json',
      'Authorization':token,
    };
   return await dio!.post(url,data:data );
  }


  static Future<Response<dynamic>> updateData(
      {
        required String url,
        Map<String, dynamic>? query,
        String lang = 'en',
        String? token,
        required Map<String, dynamic> data
      }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization' : token,
    };
    return await dio!.put(
     url,
      data: data,
      queryParameters: query,
    );
  }


}