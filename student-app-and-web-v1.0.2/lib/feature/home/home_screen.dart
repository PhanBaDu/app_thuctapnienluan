import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/home_screen_app_bar.dart';
import 'package:get_lms_flutter/components/course_view_verticle.dart';
import 'package:get_lms_flutter/components/paginated_list_view.dart';
import 'package:get_lms_flutter/components/web_menu_bar.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/category/controller/category_controller.dart';
import 'package:get_lms_flutter/feature/course/controller/course_controller.dart';
import 'package:get_lms_flutter/feature/home/widget/banner_view.dart';
import 'package:get_lms_flutter/feature/home/widget/category_view.dart';
import 'package:get_lms_flutter/feature/home/widget/instructor_view.dart';
import 'package:get_lms_flutter/feature/home/widget/feature_course_view.dart';
import 'package:get_lms_flutter/feature/instructor/controller/instructor_controller.dart';
import 'package:get_lms_flutter/feature/root/view/no_data_screen.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'controller/banner_controller.dart';
import 'web_home_screen.dart';

class HomeScreen extends StatefulWidget {


  static Future<void> loadData(bool reload) async {
    Get.find<BannerController>().getBannerList(reload);
    Get.find<CategoryController>().getCategoryList(1,reload);
    Get.find<InstructorController>().getInstructorList(1,reload);
    Get.find<CourseController>().getPopularServiceList(reload,offset: 1,);
    Get.find<CourseController>().getAllCourseList(1,reload);
  }


  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    HomeScreen.loadData(false);
  }

  homeAppBar(){
    if(ResponsiveHelper.isDesktop(context)){
      return const WebMenuBar();
    }else{
      return PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child:  Container(
          width: Dimensions.webMaxWidth, height: 80, color: Theme.of(context).primaryColor,
          child: const HomeScreenAppBar(backButton: false),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      appBar: homeAppBar(),
      body: ResponsiveHelper.isDesktop(context) ? WebHomeScreen(scrollController: _scrollController) : SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Get.find<BannerController>().getBannerList(true);
            await Get.find<CategoryController>().getCategoryList(1,true);
            await Get.find<InstructorController>().getInstructorList(1,true);
            await Get.find<CourseController>().getPopularServiceList(true,offset: 1,);
            await Get.find<CourseController>().getAllCourseList(1,true);
          },
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: CustomScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(height: 10.0,),),
                // Search Button
                SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverDelegate(
                        extentSize: 55,
                        child: InkWell(
                          onTap: () => Get.toNamed(RouteHelper.getSearchResultRoute()),
                          child: Padding(
                            padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault,right: Dimensions.paddingSizeDefault,top: Dimensions.paddingSizeExtraSmall),
                            child: Container(
                              padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeExtraSmall),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border:Get.isDarkMode ? Border.all(color: Colors.grey.shade700):null,
                                  boxShadow:Get.isDarkMode ?null: [BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 5, spreadRadius: 1)],
                                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                  color: Theme.of(context).cardColor
                              ),
                              child: Row(mainAxisAlignment : MainAxisAlignment.start, children: [
                                Image.asset(Images.search,scale: 2,),
                                const SizedBox(width: Dimensions.paddingSizeDefault,),
                                Text('search_courses'.tr, style: ubuntuRegular.copyWith(color: Theme.of(context).hintColor)),
                              ]),
                            ),
                          ),
                        ))),
                 SliverToBoxAdapter(
                  child: Center(child: SizedBox(width: Dimensions.webMaxWidth, child: Column(children: [
                    const PromotionalBannerView(),
                    const CategoryView(),
                    const SizedBox(height: Dimensions.paddingSizeLarge),
                    const FeaturedCourseView(),
                    const SizedBox(height: Dimensions.paddingSizeLarge),
                    const FeaturedInstructorView(),
                    const SizedBox(height: Dimensions.paddingSizeLarge),
                    GetBuilder<CourseController>(builder: (courseController) {
                      if(courseController.serviceContent != null) {
                        return PaginatedListView(
                         scrollController: _scrollController,
                         totalSize: courseController.serviceContent!.total,
                         offset: courseController.serviceContent != null ? courseController.serviceContent!.currentPage != null ? courseController.serviceContent!.currentPage! + 1 : null : null,
                         onPaginate: (int offset) async => await courseController.getAllCourseList(offset, false),
                         itemView: CourseViewVertical(
                           course: courseController.serviceContent != null ? courseController.allService : null,
                           padding: EdgeInsets.symmetric(
                             horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeDefault,
                             vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : 0,
                           ),
                           type: 'others',
                           noDataType: EmptyScreenType.home,
                         ),
                      );
                      }
                      return Container();
                    }),
                    const SizedBox(height: 100,),
                  ]))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget? child;
  double? extentSize;

  SliverDelegate({@required this.child,@required this.extentSize});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child!;
  }

  @override
  double get maxExtent => extentSize!;

  @override
  double get minExtent => extentSize!;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != maxExtent || child != oldDelegate.child;
  }
}
