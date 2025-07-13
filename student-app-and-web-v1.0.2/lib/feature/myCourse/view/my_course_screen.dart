import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/myCourse/controller/my_course_controller.dart';
import 'package:get_lms_flutter/components/list_shimmer.dart';
import 'package:get_lms_flutter/feature/root/view/no_data_screen.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({Key? key}) : super(key: key);

  @override
  State<MyCourseScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<MyCourseScreen> {
  @override

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(title: "my_course".tr, isBackButtonExist: false,),
        body: GetBuilder<MyCourseController>(
          initState: (state){
            Get.find<MyCourseController>().getMyCourseList(offset: 1,isFromPagination:false);
          },
          builder: (controller) {

            return FooterBaseWidget(child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: controller.isLoading? const ListShimmer(): controller.myCourses != null && controller.myCourses!.isEmpty?
              EmptyScreen(text: 'no_course_enrolled'.tr,type: EmptyScreenType.course,):
              CustomScrollView(
                  shrinkWrap: true,
                  controller: controller.myCourseScreenScrollController,
                  physics: const NeverScrollableScrollPhysics(),
                  slivers: [
                    if(ResponsiveHelper.isDesktop(context))
                      const SliverToBoxAdapter(
                        child: SizedBox(height: Dimensions.paddingSizeDefault,),
                      ),
                    SliverToBoxAdapter(child: Column(children: [
                      ListView.builder(
                        padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              Get.toNamed(RouteHelper.getMyLearningScreen(controller.myCourses!.elementAt(index).id!.toString()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall,),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: const BorderRadius.all(Radius.circular(6))),
                                child: Padding(
                                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                                        child: CustomImage(
                                          image: controller.myCourses!.elementAt(index).thumbnail!,
                                          height: 60,

                                        ),
                                      ),
                                      const SizedBox(
                                        width: Dimensions.paddingSizeSmall,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.myCourses!.elementAt(index).title!,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: ubuntuMedium.copyWith(
                                                  fontSize: Dimensions.fontSizeDefault),
                                            ),
                                            const SizedBox(
                                              height: Dimensions.paddingSizeExtraSmall,
                                            ),
                                            Text(
                                                controller.myCourses!.elementAt(index).subTitle!,
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
                                      ),
                                      /*SizedBox(
                                        height: 100,
                                        child: Stack(
                                          alignment: AlignmentDirectional.center,
                                          children: [
                                            Center(
                                              child: SizedBox(
                                                height:50,
                                                width: 50,
                                                child: CircularProgressIndicator(
                                                  value: double.parse(controller.myCourses!.elementAt(index).completedPercentage!),
                                                  strokeWidth: 8,
                                                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor.withOpacity(.5)),
                                                  backgroundColor: Theme.of(context).primaryColor.withOpacity(.1),
                                                ),
                                              ),
                                            ),
                                            Center(child: Text("${controller.myCourses!.elementAt(index).completedPercentage!}%",style: ubuntuRegular.copyWith(color: Theme.of(context).primaryColor.withOpacity(.7)),)),
                                          ],
                                        ),
                                      )*/
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.myCourses!.length,
                      ),
                      controller.isLoading? const CircularProgressIndicator():const SizedBox()
                    ],),)
                  ]),
            ));
          },
        ));
  }
}










