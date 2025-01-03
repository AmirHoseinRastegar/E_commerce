import 'package:shared_preferences/shared_preferences.dart';



class SharedPreferencesHelper {
  late SharedPreferences prefs;
  static Future<bool> getOnboarding()async{
    final prefs= await SharedPreferences.getInstance();
    final onboarding= prefs.getBool('onboarding')?? false;
    return onboarding;

  }
  static Future<void> setOnboarding(bool onboarding)async{
    final prefs= await SharedPreferences.getInstance();
    prefs.setBool('onboarding', onboarding);
  }

}