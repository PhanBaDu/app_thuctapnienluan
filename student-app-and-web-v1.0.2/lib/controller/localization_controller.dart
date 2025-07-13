import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_lms_flutter/data/model/response/language_model.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/feature/home/home_screen.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationController extends GetxController implements GetxService {
  late SharedPreferences sharedPreferences;
  late ApiClient apiClient;

  LocalizationController({required this.sharedPreferences, required this.apiClient}) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(AppConstants.languages[0].languageCode!, AppConstants.languages[0].countryCode);
  bool _isLtr = true;
  List<LanguageModel> _languages = [];

  Locale get locale => _locale;
  bool get isLtr => _isLtr;
  List<LanguageModel> get languages => _languages;

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    if(_locale.languageCode == 'ar') {
      _isLtr = false;
    }else {
      _isLtr = true;
    }

    ///pick zone id to update header
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.token),
      locale.languageCode
    );
    saveLanguage(_locale);
    HomeScreen.loadData(true);

    update();
  }

  void loadCurrentLanguage() async {
    _locale = Locale(sharedPreferences.getString(AppConstants.languageCode) ?? AppConstants.languages[0].languageCode!,
        sharedPreferences.getString(AppConstants.currencyCode) ?? AppConstants.languages[0].countryCode);
    _isLtr = _locale.languageCode != 'ar';
    for(int index = 0; index<AppConstants.languages.length; index++) {
      if(AppConstants.languages[index].languageCode == _locale.languageCode) {
        _selectedIndex = index;
        break;
      }
    }
    _languages = [];
    _languages.addAll(AppConstants.languages);
    update();
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(AppConstants.languageCode, locale.languageCode);
    sharedPreferences.setString(AppConstants.currencyCode, locale.countryCode!);
  }

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void searchLanguage(String query) {
    if (query.isEmpty) {
      _languages  = [];
      _languages = AppConstants.languages;
    } else {
      _selectedIndex = -1;
      _languages = [];
      AppConstants.languages.forEach((language) async {
        if (language.languageName!.toLowerCase().contains(query.toLowerCase())) {
          _languages.add(language);
        }
      });
    }
    update();
  }
}