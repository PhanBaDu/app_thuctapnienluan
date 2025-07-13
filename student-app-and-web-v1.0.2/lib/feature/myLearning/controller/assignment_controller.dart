import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_snackbar.dart';
import 'package:get_lms_flutter/feature/myLearning/model/assignment_model.dart';
import 'package:get_lms_flutter/feature/myLearning/repo/my_learning_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';



class AssignmentController extends GetxController implements GetxService {
  final MyLearningRepo myLearningRepo;
  AssignmentController({required this.myLearningRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<Assignment>? _assignmentList;
  List<Assignment>? get assignmentList => _assignmentList;
  
  XFile? _assignmentFile ;
  XFile? get assignmentFile => _assignmentFile;


  void pickAssignmentFile() async {
    final ImagePicker _picker = ImagePicker();
    _assignmentFile = await _picker.pickImage(source: ImageSource.gallery);
    printLog(_assignmentFile!.path);
    update();
  }


  Future<void> removeAssignmentFile() async {
    _assignmentFile = null;
    update();
  }

  Future<void> getAssignmentList(int offset,int courseID) async {
    _isLoading = true;
    update();
    final response = await myLearningRepo.getAssignmentList(courseID: courseID, offset: offset);
    if (response.statusCode == 200) {
      _assignmentList = AssignmentModel.fromJson(response.body).assignmentContent!.assignment;
    }
    _isLoading = false;
    update();
  }


  Future<void> submitAssignment(String assignmentID) async {
    update();
    Response response = await myLearningRepo.submitAssignment(assignmentID, assignmentFile);
    printLog(response.body);
    if (response.body['status'] == 'success') {
      Get.back();
      customSnackBar('${response.body['message']}', isError: false);
    }else{
      customSnackBar('${response.body['response_code']}'.tr, isError: false);
    }
  }
  
  
}
