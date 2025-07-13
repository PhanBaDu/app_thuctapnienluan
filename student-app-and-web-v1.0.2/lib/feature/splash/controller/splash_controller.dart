import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/data/model/response/config_model.dart';
import 'package:get_lms_flutter/data/provider/api_validator.dart';
import 'package:get_lms_flutter/data/provider/client_api.dart';
import 'package:get_lms_flutter/feature/splash/repository/splash_repo.dart';

class SplashController extends GetxController implements GetxService {
  final SplashRepo splashRepo;
  SplashController({required this.splashRepo});

  ConfigContent? _configModel = ConfigContent();
  bool _firstTimeConnectionCheck = true;
  bool _hasConnection = true;

  ConfigContent get configModel => _configModel!;
  DateTime get currentTime => DateTime.now();
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;
  bool get hasConnection => _hasConnection;

  Future<bool> getConfigData() async {
    printLog("inside_get_config_model");
    _hasConnection = true;
    Response response = await splashRepo.getConfigData();
    bool _isSuccess = false;
    if(response.statusCode == 200) {
      _configModel = ConfigContent.fromJson(response.body);

      _isSuccess = true;
    }else {
      ApiValidator.validateApi(response);
      if(response.statusText == ApiClient.noInternetMessage) {
        // _hasConnection = false;
      }
      _isSuccess = false;
    }
    update();
    return _isSuccess;
  }

  Future<bool> initSharedData() {
    return splashRepo.initSharedData();
  }

  Future<bool> saveSplashSeenValue(bool value) async {
    return await splashRepo.setSplashSeen(value);
  }


  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

  bool isSplashSeen() =>  splashRepo.isSplashSeen();


}
