import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/data/model/response/language_model.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';

class LanguageController extends GetxController {
  int _selectIndex = 0;
  int get selectIndex => _selectIndex;

  void setSelectIndex(int index) {
    _selectIndex = index;
    update();
  }

  List<LanguageModel> _languages = [];
  List<LanguageModel> get languages => _languages;

  void searchLanguage(String query, BuildContext context) {
    if (query.isEmpty) {
      _languages.clear();
      _languages = AppConstants.languages;
      update();
    } else {
      _selectIndex = -1;
      _languages = [];
      AppConstants.languages.forEach((product) async {
        if (product.languageName!.toLowerCase().contains(query.toLowerCase())) {
          _languages.add(product);
        }
      });
      update();
    }
  }

  void initializeAllLanguages(BuildContext context) {
    if (_languages.length == 0) {
      _languages.clear();
      _languages = AppConstants.languages;
    }
  }
}
