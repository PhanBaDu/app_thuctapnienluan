import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/feature/category/controller/category_controller.dart';
import 'package:get_lms_flutter/feature/category/model/category_model.dart';
import 'package:get_lms_flutter/feature/category/view/category_based_course_view.dart';
import 'package:get_lms_flutter/feature/category/view/subcategory_view.dart';
import 'package:get_lms_flutter/feature/course/controller/course_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class CategorySubCategoryScreen extends StatefulWidget {
  final String categoryID;
  final String categoryName;
  const CategorySubCategoryScreen({Key? key, required this.categoryID, required this.categoryName}) : super(key: key);

  @override
  State<CategorySubCategoryScreen> createState() => _CategorySubCategoryScreenState();
}

class _CategorySubCategoryScreenState extends State<CategorySubCategoryScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    moved();
    super.initState();
  }

  moved()async{
    Future.delayed(const Duration(seconds: 1), () {
      Scrollable.ensureVisible(
        Get.find<CategoryController>().categoryList!.elementAt(Get.find<CategoryController>().subCategoryIndex!).globalKey!.currentContext!,
        duration: const Duration(seconds: 1),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();


    return GetBuilder<CategoryController>(
        initState: (state) {},
        builder: (categoryController) {
          return WillPopScope(
            onWillPop: () async {
              if (categoryController.isSearching!) {
                categoryController.toggleSearch();
                return false;
              } else {
                return true;
              }
            },
            child: Scaffold(
              appBar: CustomAppBar(title: 'available_courses'.tr,),
              body: FooterBaseWidget(
                child: SizedBox(
                  width: Dimensions.webMaxWidth,
                  child: CustomScrollView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _scrollController,
                    slivers: [
                      const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeLarge,),),
                      SliverToBoxAdapter(
                        child: (categoryController.categoryList != null && !categoryController.isSearching!) ?
                        Container(
                          height: 138,
                          margin: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
                          width: Dimensions.webMaxWidth,
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryController.categoryList!.length,
                            padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall,right: Dimensions.paddingSizeSmall),
                            itemBuilder: (context, index) {
                              CategoryModel categoryModel = categoryController.categoryList!.elementAt(index);
                              return InkWell(
                                key: categoryModel.globalKey,
                                onTap: () {
                                  Get.find<CategoryController>().getSubCategoryList(categoryModel.id!, index);
                                  Get.find<CourseController>().getCategoryBasedCourses(
                                    0,
                                    true,
                                    categoryController.categoryList![index].id!,
                                  );

                                },
                                child: Container(
                                  width: Get.width / 4.5,
                                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 64,
                                          width: 72,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusDefault)),
                                            border: Border.all(
                                              width: 2,
                                              color: index == categoryController.subCategoryIndex ? Theme.of(context).primaryColor : Colors.transparent,),

                                          ),
                                          child: CustomImage(
                                            image: '${categoryController.categoryList![index].image}',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        const SizedBox(height: Dimensions.paddingSizeSmall,),
                                        Text(categoryController.categoryList![index].name!,
                                          style: ubuntuMedium.copyWith(
                                              fontSize: Dimensions.fontSizeSmall),
                                          maxLines: 2,textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,
                                        ),
                                      ]),
                                ),
                              );
                            },
                          ),
                        ) : const SizedBox(),
                      ),
                      const SliverToBoxAdapter(
                        child:  CategoryBasedCourseView(),
                      ),

                      SliverToBoxAdapter(
                          child: SizedBox(width: Dimensions.webMaxWidth,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge,horizontal: Dimensions.paddingSizeDefault),
                                child: Text(
                                  'available_sub_categories'.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge,
                                    color:Get.isDarkMode ? Colors.white:Theme.of(context).primaryColor),),))),
                      SubCategoryView(noDataText: "no_courses_found".tr, isScrollable: true),
                      const SliverToBoxAdapter(child: SizedBox(height: 120)),
                    ],
                  ),
                )
              )
            ),
          );
        });
  }
}
