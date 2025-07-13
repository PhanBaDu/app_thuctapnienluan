import 'package:get/get.dart';
import 'package:get_lms_flutter/feature/coupon/model/coupon_model.dart';
import 'package:get_lms_flutter/feature/meetings/model/meeting_model.dart';
import 'package:get_lms_flutter/feature/meetings/repo/meeting_repo.dart';


class MeetingController extends GetxController implements GetxService {
  final MeetingRepo meetingRepo;
  MeetingController({required this.meetingRepo});

  bool _isLoading = false;
  Meeting? _coupon;

  bool get isLoading => _isLoading;
  Meeting? get coupon => _coupon;

  List<Meeting>? _meetingList;
  List<Meeting>? get meetingList => _meetingList;


  @override
  void onInit() {
    super.onInit();
  }



  Future<void> getMeetingList(int offset) async {
    _isLoading = true;
    final response = await meetingRepo.getMeetingList(offset: offset);
    if (response.statusCode == 200) {
      _meetingList = MeetingModel.fromJson(response.body).meetingContent!.meetings;
    }
    _isLoading = false;
    update();
  }
  

}
