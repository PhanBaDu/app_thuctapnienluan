import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/data/provider/api_validator.dart';
import 'package:get_lms_flutter/feature/category/model/category_model.dart';
import 'package:get_lms_flutter/feature/category/repository/category_repo.dart';
import 'package:get_lms_flutter/feature/course/model/course_model.dart';

class CategoryController extends GetxController implements GetxService {
  final CategoryRepo categoryRepo;
  CategoryController({required this.categoryRepo});

  List<CategoryModel>? _categoryList;
  List<CategoryModel>? _subCategoryList;
  List<Course>? _searchProductList = [];
  List<CategoryModel>? _campaignBasedCategoryList ;

  bool _isLoading = false;
  int? _pageSize;
  bool? _isSearching = false;
  int _subCategoryIndex = 0;
  String? _type = 'all';
  String? _searchText = '';
  int? _offset = 1;

  List<CategoryModel>? get categoryList => _categoryList;
  List<CategoryModel>? get campaignBasedCategoryList => _campaignBasedCategoryList;
  List<CategoryModel>? get subCategoryList => _subCategoryList;
  List<Course>? get searchServiceList => _searchProductList;
  bool get isLoading => _isLoading;
  int? get pageSize => _pageSize;
  bool? get isSearching => _isSearching;
  int? get subCategoryIndex => _subCategoryIndex;
  String? get type => _type;
  String? get searchText => _searchText;
  int? get offset => _offset;


  final ScrollController scrollController = ScrollController();

  @override
  void onInit(){
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        int pageSize = Get.find<CategoryController>().pageSize!;
        if (Get.find<CategoryController>().offset! < pageSize) {
          Get.find<CategoryController>().showBottomLoader();
          getCategoryList(Get.find<CategoryController>().offset!+1, false);
        }
      }
    });
  }

  Future<void> getCategoryList(int offset, bool reload ) async {
    printLog("inside_get_category_list");
    _offset = offset;
    if(_categoryList == null || reload){
      Response response = await categoryRepo.getCategoryList(offset);
      if (response.statusCode == 200) {
        _categoryList = [];
        response.body['data']['data'].forEach((category) {
          _categoryList!.add(CategoryModel.fromJson(category));
        });
        _pageSize = 2;
        _pageSize = response.body['data']['last_page'];
      } else {
        ApiValidator.validateApi(response);
      }
      _isLoading = false;
      update();
    }
  }


  Future<void> getSubCategoryList(String categoryID, int subCategoryIndex,) async {
    _subCategoryIndex = subCategoryIndex;
    _subCategoryList = null;
    update();
    Response response = await categoryRepo.getSubCategoryList(categoryID);
    if (response.statusCode == 200) {
      _subCategoryList= [];
      response.body['data']['data'].forEach((category) => _subCategoryList!.addIf(CategoryModel.fromJson(category).isActive , CategoryModel.fromJson(category)));
    } else {
      ApiValidator.validateApi(response);
    }
    update();
  }


  void toggleSearch() {
    _isSearching = !_isSearching!;
    _searchProductList = [];
    update();
  }
  void showBottomLoader() {
    _isLoading = true;
    update();
  }

}
