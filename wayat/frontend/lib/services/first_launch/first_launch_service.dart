import 'package:shared_preferences/shared_preferences.dart';

class FirstLaunchService {
  Future<bool> isFirstLaunch() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    bool? firstLaunch = preferences.getBool("firstLaunch");

    bool result = firstLaunch == null;

    //preferences.setBool("firstLaunch", false);

    return result;
  }

  void setFinishedOnBoarding() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setBool("firstLaunch", false);
  }
}
