import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';

class CategoryRepo {
  final ApiClient apiClient;
  CategoryRepo({required this.apiClient});

  Future<Response> getCategoryList(int offset) async {
    return await apiClient.getData(AppConstants.categoryUri);
  }

  Future<Response> getSubCategoryList(String parentID) async {
    return await apiClient.getData('${AppConstants.subCategoryUrl}$parentID');
  }



  Future<Response> getSearchData(String query, String categoryID, String type) async {
    return await apiClient.getData(
      '${AppConstants.searchUrl}services/search?name=$query&category_id=$categoryID&type=$type&offset=1&limit=50',
    );
  }
}