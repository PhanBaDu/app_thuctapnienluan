import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';

enum BnbItem {home, categories, myCourse, profile}
class BottomNavController extends GetxController {
  static BottomNavController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  var currentPage = BnbItem.home.obs;
  void changePage(int index) {
    printLog("name:${BnbItem.values.elementAt(index).name}");
    currentPage.value = BnbItem.values.elementAt(index);
    update();
  }

}
