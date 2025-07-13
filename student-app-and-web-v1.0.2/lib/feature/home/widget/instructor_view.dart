import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/components/rating_bar.dart';
import 'package:get_lms_flutter/components/title_widget.dart';
import 'package:get_lms_flutter/controller/theme_controller.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/instructor/controller/instructor_controller.dart';
import 'package:get_lms_flutter/feature/instructor/model/instructor_model.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class FeaturedInstructorView extends GetView<InstructorController> {
  const FeaturedInstructorView({super.key});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstructorController>(
      builder: (instructorController){
        if(instructorController.instructorList != null && instructorController.instructorList!.isEmpty){
          return const SizedBox();
        }else{
          if(instructorController.instructorList != null){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 15, Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall,),
                  child: TextTitle(
                    title: 'instructors'.tr,
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                SizedBox(
                  height: 102,
                  child: ListView.builder(
                      itemCount: instructorController.instructorList?.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        Instructor instructor = instructorController.instructorList!.elementAt(index);
                        return InkWell(
                          onTap: (){
                            Get.toNamed(RouteHelper.getInstructorScreen(instructorController.instructorList!.elementAt(index)));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: Dimensions.paddingSizeDefault,
                                left: index == 0 ? Dimensions.paddingSizeDefault : 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(6))),
                              child: Padding(
                                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                                      child: CustomImage(image: instructorController.instructorList!.elementAt(index).logo!,)
                                    ),
                                    const SizedBox(width: Dimensions.paddingSizeSmall),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            instructorController.instructorList!.elementAt(index).name!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: ubuntuMedium.copyWith(
                                                fontSize: Dimensions.fontSizeDefault),
                                          ),
                                          Text("Instructor",style: ubuntuRegular.copyWith(color: Theme.of(context).disabledColor),),
                                          Text(instructor.designation!,style: ubuntuRegular.copyWith(color: Theme.of(context).disabledColor),),
                                          Row(
                                            children: [
                                              Text(
                                                '5.0'.tr,
                                                style:  ubuntuRegular.copyWith(fontSize: Dimensions.paddingSizeDefault, ),),
                                              const SizedBox(width:Dimensions.paddingSizeExtraSmall),
                                              RatingBar(rating: 5.0, size: 15, ratingCount: 5000),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            );
          }else{
            return const PopularServiceShimmer(enabled: true,);
          }
        }
      },
    );
  }
}

class PopularServiceShimmer extends StatelessWidget {
  final bool enabled;
  const PopularServiceShimmer({super.key, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall,left: Dimensions.paddingSizeSmall,top: Dimensions.paddingSizeSmall,),
        itemCount: 10,
        itemBuilder: (context, index){
          return Container(
            height: 80, width: 200,
            margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall,),
            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            decoration: BoxDecoration(
              color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              boxShadow: cardShadow,
            ),
            child: Shimmer(
              duration: const Duration(seconds: 1),
              interval: const Duration(seconds: 1),
              enabled: enabled,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                Container(
                  height: 70, width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                      color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300]
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(height: 15, width: 100, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300]),
                      const SizedBox(height: 5),
                      Container(height: 10, width: 130, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300]),
                      const SizedBox(height: 5),
                      Container(height: 10, width: 130, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300]),

                    ]),
                  ),
                ),

              ]),
            ),
          );
        },
      ),
    );
  }
}

