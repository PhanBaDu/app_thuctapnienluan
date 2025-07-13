import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/service_view.dart';
import 'package:get_lms_flutter/feature/course/controller/course_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(child: SizedBox(width: Dimensions.webMaxWidth, child: Column(children: [
          ServiceView(service: Get.find<CourseController>().popularCourseList!),

        ]))),
      ),
    );
  }
}
