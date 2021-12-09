import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{

  static late SharedPreferences sharedPreferences ;
  static Future<void> init()async{
    sharedPreferences =await SharedPreferences.getInstance();
  }

  static Future<bool> putData ({required bool isDark})async{
    return await sharedPreferences.setBool('isDark', isDark);
  }

  static bool? getData (){
    return sharedPreferences.getBool('isDark');
  }

}
