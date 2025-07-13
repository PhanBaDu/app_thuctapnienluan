import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/components/custom_snackbar.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/components/list_shimmer.dart';
import 'package:get_lms_flutter/feature/courseResources/controller/course_resource_controller.dart';
import 'package:get_lms_flutter/feature/courseResources/model/course_resource_model.dart';
import 'package:get_lms_flutter/feature/root/view/no_data_screen.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseResourceScreen extends StatefulWidget {
  final String courseID;

  const CourseResourceScreen({Key? key, required this.courseID}) : super(key: key);

  @override
  State<CourseResourceScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<CourseResourceScreen> {
  @override

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(title: "course_resource".tr, isBackButtonExist: true,),
        body: GetBuilder<CourseResourceController>(
          initState: (state){
            Get.find<CourseResourceController>().getCourseResourceList(widget.courseID.toString());
          },
          builder: (controller) {
            return FooterBaseWidget(
                child: SizedBox(
                  width: Dimensions.webMaxWidth,
                  child: controller.isLoading? const ListShimmer(): controller.courseResourceList != null && controller.courseResourceList!.isEmpty?
                  EmptyScreen(text: 'no_resource_available'.tr, type: EmptyScreenType.meetings,):
                  Column(children: [
                    const SizedBox(height: Dimensions.paddingSizeDefault,),
                    ListView.builder(
                      padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,),
                      itemBuilder: (context, index) {
                        CourseResource courseResource = controller.courseResourceList!.elementAt(index);
                        return Padding(
                          padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall,),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: const BorderRadius.all(Radius.circular(6))),
                            child: Padding(
                              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${controller.courseResourceList!.elementAt(index).title}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(),
                                      CustomButton(
                                        width: 100,
                                        height: 30,
                                        onPressed: () async {

                                          if(controller.courseResourceList!.elementAt(index).lessonResource == null){
                                            customSnackBar("lesson_resource_not_available".tr);
                                          }else{
                                            final uri = Uri.parse(controller.courseResourceList!.elementAt(index).lessonResource!);
                                            if (await canLaunchUrl(uri)) {
                                              await launchUrl(uri);
                                            }
                                          }
                                        },
                                        buttonText: 'download'.tr,),
                                    ],
                                  ),
                                  const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.courseResourceList!.length,
                    ),
                    controller.isLoading? const CircularProgressIndicator():const SizedBox()
                  ],),
                )
            );
          },
        ));
  }
}










