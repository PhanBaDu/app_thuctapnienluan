import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_snackbar.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/myLearning/controller/mylearning_controller.dart';
import 'package:get_lms_flutter/feature/profile/model/profile_cart_item_model.dart';
import 'package:get_lms_flutter/feature/profile/widget/profile_card.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:url_launcher/url_launcher.dart';

class MyLearningMoreSection extends StatelessWidget {

  final String? id;
  const MyLearningMoreSection({super.key, required this.id});

  @override
  Widget build(BuildContext context) {

    final profileCartModelList = [
      ProfileCardItemModel(
        'about_this_course'.tr, Images.aboutCourse, RouteHelper.getCourseDetailsRoute(id!.toString()),
      ),
      ProfileCardItemModel(
        'course_certificate'.tr, Images.courseCertificate, RouteHelper.getCertificate(),
      ),
      ProfileCardItemModel(
        'share_this_course'.tr, Images.shareCourse, RouteHelper.getSettingRoute(),
      ),
      ProfileCardItemModel(
        'resource'.tr, Images.resource, RouteHelper.getCourseResourceScreen(id!),
      ),
      ProfileCardItemModel(
        'assignment'.tr, Images.inboxProfile, RouteHelper.getAssignmentList(id!),
      ),
      ProfileCardItemModel(
        'add_to_favourite'.tr, Images.addToFavourite, RouteHelper.getSettingRoute(),
      ),
    ];


    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
        childAspectRatio: 6,
        crossAxisSpacing: Dimensions.paddingSizeExtraLarge,
        mainAxisSpacing: Dimensions.paddingSizeSmall,
      ),
      itemCount: profileCartModelList.length,
      itemBuilder: (context, index) {
        return ProfileCardItem(
          title: profileCartModelList[index].title,
          leadingIcon: profileCartModelList[index].loadingIcon,
          onTap: () async {
            if(profileCartModelList[index].routeName == RouteHelper.getCertificate()){
              String certificateDownloadLink = await Get.find<MyLearningController>().getCertificate(courseID: id!,);
              if(certificateDownloadLink != ''){
                try {
                  await launchUrl(Uri.parse(certificateDownloadLink),
                      mode:
                      LaunchMode.externalApplication);
                } catch (e) {
                  customSnackBar('can_not_open_the_link'.tr, isError: true);
                }
              }else{
                customSnackBar('you_should_complete_the_course_to_get_certificate'.tr);
              }


            }else{
              Get.toNamed(profileCartModelList[index].routeName);
            }
          },
        );
      },
    );
  }
}
