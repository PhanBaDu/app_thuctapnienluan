import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/category/controller/category_controller.dart';
import 'package:get_lms_flutter/feature/category/model/category_model.dart';
import 'package:get_lms_flutter/feature/course/controller/course_controller.dart';
import 'package:get_lms_flutter/feature/root/view/no_data_screen.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class CategoryScreen extends StatefulWidget {
   final String fromPage;
   final String campaignID;

  const CategoryScreen({Key? key, required this.fromPage, required this.campaignID}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryModel>? categoryList;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'categories'.tr, isBackButtonExist: false),
      body: SafeArea(
          child: Scrollbar(
              child: GetBuilder<CategoryController>(
                  initState: (state){
                    Get.find<CategoryController>().getCategoryList(1,false);
                  },
                  builder: (categoryController) {
                    return _buildBody(categoryController.categoryList);
                  }))),
    );
  }

  Widget _buildBody(List<CategoryModel>? categoryList){
     if(categoryList != null && categoryList.isEmpty){
      return FooterBaseWidget(child: EmptyScreen(text: 'no_category_found'.tr));
    }else{
      if(categoryList != null){
        return FooterBaseWidget(
          child: SizedBox(
            width: Dimensions.webMaxWidth,
            child: SingleChildScrollView(
              controller: Get.find<CategoryController>().scrollController,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveHelper.isDesktop(context) ? 6 : ResponsiveHelper.isTab(context) ? 4 : 3,
                  childAspectRatio: (1 / 1),
                  mainAxisSpacing: Dimensions.paddingSizeSmall,
                  crossAxisSpacing: Dimensions.paddingSizeSmall,
                  mainAxisExtent: 150,
                ),
                padding: const EdgeInsets.all( Dimensions.paddingSizeDefault,),
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if(widget.fromPage == 'fromCampaign'){
                        Get.find<CategoryController>().getSubCategoryList(categoryList[index].id!,0); //banner id is category here
                        Get.toNamed(RouteHelper.subCategoryScreenRoute(categoryList[index].name!));
                      }else{
                        Get.toNamed(RouteHelper.getCategoryProductRoute(categoryList[index].id!, categoryList[index].name!,));
                        Get.find<CategoryController>().getSubCategoryList(categoryList[index].id!, index);

                        Get.find<CourseController>().getCategoryBasedCourses(
                          0,
                          true,
                          categoryList[index].id!,
                        );
                      }
                    },

                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                            child: CustomImage(height: 110, width: 120, fit: BoxFit.cover,
                              image: '${categoryList[index].image}',
                            ),
                          ),
                          const SizedBox(height: Dimensions.paddingSizeDefault),
                          Text(categoryList[index].name!,
                            textAlign: TextAlign.center,
                            style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ]),
                  );
                },
              ),
            ),
          ),
        );
      }else{
        return const Center(child: CircularProgressIndicator());
      }
    }
  }
}
