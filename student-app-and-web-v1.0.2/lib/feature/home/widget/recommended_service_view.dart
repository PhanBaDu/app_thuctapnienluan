import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/rating_bar.dart';
import 'package:get_lms_flutter/components/title_widget.dart';
import 'package:get_lms_flutter/controller/theme_controller.dart';
import 'package:get_lms_flutter/core/common_models/coupon_model.dart';
import 'package:get_lms_flutter/core/helper/price_converter.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/course/controller/course_controller.dart';
import 'package:get_lms_flutter/feature/course/view/course_details_screen.dart';
import 'package:get_lms_flutter/feature/home/web/web_instructor_view.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class RecommendedServiceView extends StatelessWidget {
  const RecommendedServiceView({super.key});


  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    return GetBuilder<CourseController>(
      builder: (serviceController){
        if(serviceController.recommendedServiceList != null && serviceController.recommendedServiceList!.length == 0){
          return SizedBox();
        }else{
          if(serviceController.recommendedServiceList != null){
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 15, Dimensions.paddingSizeDefault,  Dimensions.paddingSizeSmall,),
                  child: TextTitle(
                    title: 'recommended_for_you'.tr,
                    onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute("fromRecommendedScreen")),
                  ),
                ),
                SizedBox(
                    height: 110,
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      itemCount: serviceController.recommendedServiceList!.length > 10 ? 10 : serviceController.recommendedServiceList!.length,
                      itemBuilder: (context, index){
                        Discount _discountValue =  PriceFormatter.discountCalculation(serviceController.recommendedServiceList![index]);
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(2, 2, Dimensions.paddingSizeSmall, 2),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                RouteHelper.getCourseDetailsRoute(serviceController.recommendedServiceList![index].id!.toString()),
                                arguments: CourseDetailsScreen(courseID: serviceController.recommendedServiceList![index].id!.toString()),
                              );
                            },
                            child: SizedBox(
                              height: 110, width: MediaQuery.of(context).size.width/1.20,
                              child: ServiceModelView(
                                serviceList: serviceController.recommendedServiceList!,
                                discountAmountType: _discountValue.discountAmountType,
                                discountAmount: _discountValue.discountAmount,
                                index: index,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                ),
              ],
            );
          }else{
            return SizedBox(
                height: 110,
                child: RecommendedServiceShimmer(enabled: true));
          }
        }
      },
    );
  }
}

class RecommendedServiceShimmer extends StatelessWidget {
  final bool enabled;
  RecommendedServiceShimmer({super.key, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(right: Dimensions.paddingSizeSmall,left: Dimensions.paddingSizeSmall,top: Dimensions.paddingSizeSmall,),
      itemCount: 10,
      itemBuilder: (context, index){
        return Container(
          height: 90, width: 200,
          margin: EdgeInsets.only(right: Dimensions.paddingSizeSmall),
          padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          decoration: BoxDecoration(
            color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            boxShadow: cardShadow,
          ),
          child: Shimmer(
            duration: Duration(seconds: 1),
            interval: Duration(seconds: 1),
            enabled: enabled,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 70, width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300]
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(height: 15, width: 100, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300]),
                    SizedBox(height: 5),
                    Container(height: 10, width: 130, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
                    SizedBox(height: 5),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Container(height: 10, width: 30, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300]),
                      RatingBar(rating: 0.0, size: 12, ratingCount: 0),
                    ]),
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