import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences?prefernces;
 static init()async{
   prefernces=await SharedPreferences.getInstance();
  }

static Future<bool>saveData({
    required String key,
    required dynamic value,
})async{
 if(value is String) return await prefernces!.setString(key, value);
 if(value is int) return await prefernces!.setInt(key, value);
 if(value is bool) return await prefernces!.setBool(key, value);
 return await prefernces!.setDouble(key, value);
  }

 static dynamic getData({
    required String key,
}){
  return  prefernces!.get(key);
  }

  static Future<bool>removeData({
    required String key,
})async{
  return await prefernces!.remove(key);
  }
}