import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/course_view_verticle.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/components/paginated_list_view.dart';
import 'package:get_lms_flutter/components/title_widget.dart';
import 'package:get_lms_flutter/feature/course/controller/course_controller.dart';
import 'package:get_lms_flutter/feature/instructor/model/instructor_model.dart';
import 'package:get_lms_flutter/feature/instructor/widgets/instructor_social_widget.dart';
import 'package:get_lms_flutter/feature/root/view/no_data_screen.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class InstructorScreen extends StatefulWidget {
  final Instructor instructor;
  const InstructorScreen({Key? key, required this.instructor}) : super(key: key);

  @override
  State<InstructorScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<InstructorScreen> {
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();


    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(title: widget.instructor.name, isBackButtonExist: true,),
        body: FooterBaseWidget(
          child: SizedBox(
            width: Dimensions.webMaxWidth,
            child: CustomScrollView(
              controller: scrollController,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Instructor",style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodySmall!.color,),),
                                  const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                                  Text(widget.instructor.name!,style: ubuntuMedium.copyWith(
                                    color: Theme.of(context).textTheme.bodyLarge!.color,
                                    fontSize: Dimensions.fontSizeLarge,
                                  )),
                                  const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                                  Text("Software Engineer,Author",style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodySmall!.color,),),
                                  const SizedBox(height: Dimensions.paddingSizeDefault,),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("total_students".tr, style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color,),),
                                          const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                                          const Text("1452,45"),
                                        ],),
                                      const SizedBox(width: Dimensions.paddingSizeLarge,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("reviews".tr, style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color,),),
                                          const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                                          const Text("145"),
                                        ],)
                                    ],
                                  )
                                ]
                            ),
                            ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusExtraMoreLarge)),
                                child: CustomImage(image: widget.instructor.logo!,width: 90, height: 90, )),
                          ],
                        ),
                      ),
                      InstructorSocialWidget( socialLinks:widget.instructor.socialLinks! , instructorId: widget.instructor.id.toString(), instructorUserId: widget.instructor.userId!,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 15, Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall,),
                        child: TextTitle(
                          title: 'latest_courses'.tr,
                        ),
                      ),
                      GetBuilder<CourseController>(
                          initState: (state){
                            Get.find<CourseController>().getInstructorBasedCourseList(1, true, widget.instructor.id.toString());
                          },
                          builder: (serviceController) {
                            if(serviceController.instructorCourseList != null) {
                              return PaginatedListView(
                                scrollController: scrollController,
                                totalSize: 10,
                                offset: 10,
                                onPaginate: (int offset) async => await serviceController.getInstructorBasedCourseList(0,true,  widget.instructor.id.toString()),
                                itemView: CourseViewVertical(
                                  course: serviceController.instructorCourseList,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal:  Dimensions.paddingSizeDefault,
                                    vertical: 0,),
                                  type: 'others',
                                  noDataType: EmptyScreenType.home,
                                ),
                              );
                            }
                            return const SizedBox();
                          }),
                      const SizedBox(height: Dimensions.paddingSizeLarge,),
                    ],
                  ),
                ),


              ],
            ),
          ),
        )
    );
  }
}










