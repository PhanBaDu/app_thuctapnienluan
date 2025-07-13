import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';

class BannerRepo {
  final ApiClient apiClient;
  BannerRepo({required this.apiClient});

  Future<Response> getBannerList() async {
    return await apiClient.getData(AppConstants.bannerUrl);
  }

}