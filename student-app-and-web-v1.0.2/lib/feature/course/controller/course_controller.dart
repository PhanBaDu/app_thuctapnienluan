import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/data/provider/api_validator.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/campaign/model/service_types.dart';
import 'package:get_lms_flutter/feature/cart/controller/cart_controller.dart';
import 'package:get_lms_flutter/feature/category/controller/category_controller.dart';
import 'package:get_lms_flutter/feature/course/model/course_model.dart';
import 'package:get_lms_flutter/feature/course/repository/course_repo.dart';
import 'package:get_lms_flutter/feature/notification/controller/notification_controller.dart';
import 'package:get_lms_flutter/feature/profile/controller/user_controller.dart';

class CourseController extends GetxController implements GetxService {
  final CourseRepo serviceRepo;
  CourseController({required this.serviceRepo});


  CourseContent? _courseContent;
  CourseContent? _offerBasedServiceContent;
  List<Course>? _popularCourseList;
  List<Course>? _instructorCourseList;
  List<Course>? _recommendedServiceList;
  List<Course>? _subCategoryBasedServiceList;
  List<Course>? _campaignBasedServiceList = [];
  List<Course>? _offerBasedServiceList;
  List<Course>? _allCourse;
  List<Course>? get allService => _allCourse ;

  List<Course>? _categoryBasedAllCourse;
  List<Course>? get categoryBasedAllCourse => _categoryBasedAllCourse ;


  bool _isLoading = false;
  List<int>? _variationIndex;
  int? _quantity = 1;
  List<bool>? _addOnActiveList = [];
  List<int>? _addOnQtyList = [];
  int _cartIndex = -1;

  CourseContent? get serviceContent => _courseContent;
  CourseContent? get offerBasedServiceContent => _offerBasedServiceContent;
  List<Course>? get popularCourseList => _popularCourseList;
  List<Course>? get instructorCourseList => _instructorCourseList;
  List<Course>? get recommendedServiceList => _recommendedServiceList;
  List<Course>? get subCategoryBasedServiceList => _subCategoryBasedServiceList;
  List<Course>? get campaignBasedServiceList => _campaignBasedServiceList;
  List<Course>? get offerBasedServiceList => _offerBasedServiceList;

  bool get isLoading => _isLoading;
  List<int>? get variationIndex => _variationIndex;
  int? get quantity => _quantity;
  List<bool>? get addOnActiveList => _addOnActiveList;
  List<int>? get addOnQtyList => _addOnQtyList;
  int get cartIndex => _cartIndex;

  double? _serviceDiscount = 0.0;
  double get serviceDiscount => _serviceDiscount!;

  String? _discountType;
  String get discountType => _discountType!;

  String? _fromPage;
  String? get fromPage => _fromPage!;

  List<double> _lowestPriceList = [];
  List<double> get lowestPriceList => _lowestPriceList;


  @override
  Future<void> onInit() async {
    super.onInit();
    if(Get.find<AuthController>().isLoggedIn()) {
     await Get.find<UserController>().getUserInfo();
     // await Get.find<NotificationController>().getNotifications(1);
     await Get.find<CartController>().getCartData();
     // await Get.find<CartController>().addMultipleCartToServer();
     await Get.find<CartController>().getCartListFromServer();
    }
  }



  Future<void> getAllCourseList(int offset, bool reload) async {
    if(reload){
      _allCourse = null;
      update();
    }
    Response response = await serviceRepo.getAllCourseList(offset);
    printLog("after_response");
    if (response.statusCode == 200) {
      printLog(response.statusCode);
      if(reload){
        _allCourse = [];
      }
        _courseContent = CourseModel.fromJson(response.body).content;
        if(_allCourse != null && offset != 1){
          _allCourse!.addAll(CourseModel.fromJson(response.body).content!.serviceList!);
        }else{
          _allCourse = [];
          _allCourse!.addAll(CourseModel.fromJson(response.body).content!.serviceList!);
        }
        update();
    } else {
      ApiValidator.validateApi(response);
    }
  }

  Future<void> getCategoryBasedCourses(int offset, bool reload, String categoryID) async {
    if(reload){
      _categoryBasedAllCourse = null;
      update();
    }
    Response response = await serviceRepo.getCoursesBasedOnCategory(categoryID: categoryID, offset:offset);
    if (response.statusCode == 200) {
      printLog(response.statusCode);
      if(reload){
        _categoryBasedAllCourse = [];
      }
        _courseContent = CourseModel.fromJson(response.body).content;
        if(_categoryBasedAllCourse != null && offset != 1){
          _categoryBasedAllCourse!.addAll(CourseModel.fromJson(response.body).content!.serviceList!);
        }else{
          _categoryBasedAllCourse = [];
          _categoryBasedAllCourse!.addAll(CourseModel.fromJson(response.body).content!.serviceList!);
        }
        update();
    } else {
      ApiValidator.validateApi(response);
    }
  }


