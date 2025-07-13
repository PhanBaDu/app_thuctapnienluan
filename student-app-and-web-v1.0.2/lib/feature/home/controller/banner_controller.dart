import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/data/provider/api_validator.dart';
import 'package:get_lms_flutter/feature/category/controller/category_controller.dart';
import 'package:get_lms_flutter/feature/home/model/banner_model.dart';
import 'package:get_lms_flutter/feature/home/repository/banner_repo.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerController extends GetxController implements GetxService {
  final BannerRepo bannerRepo;
  BannerController({required this.bannerRepo});

  List<BannerModel>? _banners;
  List<BannerModel>? get banners => _banners;

  int? _currentIndex = 0;
  int? get currentIndex => _currentIndex;

  Future<void> getBannerList(bool reload) async {
    printLog("inside_get_banner_list");

    if(_banners == null || reload){
      Response response = await bannerRepo.getBannerList();
      if (response.statusCode == 200) {
        _banners = [];
        response.body['data']['data'].forEach((banner){
          _banners!.add(BannerModel.fromJson(banner));
        });
      } else {
        ApiValidator.validateApi(response);
      }
      update();
    }
  }

  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if(notify) {
      update();
    }
  }

  /// if resource type is category then show list of sub-category and if resource type is link then lunch link out of device
  Future<void> navigateFromBanner(String resourceType, String bannerID, String link, String resourceID, {String categoryName = ''})async {
    printLog("link:$link");
    switch (resourceType){
      case 'category_wise':
        Get.find<CategoryController>().getSubCategoryList(bannerID, 0); //banner id is category here
        Get.toNamed(RouteHelper.subCategoryScreenRoute(categoryName));
        break;

      case 'redirect_link':
        final uri = Uri.parse(link);
        if (await canLaunchUrl(uri)) {
         await launchUrl(Uri.parse(link));
        }
        break;
      case 'course_wise':
        Get.toNamed(RouteHelper.getCourseDetailsRoute(resourceID));
        break;
      default:
        printLog("resource type is not implemented:$resourceType");
    }
  }
}
