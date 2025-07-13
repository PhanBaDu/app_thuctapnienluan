import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/components/ripple_button.dart';
import 'package:get_lms_flutter/core/helper/price_converter.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/course/model/course_model.dart';
import 'package:get_lms_flutter/feature/course/view/course_details_screen.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'rating_bar.dart';

class CourseWidget extends StatelessWidget {
  final Course? course;
  const CourseWidget({super.key, required this.course,});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color:  Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          ),
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusDefault)),
                        child: CustomImage(
                          image: course!.thumbnail??'',
                          fit: BoxFit.cover,
                          height: 140,
                        ),
                      ),
                      const SizedBox(height:Dimensions.paddingSizeSmall),
                      Text(
                          course!.title??'',
                          style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                          maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start),
                    ],
                  ),
                  const SizedBox(height:Dimensions.paddingSizeExtraSmall),
                  Row(
                    children: [
                      Text(
                        '5.0'.tr,
                        style:  ubuntuRegular.copyWith(fontSize: Dimensions.paddingSizeDefault, ),),
                      const SizedBox(width:Dimensions.paddingSizeExtraSmall),
                      const RatingBar(rating: 5.0, size: 15, ratingCount: 5000),

                    ],
                  ),
                  const SizedBox(height:Dimensions.paddingSizeExtraSmall),
                  Row(
                    children: [

                      if(course!.isDiscounted != 0)
                      Text(PriceFormatter.formatPrice(course!.price!.toDouble(),discountType: course!.discountType, discount: double.parse(course!.discountedPrice!)),
                        style: ubuntuRegular.copyWith(
                            fontSize: Dimensions.paddingSizeDefault,
                            color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                      ),
                      if(course!.isDiscounted != 0)
                      const SizedBox(width: Dimensions.paddingSizeSmall,),

                      Text(PriceFormatter.formatPrice(course!.price!.toDouble()),
                        style: ubuntuRegular.copyWith(
                            fontSize: Dimensions.paddingSizeDefault,
                            color: course!.isDiscounted != 0 ?  Theme.of(context).disabledColor: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor ),
                      ),
                    ],
                  ),
                ]),
          ),),
        Positioned.fill(
          child: RippleButton(
            onTap:() => Get.toNamed(RouteHelper.getCourseDetailsRoute(course!.id!.toString()), arguments: CourseDetailsScreen(courseID : course!.id!.toString(),)),
          ),)
      ],);
  }
}
