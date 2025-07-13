import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/components/rating_bar.dart';
import 'package:get_lms_flutter/components/ripple_button.dart';
import 'package:get_lms_flutter/components/title_widget.dart';
import 'package:get_lms_flutter/controller/localization_controller.dart';
import 'package:get_lms_flutter/controller/theme_controller.dart';
import 'package:get_lms_flutter/core/common_models/coupon_model.dart';
import 'package:get_lms_flutter/core/helper/price_converter.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/course/controller/course_controller.dart';
import 'package:get_lms_flutter/feature/course/model/course_model.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class FeaturedCourseView extends GetView<CourseController> {
  const FeaturedCourseView({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return GetBuilder<CourseController>(
      builder: (serviceController) {
        if (serviceController.popularCourseList != null &&
            serviceController.popularCourseList!.isEmpty) {
          return const SizedBox();
        } else {
          if (serviceController.popularCourseList != null) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    Dimensions.paddingSizeDefault,
                    15,
                    Dimensions.paddingSizeDefault,
                    Dimensions.paddingSizeSmall,
                  ),
                  child: TextTitle(
                    title: 'featured_course'.tr,
                    // onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute("fromPopularCourseView")),
                  ),
                ),
                SizedBox(
                  height: Dimensions.POPULAR_SERVICE_HEIGHT,
                  child: ListView.builder(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(
                        left: Dimensions.paddingSizeDefault,
                        bottom: Dimensions.paddingSizeExtraSmall,
                        top: Dimensions.paddingSizeExtraSmall),
                    itemCount: serviceController.popularCourseList!.length > 10
                        ? 10
                        : serviceController.popularCourseList!.length,
                    itemBuilder: (context, index) {
                      controller.getServiceDiscount(
                          serviceController.popularCourseList![index]);
                      Discount discountModel =
                          PriceFormatter.discountCalculation(
                              serviceController.popularCourseList![index]);
                      Course course =
                          serviceController.popularCourseList!.elementAt(index);
                      double lowestPrice = 0.0;

                      return Padding(
                        padding: const EdgeInsets.only(
                            right: Dimensions.paddingSizeDefault),
                        child: Stack(
                          alignment: Get.find<LocalizationController>().isLtr
                              ? Alignment.bottomRight
                              : Alignment.bottomLeft,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: Get.width / 1.8,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radiusSmall),
                                      boxShadow:
                                          Get.isDarkMode ? null : cardShadow),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //image and service name
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  Dimensions.paddingSizeRadius),
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                Dimensions
                                                                    .radiusSmall)),
                                                    child: CustomImage(
                                                      image:
                                                          '${course.thumbnail}',
                                                      fit: BoxFit.cover,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.8,
                                                      height: 135,
                                                    ),
                                                  ),
                                                  discountModel
                                                              .discountAmount! >
                                                          0
                                                      ? Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(
                                                                    Dimensions
                                                                        .paddingSizeExtraSmall),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .error,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        Dimensions
                                                                            .radiusDefault),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        Dimensions
                                                                            .radiusSmall),
                                                              ),
                                                            ),
                                                            child:
                                                                Directionality(
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              child: Text(
                                                                PriceFormatter
                                                                    .percentageOrAmount(
                                                                        '${discountModel.discountAmount}',
                                                                        '${discountModel.discountAmountType}'),
                                                                style: ubuntuRegular
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right:
                                                    Dimensions.paddingSizeSmall,
                                                left:
                                                    Dimensions.paddingSizeSmall,
                                              ),
                                              child: Text(course.title ?? '',
                                                  style: ubuntuMedium.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeDefault),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right:
                                                  Dimensions.paddingSizeSmall,
                                              left: Dimensions.paddingSizeSmall,
                                              bottom:
                                                  Dimensions.paddingSizeSmall),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '5.0'.tr,
                                                    style:
                                                        ubuntuRegular.copyWith(
                                                      fontSize: Dimensions
                                                          .paddingSizeDefault,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      width: Dimensions
                                                          .paddingSizeExtraSmall),
                                                  RatingBar(
                                                      rating: 5.0,
                                                      size: 15,
                                                      ratingCount: 5000),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  const SizedBox(
                                                      height: Dimensions
                                                          .paddingSizeExtraSmall),
                                                  if (discountModel
                                                          .discountAmount! >
                                                      0)
                                                    Text(
                                                      PriceFormatter
                                                          .formatPrice(
                                                              lowestPrice),
                                                      style: ubuntuRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeSmall,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme.error
                                                              .withOpacity(.8)),
                                                    ),
                                                  const SizedBox(
                                                    height: Dimensions
                                                        .paddingSizeMint,
                                                  ),
                                                  Row(
                                                    children: [
                                                      if (course.isDiscounted !=
                                                          0)
                                                        Text(
                                                          PriceFormatter.formatPrice(
                                                              course.price!
                                                                  .toDouble(),
                                                              discountType: course!
                                                                  .discountType,
                                                              discount: double
                                                                  .parse(course!
                                                                      .discountedPrice!)),
                                                          style: ubuntuRegular.copyWith(
                                                              fontSize: Dimensions
                                                                  .paddingSizeDefault,
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? Theme.of(
                                                                          context)
                                                                      .primaryColorLight
                                                                  : Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                        ),
                                                      const SizedBox(
                                                        width: Dimensions
                                                            .paddingSizeSmall,
                                                      ),
                                                      Text(
                                                        PriceFormatter
                                                            .formatPrice(course!
                                                                .price!
                                                                .toDouble()),
                                                        style: ubuntuRegular.copyWith(
                                                            fontSize: Dimensions
                                                                .paddingSizeDefault,
                                                            color: Theme.of(
                                                                    context)
                                                                .disabledColor),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ]),
                                ),
                                Positioned.fill(
                                  child: RippleButton(
                                    onTap: () => Get.toNamed(
                                      RouteHelper.getCourseDetailsRoute(
                                          course.id!.toString()),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                )
              ],
            );
          } else {
            return const PopularServiceShimmer(
              enabled: true,
            );
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
        padding: const EdgeInsets.only(
          right: Dimensions.paddingSizeSmall,
          left: Dimensions.paddingSizeSmall,
          top: Dimensions.paddingSizeSmall,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            height: 80,
            width: 200,
            margin: const EdgeInsets.only(
              right: Dimensions.paddingSizeSmall,
            ),
            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            decoration: BoxDecoration(
              color: Colors
                  .grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              boxShadow: cardShadow,
            ),
            child: Shimmer(
              duration: const Duration(seconds: 1),
              interval: const Duration(seconds: 1),
              enabled: enabled,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radiusSmall),
                          color: Colors.grey[
                              Get.find<ThemeController>().darkTheme
                                  ? 600
                                  : 300]),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.paddingSizeExtraSmall),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 15,
                                  width: 100,
                                  color: Colors.grey[
                                      Get.find<ThemeController>().darkTheme
                                          ? 600
                                          : 300]),
                              const SizedBox(height: 5),
                              Container(
                                  height: 10,
                                  width: 130,
                                  color: Colors.grey[
                                      Get.find<ThemeController>().darkTheme
                                          ? 600
                                          : 300]),
                              const SizedBox(height: 5),
                              Container(
                                  height: 10,
                                  width: 130,
                                  color: Colors.grey[
                                      Get.find<ThemeController>().darkTheme
                                          ? 600
                                          : 300]),
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
