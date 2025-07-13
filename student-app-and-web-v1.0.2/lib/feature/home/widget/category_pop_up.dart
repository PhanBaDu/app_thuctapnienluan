import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/components/title_widget.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/category/controller/category_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CategoryPopUp extends StatelessWidget {
  final CategoryController categoryController;
  CategoryPopUp({required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500,
        height: 500,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 0, 10),
              child:
              TextTitle(title: 'categories'.tr),
            ),
            Expanded(
              child: SizedBox(
                height: 80,
                child: categoryController.categoryList != null ? GridView.builder(
                  itemCount: categoryController.categoryList!.length,
                  padding: EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                  physics: BouncingScrollPhysics(),
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.2,
                    crossAxisCount: GetPlatform.isDesktop ? 5 : 4,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                      child: InkWell(
                        onTap: () => Get.toNamed(RouteHelper.getCategoryProductRoute(
                          categoryController.categoryList![index].id!,
                          categoryController.categoryList![index].name!,
                        )),
                        child: SizedBox(
                          width: 50,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 50, width: 50,
                                  margin: EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                    boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200]!, blurRadius: 5, spreadRadius: 1)],
                                  ),
                                  child: CustomImage(
                                    // image: '${Get.find<SplashController>().configModel.baseUrls!.categoryImageUrl!}/${categoryController.categoryList![index].image}',
                                    image: '',
                                    height: 50, width: 50, fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  categoryController.categoryList![index].name!,
                                  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                                  maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
                                ),
                              ]),
                        ),
                      ),
                    );
                  },
                ) : CategoryShimmer(categoryController: categoryController),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryShimmer extends StatelessWidget {
  final CategoryController categoryController;
  CategoryShimmer({required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
            child: Shimmer(
              duration: const Duration(seconds: 2),
              enabled: categoryController.categoryList == null,
              child: Column(children: [
                Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                    height: 10, width: 50, color: Colors.grey[300]),
              ]),
            ),
          );
        },
      ),
    );
  }
}
