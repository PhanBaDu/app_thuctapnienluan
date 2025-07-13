import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:http/http.dart' as Http;

class HtmlRepository{
  final ApiClient apiClient;
  HtmlRepository({required this.apiClient});

  Future<Response> getHtmlData(String url) async {
    Http.Response response = await Http.get(Uri.parse(url));
    printLog("url:$url");

    Response value = await apiClient.getData(url);
    printLog("res:${value.body}");
    return value;
  }

  Future<Response> getPagesContent() async {
    return await apiClient.getData(AppConstants.pages);
  }

}