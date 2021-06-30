import 'package:shared_preferences/shared_preferences.dart';
import 'constant.dart';

class SharedPreferencesProcessing {

  getSharedPrefInstance () async {
    return  await SharedPreferences.getInstance();
  }
  setPrefIsLogin (bool isLoginParameter) async {
    SharedPreferences pref = await getSharedPrefInstance();
    pref.setBool(isLogin, isLoginParameter);
  }
  getPrefIsLogin() async{
    SharedPreferences pref = await getSharedPrefInstance();
    pref.getBool(isLogin);
  }
}