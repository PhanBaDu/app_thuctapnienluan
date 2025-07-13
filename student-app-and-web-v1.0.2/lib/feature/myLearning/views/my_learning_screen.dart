import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/core/helper/decorated_tab_bar.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/home/home_screen.dart';
import 'package:get_lms_flutter/feature/myLearning/controller/mylearning_controller.dart';
import 'package:get_lms_flutter/feature/myLearning/controller/my_learning_video_player_controller.dart';
import 'package:get_lms_flutter/feature/myLearning/model/lastViewedCourse_model.dart';
import 'package:get_lms_flutter/feature/myLearning/model/mylearning_model.dart';
import 'package:get_lms_flutter/feature/myLearning/widgets/my_learning_more.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import '../widgets/my_learning_video_player.dart';

class MyLearningScreen extends StatefulWidget {
  final String courseID;
  const MyLearningScreen({super.key, required this.courseID});

  @override
  State<MyLearningScreen> createState() => _MyLearningScreenState();
}

class _MyLearningScreenState extends State<MyLearningScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'learning_screen'.tr,
      ),
      body: GetBuilder<MyLearningController>(
        initState: (state){
          Get.find<MyLearningController>().getMyLearningResource(offset: 1, isFromPagination: false,courseId: int.parse(widget.courseID));
        },
        builder: (myLearningController){
          if (myLearningController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return FooterBaseWidget(
              child: SizedBox(
                width: Dimensions.webMaxWidth,

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.orange.withOpacity(0.2),
                      child: MyLearningVideoPlayer(sections: myLearningController.sections, courseId: widget.courseID,),
                    ),
                    Flexible(
                      child: CustomScrollView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        slivers: [
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: SliverDelegate(
                              extentSize: 55,
                              child: Container(
                                color: Theme.of(context).cardColor,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                    child: Container(
                                      width: Dimensions.webMaxWidth,
                                      color: Theme.of(context).cardColor,
                                      child: DecoratedTabBar(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Theme.of(context).primaryColor.withOpacity(.3),
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        tabBar: TabBar(
                                            padding: const EdgeInsets.only(top: 3),
                                            unselectedLabelColor: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.4),
                                            controller: myLearningController.controller!,
                                            labelColor: Get.isDarkMode? Colors.white : Theme.of(context).primaryColor,
                                            labelStyle: ubuntuBold,
                                            indicatorColor: Theme.of(context).primaryColor,
                                            // indicatorPadding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                                            labelPadding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                                            indicatorWeight: 1,
                                            indicatorSize: TabBarIndicatorSize.tab,
                                            onTap: (int? index) {
                                              switch (index) {
                                                case 0:
                                                  myLearningController.updatePageState(MyLearningControllerState.lectures);
                                                  break;
                                                case 1:
                                                  myLearningController.updatePageState(MyLearningControllerState.courseOverview);
                                                  break;
                                              }
                                            },
                                            tabs: myLearningController.serviceDetailsTabs()
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeDefault,),),
                          if(myLearningController.currentState == MyLearningControllerState.lectures)
                            SliverList(delegate: SliverChildBuilderDelegate((context, index){
                              return sectionWidget(context,myLearningController.sections!.elementAt(index), index.toString(),myLearningController);
                            }, childCount: myLearningController.sections!.length)),
                          if(myLearningController.currentState == MyLearningControllerState.courseOverview)
                            MyLearningMoreSection(id: widget.courseID),
                          const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeDefault)),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          );
        },
      ),
    );
  }
  Container sectionWidget(BuildContext context, Sections section, String sectionIndex, MyLearningController myLearningController){
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(

        border: Border.all(
          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.06),
          width: 1,
        ),
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall),
        ),
      ),
      child: ExpansionTile(
        initiallyExpanded: myLearningController.lastViewedCourseContent != null ?int.parse(sectionIndex) == myLearningController.lastViewedCourseContent!.lastViewedSection:false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        ),
        title: Text(section.title!,
          style: ubuntuMedium.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontSize: Dimensions.fontSizeDefault),
        ),
        children: [
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context)
                .textTheme
                .bodyLarge!
                .color!
                .withOpacity(0.06),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: section.lessons!.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return lesson(context:context,lesson:section.lessons!.elementAt(index),sectionIndex:sectionIndex, lessonIndex: index.toString(), lastViewedCourseContent: myLearningController.lastViewedCourseContent!);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: section.quizs!.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return quiz(context,section.quizs!.elementAt(index));
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget lesson({required BuildContext context,required Lessons lesson, required String sectionIndex, required String lessonIndex, required LastViewedCourseContent lastViewedCourseContent}) {
    return InkWell(
      onTap: (){
        Get.find<MyVideoPlayerController>().playVideo(
          courseID: widget.courseID,
          sectionIndex: sectionIndex,
          url:lesson.videoLinkPath!,
          // url: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
          lessonId:lesson.id.toString(),
          isLessonCompleted: lesson.isCompleted == '1',
          lastViewedLessonPosition: lessonIndex,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: lastViewedCourseContent.lastViewedLesson == int.parse(lessonIndex) ? Theme.of(context).primaryColor.withOpacity(0.10) : Theme.of(context).cardColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(width: 15),
                  Text(lesson.title!,
                      style: ubuntuRegular.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.6),
                          fontSize: Dimensions.fontSizeSmall)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget quiz(BuildContext context, Quiz quiz) {
    return InkWell(
      onTap: (){
        Get.toNamed(RouteHelper.getQuizStartPage(quiz.id!.toString()));
      },
      child: Padding(
        padding:
        const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // SvgPicture.asset(Images.polygon),
                const SizedBox(width: 15),
                Text(quiz.title!,
                    style: ubuntuRegular.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.6),
                        fontSize: Dimensions.fontSizeSmall)),
              ],
            ),
          ],
        ),
      ),
    );
  }

}