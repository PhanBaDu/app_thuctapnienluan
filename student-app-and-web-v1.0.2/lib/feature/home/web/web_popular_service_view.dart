import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/components/rating_bar.dart';
import 'package:get_lms_flutter/controller/theme_controller.dart';
import 'package:get_lms_flutter/core/helper/price_converter.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/course/controller/course_controller.dart';
import 'package:get_lms_flutter/feature/course/model/course_model.dart';
import 'package:get_lms_flutter/feature/course/view/course_details_screen.dart';
import 'package:get_lms_flutter/feature/splash/controller/splash_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class WebPopularCourseView extends StatelessWidget {
  const WebPopularCourseView({super.key});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(
      initState: (state){
        Get.find<CourseController>().getPopularServiceList(true,offset: 1,);
      },
      builder: (serviceController){
        if(serviceController.popularCourseList != null && serviceController.popularCourseList!.isEmpty){
          return const SizedBox();
        }else{
          if(serviceController.popularCourseList != null){
            List<Course>? _courseList = serviceController.popularCourseList;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('featured_course'.tr, style: ubuntuMedium.copyWith(fontSize: 24)),
                      InkWell(
                          onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute("fromPopularCourseView")),
                          child: Text('courses'.tr, style: ubuntuMedium.copyWith(fontSize: 16,color: Theme.of(context).primaryColor))),
                    ],
                  ),
                ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, childAspectRatio: .7,
                    crossAxisSpacing: Dimensions.paddingSizeSmall, mainAxisSpacing: Dimensions.paddingSizeDefault,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  itemCount: _courseList!.length > 5 ? 6 : _courseList.length,
                  itemBuilder: (context, index){
                    if(index == 5) {
                      return InkWell(
                        onTap: (){
                        },
                        child: Container(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                            boxShadow: [BoxShadow(
                              color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]!,
                              blurRadius: 5, spreadRadius: 1,
                            )],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'see_more_courses'.tr, textAlign: TextAlign.center,
                            style: ubuntuBold.copyWith(fontSize: 24, color: Theme.of(context).cardColor),
                          ),
                        ),
                      );
                    }

                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                            RouteHelper.getCourseDetailsRoute(_courseList[index].id!.toString()),
                            arguments: CourseDetailsScreen(courseID : _courseList[index].id!.toString(),));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                        ),
                        child: Column(children: [


                          Expanded(flex: 2,
                            child: SizedBox(
                              width: double.maxFinite,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                child: CustomImage(
                                  image: '${_courseList[index].thumbnail}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 3,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                              const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                              Text(
                                _courseList[index].title!,
                                style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                                maxLines: 1, overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                              Text(
                                _courseList[index].subTitle!,
                                style: ubuntuLight.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
                                maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: Dimensions.paddingSizeSmall),
                              const SizedBox(height:Dimensions.paddingSizeExtraSmall),
                              Row(
                                children: [
                                  Text(
                                    '5.0'.tr,
                                    style:  ubuntuRegular.copyWith(fontSize: Dimensions.paddingSizeDefault, ),),
                                  const SizedBox(width:Dimensions.paddingSizeExtraSmall),
                                  RatingBar(rating: 5.0, size: 15, ratingCount: 5000),

                                ],
                              ),
                              const SizedBox(height:Dimensions.paddingSizeExtraSmall),
                              Row(
                                children: [

                                  if(_courseList[index].isDiscounted != 0)
                                    Text(PriceFormatter.formatPrice(_courseList[index].price!.toDouble(),discountType: _courseList[index].discountType, discount: double.parse(_courseList[index].discountedPrice!)),
                                      style: ubuntuRegular.copyWith(
                                          fontSize: Dimensions.paddingSizeDefault,
                                          color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                                    ),
                                  if(_courseList[index].isDiscounted != 0)
                                    const SizedBox(width: Dimensions.paddingSizeSmall,),

                                  Text(PriceFormatter.formatPrice(_courseList[index].price!.toDouble()),
                                    style: ubuntuRegular.copyWith(
                                        fontSize: Dimensions.paddingSizeDefault,
                                        color: _courseList[index].isDiscounted != 0 ?  Theme.of(context).disabledColor: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor ),
                                  ),
                                ],
                              ),
                            ]),
                          ),

                        ]),
                      ),
                    );
                  },
                )
              ],
            );
          }else{
            return WebCampaignShimmer(enabled: true,);
          }
        }
      },
    );
  }
}

class WebCampaignShimmer extends StatelessWidget {
  final bool enabled;
  WebCampaignShimmer({required this.enabled});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, childAspectRatio: (1/0.35),
        crossAxisSpacing: Dimensions.paddingSizeLarge, mainAxisSpacing: Dimensions.paddingSizeLarge,
      ),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
      itemCount: 6,
      itemBuilder: (context, index){
        return Container(
          padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
          ),
          child: Shimmer(
            duration: Duration(seconds: 2),
            enabled: enabled,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Container(
                height: 90, width: 90,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusSmall), color: Colors.grey[300]),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(height: 15, width: 100, color: Colors.grey[300]),
                    SizedBox(height: 5),

                    Container(height: 10, width: 130, color: Colors.grey[300]),
                    SizedBox(height: 5),

                    RatingBar(rating: 0.0, size: 12, ratingCount: 0),
                    SizedBox(height: 5),

                    Container(height: 10, width: 30, color: Colors.grey[300]),
                  ]),
                ),
              ),

            ]),
          ),
        );
      },
    );
  }
}

