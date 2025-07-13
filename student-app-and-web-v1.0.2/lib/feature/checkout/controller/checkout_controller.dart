import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/data/provider/api_validator.dart';
import 'package:get_lms_flutter/feature/checkout/repository/checkout_repository.dart';
import 'package:get_lms_flutter/feature/profile/controller/user_controller.dart';

enum PageState {orderDetails, payment, complete}

class CheckOutController extends GetxController{

  final CheckoutRepository checkoutRepository;
  CheckOutController({required this.checkoutRepository});
  PageState currentPage = PageState.payment;
  int? _enrolmentID ;
  int get enrolmentId => _enrolmentID!;

  bool showCoupon = false;
  bool cancelPayment = false;

  String selectedPaymentMethod = '';

  @override
  void onInit() {
    Get.find<UserController>().getUserInfo();
    super.onInit();
  }

  void updateSelectedPaymentMethod(String paymentMethod){
    selectedPaymentMethod = paymentMethod;
    update();
  }


  void cancelPaymentOption(){
    cancelPayment = true;
    update();
  }

  Future<int?> getEnrolmentID()async{
    printLog("inside_getEnrolmentID");
    // _enrolmentID = 0;
    Response response = await checkoutRepository.addToEnrolmentID(null);
    printLog(response.body);

    if(response.statusCode == 200){
      _enrolmentID = response.body['data']['id'];
    } else{
      ApiValidator.validateApi(response);
    }
    update();
    printLog(_enrolmentID);
    return _enrolmentID;
  }





}