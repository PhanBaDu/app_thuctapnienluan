import 'package:get/get.dart';
import 'package:get_lms_flutter/feature/search/controller/search_controller.dart';
import 'package:get_lms_flutter/feature/search/repository/search_repo.dart';

class SearchBinding extends Bindings{
  @override
  void dependencies() async {
    Get.lazyPut(() => SearchController(searchRepo: SearchRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
  }
}