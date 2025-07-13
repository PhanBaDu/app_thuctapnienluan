import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/controller/theme_controller.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/category/controller/category_controller.dart';
import 'package:get_lms_flutter/feature/course/controller/course_controller.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(initState: (state) {
        Get.find<CategoryController>().getCategoryList(1,false);},
        builder: (categoryController) {
      if(categoryController.categoryList != null && categoryController.categoryList!.isEmpty){
        return const SizedBox() ;
      }else{
        if(categoryController.categoryList != null){
          return Center(
            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: Padding(
                padding: EdgeInsets.fromLTRB(ResponsiveHelper.isWeb()? 0: Dimensions.paddingSizeDefault, 0,ResponsiveHelper.isWeb()? 0:Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall,),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimensions.paddingSizeDefault,),

                      const SizedBox(height: Dimensions.paddingSizeDefault),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: ResponsiveHelper.isDesktop(context) ? 6 : ResponsiveHelper.isTab(context) ? 4 : 4,
                            crossAxisSpacing: Dimensions.paddingSizeDefault,
                            mainAxisSpacing: Dimensions.paddingSizeDefault,
                            childAspectRatio: .65,
                            mainAxisExtent:ResponsiveHelper.isMobile(context) ?  null : 220,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categoryController.categoryList!.length > 8 ? 8 : categoryController.categoryList!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed(RouteHelper.getCategoryProductRoute(
                                categoryController.categoryList![index].id!,
                                categoryController.categoryList![index].name!,
                              ));

                              Get.find<CategoryController>().getSubCategoryList(
                                categoryController.categoryList![index].id!,
                                index,
                              );

                              Get.find<CourseController>().getCategoryBasedCourses(
                                0,
                                true,
                                categoryController.categoryList![index].id!,
                              );
                            },
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                    child: CustomImage(
                                      image: '${categoryController.categoryList![index].image}',
                                      fit: BoxFit.cover, height:ResponsiveHelper.isMobile(context) ? MediaQuery.of(context).size.width/6 : MediaQuery.of(context).size.width/ 12, width: MediaQuery.of(context).size.width/6,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all( Dimensions.paddingSizeExtraSmall),
                                    child: Text(categoryController.categoryList![index].name!,
                                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                                      maxLines: 2,textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ]),
                          );
                        },
                      ) ,
                    ]),
              ),
            ),
          );
        }else{
          return WebCategoryShimmer(categoryController: categoryController);
        }
      }
    });
  }
}



class WebCategoryShimmer extends StatelessWidget {
  final CategoryController categoryController;

  const WebCategoryShimmer({super.key, required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        width: Dimensions.webMaxWidth,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
              margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall,top: Dimensions.paddingSizeLarge),
              child: Shimmer(
                duration: const Duration(seconds: 2),
                enabled: true,
                child: Row(children: [
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusSmall), color: Colors.grey[300]),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  Container( color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300]),
                ]),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ResponsiveHelper.isDesktop(context) ? 6 : ResponsiveHelper.isTab(context) ? 4 : 4,
              crossAxisSpacing: Dimensions.paddingSizeDefault,
              mainAxisSpacing: Dimensions.paddingSizeDefault,
              childAspectRatio: .95
          ),
        ),
      ),
    );
  }
}
