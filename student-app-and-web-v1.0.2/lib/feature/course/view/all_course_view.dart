import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/course_view_verticle.dart';
import 'package:get_lms_flutter/components/course_widget.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/components/paginated_list_view.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/feature/course/controller/course_controller.dart';
import 'package:get_lms_flutter/feature/course/model/course_model.dart';
import 'package:get_lms_flutter/feature/root/view/no_data_screen.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';

class AllCourseView extends StatelessWidget {
  final String fromPage;
  const AllCourseView({super.key, required this.fromPage});

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      appBar: CustomAppBar(title: 'explore_courses'.tr,showCart: true,),
      body: _buildBody(fromPage,context,_scrollController),
    );
  }

  Widget _buildBody(String fromPage,BuildContext context,ScrollController scrollController){
    if(fromPage == 'fromPopularCourseView'){
      return GetBuilder<CourseController>(
        initState: (state){
          Get.find<CourseController>().getPopularServiceList(true,offset: 1,);
        },
        builder: (serviceController){
          return _buildWidget(serviceController.popularCourseList,context);
        },
      );
    }else if(fromPage == 'fromCampaign'){
      return GetBuilder<CourseController>(
        builder: (serviceController){
          return _buildWidget(serviceController.campaignBasedServiceList!,context);
        },
      );
    }else if(fromPage == 'allCourses'){
      return GetBuilder<CourseController>(builder: (serviceController) {
        return FooterBaseWidget(
            isScrollView:true,
            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: Column(
                children: [
                  const SizedBox(height: Dimensions.paddingSizeDefault,),
                  PaginatedListView(
                    scrollController: scrollController,
                    totalSize: serviceController.serviceContent != null ? serviceController.serviceContent!.total:0,
                    offset: serviceController.serviceContent != null ? serviceController.serviceContent!.currentPage != null ? serviceController.serviceContent!.currentPage! + 1 : null : null,
                    onPaginate: (int offset) async => await serviceController.getAllCourseList(offset, false),
                    itemView: CourseViewVertical(
                      course: serviceController.serviceContent != null ? serviceController.allService : null,
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall,
                        vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : 0,
                      ),
                      type: 'others',
                      noDataType: EmptyScreenType.home,
                    ),
                  ),
                ],
              )
            ),
        );
      });
    }else{
      return GetBuilder<CourseController>(
        initState: (state){
          Get.find<CourseController>().getSubCategoryBasedServiceList(fromPage,false,isShouldUpdate: true);
        },
        builder: (serviceController){
          return _buildWidget(serviceController.subCategoryBasedServiceList ,context);
        },
      );
    }
  }

  Widget _buildWidget(List<Course>? serviceList,BuildContext context){
    return FooterBaseWidget(
      isCenter: true,
      child: SizedBox(
        width: Dimensions.webMaxWidth,
        child:(serviceList != null && serviceList.isEmpty) ?  EmptyScreen(text: 'no_courses_found'.tr,type: EmptyScreenType.course,) :  serviceList != null ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeDefault),
          child: CustomScrollView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              if(ResponsiveHelper.isWeb())
                const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeExtraMoreLarge,)),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: Dimensions.paddingSizeDefault,
                  mainAxisSpacing:  Dimensions.paddingSizeDefault,
                  childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context)  ? .9 : .75,
                  crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : ResponsiveHelper.isTab(context) ? 3 : 5,
                  mainAxisExtent: 275,
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    Get.find<CourseController>().getServiceDiscount(serviceList[index]);
                    return CourseWidget(course: serviceList[index]);
                  },
                  childCount: serviceList.length,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: Dimensions.WEB_CATEGORY_SIZE,)),
            ],
          ),
        ) : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

