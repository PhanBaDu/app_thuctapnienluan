import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/core/helper/date_converter.dart';
import 'package:get_lms_flutter/core/helper/dotted_border.dart';
import 'package:get_lms_flutter/feature/instructor/controller/instructor_controller.dart';
import 'package:get_lms_flutter/feature/myLearning/controller/assignment_controller.dart';
import 'package:get_lms_flutter/feature/myLearning/model/assignment_model.dart';
import 'package:get_lms_flutter/feature/profile/controller/user_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class CreateMeetingDialog extends StatefulWidget {
  final String? instructorId;
  const CreateMeetingDialog({super.key, required this.instructorId});

  @override
  State<CreateMeetingDialog> createState() => _CreateMeetingDialogState();
}

class _CreateMeetingDialogState extends State<CreateMeetingDialog> {

  late Future<DateTime?> selectedDate;
  String date = "-";

  late Future<TimeOfDay?> selectedTime;
  String time = "-";

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
        insetPadding: const EdgeInsets.all(30),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: GetBuilder<AssignmentController>(
          builder: (assignmentController){
            return SizedBox(width: 500, child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, children: [

                Text(
                  'create_new_meeting'.tr,
                  maxLines: 2,
                  style: ubuntuMedium.copyWith(
                      fontSize: Dimensions.fontSizeLarge),
                ),

                const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),

                Text(
                  'selected_date_and_time'.tr, textAlign: TextAlign.center,
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault,),



                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 45,
                  color: Colors.grey[300],
                  child:
                  Text("$date : $time"),
                ),

                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0, backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 30)
                    ),
                    child: const Text("PICK DATE & TIME", style: TextStyle(color: Colors.white)),
                    onPressed: (){
                      showDialogPicker(context);
                    },
                  ),
                ),




                const SizedBox(height: Dimensions.paddingSizeLarge),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        height: 45,
                        width: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).primaryColorLight,),
                          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
                        ),
                        child: Center(
                          child: Text('cancel'.tr,style: ubuntuMedium.copyWith(color: Theme.of(context).colorScheme.secondary),),
                        ),
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeDefault,),
                    CustomButton(
                        width: 120,
                        onPressed: (){
                          Get.find<InstructorController>().createMeeting(instructorId: widget.instructorId!, meetingDate: "$date $time", userId: '1');
                        },
                        buttonText: 'submit'.tr),
                  ],
                )

              ]),
            ));
          },

        )
    );
  }




  void showDialogPicker(BuildContext context){
    selectedDate = showDatePicker(
      context: context,
      helpText: 'Your Date of Birth',
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme:  ColorScheme.light(
              // primary: MyColors.primary,
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            //.dialogBackgroundColor:Colors.blue[900],
          ),
          child: child!,
        );
      },
    );
    selectedDate.then((value) {
      setState(() {
        if(value == null) return;
        // date = value.toString();
        date = DateConverter.dateTimeStringToDateOnly(value.toString()).toString();
      });
      showDialogTimePicker(context);
    }, onError: (error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }

  void showDialogTimePicker(BuildContext context){
    selectedTime = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              // primary: MyColors.primary,
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            //.dialogBackgroundColor:Colors.blue[900],
          ),
          child: child!,
        );
      },
    );
    selectedTime.then((value) {
      setState(() {
        if(value == null) return;
        time = "${value.hour}:${value.minute}";
      });
    }, onError: (error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }

}
