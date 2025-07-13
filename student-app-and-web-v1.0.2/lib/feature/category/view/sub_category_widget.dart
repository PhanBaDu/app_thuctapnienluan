import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/category/model/category_model.dart';
import 'package:get_lms_flutter/feature/course/controller/course_controller.dart';
import 'package:get_lms_flutter/feature/splash/controller/splash_controller.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class SubCategoryWidget extends GetView<CourseController> {
  final CategoryModel? categoryModel;
  const SubCategoryWidget({super.key, required this.categoryModel,});

  @override
  Widget build(BuildContext context) {
    bool desktop = ResponsiveHelper.isDesktop(context);

    return InkWell(
      onTap: () {
        Get.find<CourseController>().cleanSubCategory();
        Get.toNamed(RouteHelper.allServiceScreenRoute(categoryModel!.id!.toString()));
      },

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        padding: const EdgeInsets.all( Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            color: Theme.of(context).cardColor,
        ),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            child: CustomImage(
              image: '${categoryModel!.image}',
              height: desktop ? 120 : 70, width: desktop ? 120 : 70, fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
              const SizedBox(height: Dimensions.paddingSizeSmall,),
              Text(
                categoryModel!.name!,
                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
                maxLines: desktop ? 2 : 1, overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${categoryModel!.courseCount} ${'courses'.tr} ",
                    style: ubuntuRegular.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(Dimensions.radiusSmall))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      child: Center(child: Text('explore'.tr,style: ubuntuRegular.copyWith(color: Theme.of(context).cardColor),)),
                    ),)
                ],
              )
            ]),
          ),
        ]),
      ),
    );
  }
}
