import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/feature/myLearning/controller/assignment_controller.dart';
import 'package:get_lms_flutter/feature/myLearning/widgets/assignment_submit_dialog.dart';
import 'package:get_lms_flutter/components/list_shimmer.dart';
import 'package:get_lms_flutter/feature/root/view/no_data_screen.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class AssignmentScreen extends StatefulWidget {

  final String courseID;
  const AssignmentScreen({Key? key, required this.courseID}) : super(key: key);

  @override
  State<AssignmentScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<AssignmentScreen> {
  @override

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(title: "assignment_list".tr, isBackButtonExist: true,),
        body: GetBuilder<AssignmentController>(
          initState: (state){
            Get.find<AssignmentController>().getAssignmentList(1,int.parse(widget.courseID));
          },
          builder: (controller) {
            return FooterBaseWidget(child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: controller.isLoading? const ListShimmer(): controller.assignmentList != null && controller.assignmentList!.isEmpty?
              EmptyScreen(text: 'no_assignment_found'.tr):
              Column(children: [
                const SizedBox(height: Dimensions.paddingSizeDefault,),
                ListView.builder(
                  padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Get.dialog(AssignmentSubmitDialog(courseID: widget.courseID, assignment: controller.assignmentList!.elementAt(index),));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: const BorderRadius.all(Radius.circular(6))),
                        child: Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${'assignment_title'.tr}: ${controller.assignmentList!.elementAt(index).title!}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: ubuntuMedium.copyWith(
                                    fontSize: Dimensions.fontSizeLarge),
                              ),
                              const SizedBox(
                                height: Dimensions.paddingSizeExtraSmall,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${'created_at'.tr}: 20 Jan 2023",
                                    style: ubuntuRegular.copyWith(
                                        fontSize: Dimensions.fontSizeExtraSmall,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color!
                                            .withOpacity(.5)),
                                  ),

                                  Text(
                                    "${'status'.tr}: Pending",
                                    style: ubuntuRegular.copyWith(
                                        fontSize: Dimensions.fontSizeExtraSmall,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color!
                                            .withOpacity(.5)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 30,
                                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColorLight,
                                    ),
                                    child: Center(child: Text('assignment_resource'.tr),),
                                  ),
                                  const SizedBox(width: Dimensions.paddingSizeDefault,),
                                  CustomButton(
                                      width: 70,
                                      height: 30,
                                      buttonText: 'submit'.tr)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // itemCount: controller.myCourses!.length,
                  itemCount: controller.assignmentList!.length,
                ),
                controller.isLoading? const CircularProgressIndicator():const SizedBox()
              ],),
            ));
          },
        ));
  }
}










