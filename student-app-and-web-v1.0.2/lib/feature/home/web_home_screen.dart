import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/course_view_verticle.dart';
import 'package:get_lms_flutter/components/footer_widget.dart';
import 'package:get_lms_flutter/components/paginated_list_view.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/feature/course/controller/course_controller.dart';
import 'package:get_lms_flutter/feature/home/web/web_banner_view.dart';
import 'package:get_lms_flutter/feature/home/web/web_popular_service_view.dart';
import 'package:get_lms_flutter/feature/home/widget/category_view.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'controller/banner_controller.dart';
import 'web/web_instructor_view.dart';

class WebHomeScreen extends StatelessWidget {
  final ScrollController? scrollController;
  const WebHomeScreen({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    Get.find<BannerController>().setCurrentIndex(0, false);
    return CustomScrollView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
       const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeExtraLarge,)),
        const SliverToBoxAdapter(
          child: Center(child: SizedBox(width: Dimensions.webMaxWidth,child: WebBannerView())),
        ),
        const SliverToBoxAdapter(child: CategoryView(),),
        const SliverToBoxAdapter(
          child: Center(child: SizedBox(width: Dimensions.webMaxWidth,
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: WebPopularCourseView()),
              ]))),
        ),

        const SliverToBoxAdapter(
          child: Center(child: SizedBox(width: Dimensions.webMaxWidth,
          child: WebInstructorView(),),)
        ),

        const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeDefault,),),
        SliverToBoxAdapter(child: Center(
          child: SizedBox(
            width: Dimensions.webMaxWidth,
            child: Row(
              children: [
                Text(
                  'latest_course'.tr,
                  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),),
        const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeDefault,),),

        SliverToBoxAdapter(child: Center(
          child: SizedBox(
            width: Dimensions.webMaxWidth,
            child: Column(
              children: [
                GetBuilder<CourseController>(builder: (courseController) {
                  if(courseController.serviceContent != null) {
                    return PaginatedListView(
                    scrollController: scrollController,
                    totalSize: courseController.serviceContent!.total,
                    offset: courseController.serviceContent != null ? courseController.serviceContent!.currentPage != null ? courseController.serviceContent!.currentPage! + 1 : null : null,
                    onPaginate: (int offset) async => await courseController.getAllCourseList(offset,false),
                    itemView: CourseViewVertical(
                      course: courseController.serviceContent != null ? courseController.allService : null,
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall,
                        vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : 0,
                      ),
                      type: 'others',
                    ),
                  );
                  }
                  return const SizedBox();
                }),
              ],
            ),
          ),
        ),),
        const SliverToBoxAdapter(child: SizedBox(height: 100.0,),),
        const SliverToBoxAdapter(child: FooterWidget(),),
      ],
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 || oldDelegate.minExtent != 50 || child != oldDelegate.child;
  }
}
