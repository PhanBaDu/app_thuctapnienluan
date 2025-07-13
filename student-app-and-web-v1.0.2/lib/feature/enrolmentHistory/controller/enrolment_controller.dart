import 'package:get/get.dart';
import 'package:get_lms_flutter/feature/enrolmentHistory/model/enrolment_details_model.dart';
import 'package:get_lms_flutter/feature/enrolmentHistory/model/enrolment_model.dart';
import 'package:get_lms_flutter/feature/enrolmentHistory/repo/enrolment_repo.dart';


class EnrolmentController extends GetxController implements GetxService {
  final EnrolmentRepo enrolmentRepo;
  EnrolmentController({required this.enrolmentRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<Enrolment>? _enrolmentList = [];
  List<Enrolment>? get enrolmentList => _enrolmentList;

  EnrolmentDetails? _enrolmentDetails;
  EnrolmentDetails? get enrolmentDetails => _enrolmentDetails;


  Future<void> getEnrolmentList(int offset) async {
    _isLoading = true;
    final response = await enrolmentRepo.getEnrolmentList(offset: offset);
    if (response.statusCode == 200) {
      _enrolmentList = EnrolmentModel.fromJson(response.body).enrolmentContent!.enrolment;
    }
    _isLoading = false;
    update();
  }


  Future<void> getEnrolmentDetails(int id) async {
    _isLoading = true;
    final response = await enrolmentRepo.getEnrolmentDetails(id: id);
    if (response.statusCode == 200) {
      _enrolmentDetails = EnrolmentDetails.fromJson(response.body['data']);
    }
    _isLoading = false;
    update();
  }


}
