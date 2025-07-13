import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/data/provider/api_validator.dart';
import 'package:get_lms_flutter/feature/pages/model/pages_model.dart';
import 'package:get_lms_flutter/feature/pages/repository/html_repo.dart';

class HtmlViewController extends GetxController{
  final HtmlRepository htmlRepository;
  HtmlViewController({required this.htmlRepository});

  String ? _htmlPage;
  String? get htmlPage => _htmlPage;
  PagesContent? _pagesContent;
  PagesContent? get pagesContent => _pagesContent;


  Future<void> getPagesContent() async {
    printLog("inside_getPagesContent");
    Response response =await htmlRepository.getPagesContent();
    if(response.statusCode == 200){
      _pagesContent = PagesContent.fromJson(response.body['data']);
    }else{
      ApiValidator.validateApi(response);
    }
    update();
  }
}
