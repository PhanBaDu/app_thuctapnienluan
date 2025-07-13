import 'package:get/get.dart';
import 'package:get_lms_flutter/feature/courseResources/model/course_resource_model.dart';
import 'package:get_lms_flutter/feature/courseResources/repo/course_resource_repo.dart';


class CourseResourceController extends GetxController implements GetxService {
  final CourseResourceRepo courseResourceRepo;
  CourseResourceController({required this.courseResourceRepo});

  bool _isLoading = false;
  CourseResource? _courseResource;

  bool get isLoading => _isLoading;
  CourseResource? get coupon => _courseResource;

  List<CourseResource>? _courseResourceList;
  List<CourseResource>? get courseResourceList => _courseResourceList;


  @override
  void onInit() {
    super.onInit();
  }



  Future<void> getCourseResourceList(String courseID) async {
    _isLoading = true;
    final response = await courseResourceRepo.getCourseResourceList(courseID: courseID);
    if (response.statusCode == 200) {
      _courseResourceList = CourseResourceModel.fromJson(response.body).courseResourceContent!.courseResources;
    }
    _isLoading = false;
    update();
  }
  

}
