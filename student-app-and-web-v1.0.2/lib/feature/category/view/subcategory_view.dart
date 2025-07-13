import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/course_shimmer.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/feature/category/controller/category_controller.dart';
import 'package:get_lms_flutter/feature/category/model/category_model.dart';
import 'package:get_lms_flutter/feature/category/view/sub_category_widget.dart';
import 'package:get_lms_flutter/feature/root/view/no_data_screen.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';

class SubCategoryView extends GetView<CategoryController> {
  final EdgeInsetsGeometry? padding;
  final bool? isScrollable;
  final int? shimmerLength;
  final String? noDataText;
  final String? type;
  final Function(String type)? onVegFilterTap;
  const SubCategoryView({super.key, this.isScrollable = false, this.shimmerLength = 20, this.padding = const EdgeInsets.all(Dimensions.paddingSizeSmall), this.noDataText, this.type, this.onVegFilterTap});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
     builder: (categoryController){
       if(categoryController.subCategoryList == null){
         return  SliverGrid(
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
             childAspectRatio: ResponsiveHelper.isDesktop(context) ? 4 : 3.5,
             mainAxisSpacing: Dimensions.paddingSizeDefault,
             crossAxisSpacing: Dimensions.paddingSizeDefault,),
           delegate: SliverChildBuilderDelegate(
                 (context, index) {
               return Padding(
                 padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                 child: CourseShimmer(isEnabled: true, hasDivider: index != shimmerLength!-1),
               );
             },
             childCount: 10,
           ),
         );
       }else{
         List<CategoryModel> subCategoryList = categoryController.subCategoryList ?? [];
         return subCategoryList.isNotEmpty ? SliverGrid(
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisSpacing: Dimensions.paddingSizeLarge,
             mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeLarge : Dimensions.paddingSizeSmall,
             childAspectRatio: ResponsiveHelper.isDesktop(context) ? 4 : 3.2,
             crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
             mainAxisExtent: 115,
           ),
           delegate: SliverChildBuilderDelegate((context, index) {
             return SubCategoryWidget(categoryModel: subCategoryList[index]);
             },
             childCount: subCategoryList.length,
           ),
         ):
         SliverToBoxAdapter(
           child: SizedBox(
             height: Get.height / 1.5,
             child: EmptyScreen(
               text: noDataText ?? 'no_category_found'.tr,
             ),
           ),
         );
       }
     },
    );
  }
}
