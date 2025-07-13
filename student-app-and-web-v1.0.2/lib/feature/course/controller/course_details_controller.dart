import 'package:get/get.dart';
import 'package:get_lms_flutter/data/provider/api_validator.dart';
import 'package:get_lms_flutter/feature/course/model/course_details_model.dart';
import 'package:get_lms_flutter/feature/course/model/course_model.dart';
import 'package:get_lms_flutter/feature/course/repository/course_details_repo.dart';

class CourseDetailsController extends GetxController{
  final CourseDetailsRepo serviceDetailsRepo;
  CourseDetailsController({required this.serviceDetailsRepo});

  CourseDetailsContent? _courseDetailsContent;
  bool? _isLoading;
  CourseDetailsContent? get courseDetailsContent => _courseDetailsContent;
  bool get isLoading => _isLoading!;


  ///discount and discount type based on category discount and course discount
  final double _serviceDiscount = 0.0;
  double get serviceDiscount => _serviceDiscount;

  String? _discountType;
  String get discountType => _discountType!;

  ///call course details data based on course id
  Future<void> getCourseDetails(String serviceID) async {
    Response response = await serviceDetailsRepo.getCourseDetails(serviceID);
    if (response.statusCode == 200) {
      _courseDetailsContent = CourseDetailsContent.fromJson(response.body['data']);
    } else {
      ApiValidator.validateApi(response);
    }
    _isLoading = false;
    update();
  }

}