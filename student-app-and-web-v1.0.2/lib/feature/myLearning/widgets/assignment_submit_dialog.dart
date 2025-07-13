import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/core/helper/dotted_border.dart';
import 'package:get_lms_flutter/feature/myLearning/controller/assignment_controller.dart';
import 'package:get_lms_flutter/feature/myLearning/model/assignment_model.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class AssignmentSubmitDialog extends StatelessWidget {
  final String? courseID;
  final Assignment? assignment;
  const AssignmentSubmitDialog({super.key, required this.courseID, required this.assignment});

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
                "${'assignment_title'.tr}: ${assignment!.title}",
                maxLines: 2,
                style: ubuntuMedium.copyWith(
                    fontSize: Dimensions.fontSizeLarge),
              ),

              Text(
                "${'assignment_description'.tr}: ${assignment!.description}",
                maxLines: 2,
                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge),

              Text(
                'pick_assignment_file'.tr, textAlign: TextAlign.center,
                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault,),
              if(assignmentController.assignmentFile == null)
              DottedBorderBox(
                height: 120,
                width: 120,
                onTap: () =>
                    Get.find<AssignmentController>().pickAssignmentFile(),
              ),
              if(assignmentController.assignmentFile != null)
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
                      child: Image.file(
                        File(assignmentController.assignmentFile!.path),
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        assignmentController.removeAssignmentFile();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                        child: Image.asset(Images.cartDelete,scale: 3,),
                      ),
                    )
                  ],
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
                        Get.find<AssignmentController>().submitAssignment(assignment!.id!.toString());
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
}
