import 'package:get/get.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;
  ThemeController({required this.sharedPreferences}) {
    _initialTheme();
  }


  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    sharedPreferences.setBool(AppConstants.theme, _darkTheme);
    update();
  }

  void _initialTheme() async {
    _darkTheme = sharedPreferences.getBool(AppConstants.theme) ?? false;
    update();
  }
}