  Future<void> getPopularServiceList(bool reload, {required int offset}) async {
    if(_popularCourseList == null || reload){
      Response response = await serviceRepo.getPopularServiceList(offset);
      printLog(response.body);
      if (response.statusCode == 200) {
        _popularCourseList = [];
        _popularCourseList!.addAll(CourseModel.fromJson(response.body).content!.serviceList!);
        printLog("_popularCourseList:${_popularCourseList!.length}");
        _isLoading = false;
      } else {
        ApiValidator.validateApi(response);
      }
      update();
    }
  }


  Future<void> getInstructorBasedCourseList(int offset, bool reload, String instructorID) async {
    if(_instructorCourseList == null || reload){
      Response response = await serviceRepo.getInstructorBasedCourseList(offset,instructorID);
      if (response.statusCode == 200) {
        _instructorCourseList = [];
        _instructorCourseList!.addAll(CourseModel.fromJson(response.body).content!.serviceList!);
        printLog("_instructorCourseList:${_instructorCourseList!.length}");
        _isLoading = false;
      } else {
        ApiValidator.validateApi(response);
      }
      update();
    }
  }


   cleanSubCategory(){
    _subCategoryBasedServiceList = null;
    update();
  }

  Future<void> getSubCategoryBasedServiceList(String subCategoryID, bool isWithPagination, {bool isShouldUpdate = true}) async {
    Response response = await serviceRepo.getServiceListBasedOnSubCategory(subCategoryID: subCategoryID,offset: 1);
    if (response.statusCode == 200) {
      if(!isWithPagination){
        _subCategoryBasedServiceList = [];
      }
      _subCategoryBasedServiceList!.addAll(CourseModel.fromJson(response.body).content!.serviceList!);
    } else {
      ApiValidator.validateApi(response);
    }
    if(isShouldUpdate){
      update();
    }
  }


  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  int setExistInCart(Course service, {bool notify = true}) {
    List<String> _variationList = [];

    String variationType = '';
    bool isFirst = true;
    _variationList.forEach((variation) {
      if (isFirst) {
        variationType = '$variationType$variation';
        isFirst = false;
      } else {
        variationType = '$variationType-$variation';
      }
    });
    if(_cartIndex != -1) {
      _quantity = Get.find<CartController>().cartList[_cartIndex].quantity;
      _addOnActiveList = [];
      _addOnQtyList = [];

    }
    return _cartIndex;
  }

  void setAddOnQuantity(bool isIncrement, int index) {
    if (isIncrement) {
      _addOnQtyList![index] = _addOnQtyList![index] + 1;
    } else {
      _addOnQtyList![index] = _addOnQtyList![index] - 1;
    }
    update();
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = _quantity! + 1;
    } else {
      _quantity = _quantity! - 1;
    }
    update();
  }

  void setCartVariationIndex(int index, int i,Course product) {
    _variationIndex![index] = i;
    _quantity = 1;
    setExistInCart(product);
    update();
  }

  void addAddOn(bool isAdd, int index) {
    _addOnActiveList![index] = isAdd;
    update();
  }


  Future<void> getServiceDiscount(Course service) async {
    // if(service.campaignDiscount != null){
    //   _serviceDiscount = service.campaignDiscount!.length > 0 ?  service.campaignDiscount!.elementAt(0).discount!.discountAmount!.toDouble(): 0.0;
    //   _discountType = service.campaignDiscount!.length > 0 ?  service.campaignDiscount!.elementAt(0).discount!.discountType!:'amount';
    // }else if(service.category!.campaignDiscount != null){
    //   _serviceDiscount = service.category!.campaignDiscount!.length > 0 ?  service.category!.campaignDiscount!.elementAt(0).discount!.discountAmount!.toDouble(): 0.0;
    //   _discountType = service.category!.campaignDiscount!.length > 0 ?  service.category!.campaignDiscount!.elementAt(0).discount!.discountAmountType! :'amount';
    // }else if(service.serviceDiscount != null){
    //   _serviceDiscount = service.serviceDiscount!.length > 0 ?  service.serviceDiscount!.elementAt(0).discount!.discountAmount!.toDouble(): 0.0;
    //   _discountType = service.serviceDiscount!.length > 0 ?  service.serviceDiscount!.elementAt(0).discount!.discountType!:'amount';
    // } else{
    //   _serviceDiscount = service.category!.categoryDiscount!.length > 0 ?  service.category!.categoryDiscount!.elementAt(0).discount!.discountAmount!.toDouble(): 0.0;
    //   _discountType = service.category!.categoryDiscount!.length > 0 ?  service.category!.categoryDiscount!.elementAt(0).discount!.discountAmountType! :'amount';
    // }
    // update();
  }



}
