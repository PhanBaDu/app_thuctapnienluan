import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/components/rating_bar.dart';
import 'package:get_lms_flutter/controller/theme_controller.dart';
import 'package:get_lms_flutter/core/helper/price_converter.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/course/model/course_model.dart';
import 'package:get_lms_flutter/feature/instructor/controller/instructor_controller.dart';
import 'package:get_lms_flutter/feature/instructor/model/instructor_model.dart';
import 'package:get_lms_flutter/feature/splash/controller/splash_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class WebInstructorView extends StatelessWidget {
  const WebInstructorView({super.key});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstructorController>(
      initState: (state){
        Get.find<InstructorController>().getInstructorList(1, false);
      },
      builder: (instructorController){
        if(instructorController.instructorList != null && instructorController.instructorList!.isEmpty){
          return const SizedBox();
        }else{
          if(instructorController.instructorList != null){
            List<Instructor>? instructorList = instructorController.instructorList;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const SizedBox(height: Dimensions.paddingSizeSmall),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('instructor'.tr, style: ubuntuMedium.copyWith(fontSize: 24)),
                      InkWell(
                          onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute("fromPopularCourseView")),
                          child: Text('see_all'.tr, style: ubuntuMedium.copyWith(fontSize: 16,color: Theme.of(context).primaryColor))),
                    ],
                  ),
                ),

                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: .7,
                      crossAxisSpacing: Dimensions.paddingSizeSmall, mainAxisSpacing: Dimensions.paddingSizeDefault,
                      mainAxisExtent: 120
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,

                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  itemCount: instructorList!.length > 5 ? 6 : instructorList.length,
                  itemBuilder: (context, index){
                    return  InkWell(
                      onTap: (){
                        Get.toNamed(RouteHelper.getInstructorScreen(instructorController.instructorList!.elementAt(index)));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(

                            left: index == 0 ? Dimensions.paddingSizeDefault : 0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: const BorderRadius.all(Radius.circular(6))),
                          child: Padding(
                            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                            child: Row(
                              children: [
                                ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                                    child: CustomImage(
                                      image: instructorController.instructorList!.elementAt(index).logo!,
                                      height: 90.0,
                                    )
                                ),
                                const SizedBox(width: Dimensions.paddingSizeSmall),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        instructorController.instructorList!.elementAt(index).name!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: ubuntuMedium.copyWith(
                                            fontSize: Dimensions.fontSizeDefault),
                                      ),
                                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                                      Row(
                                        children: [
                                          Text("Instructor",style: ubuntuRegular.copyWith(color: Theme.of(context).disabledColor),),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                            child: Container(
                                              height: 5,
                                              width: 5,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context).disabledColor,
                                                  borderRadius: const BorderRadius.all(Radius.circular(25))
                                              ),
                                            ),
                                          ),
                                          Text("Designer at Google",style: ubuntuRegular.copyWith(color: Theme.of(context).disabledColor),),
                                        ],
                                      ),
                                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                                      Row(
                                        children: [
                                          Text(
                                            '5.0'.tr,
                                            style:  ubuntuRegular.copyWith(fontSize: Dimensions.paddingSizeDefault, ),),
                                          const SizedBox(width:Dimensions.paddingSizeExtraSmall),
                                          RatingBar(rating: 5.0, size: 15, ratingCount: 5000),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
          else{
            return WebCampaignShimmer(enabled: true,);
          }
        }
      },
    );
  }
}

class ServiceModelView extends StatelessWidget {
  final List<Course> serviceList;
  final int index;
  final int? discountAmount;
  final String? discountAmountType;

  const ServiceModelView({Key? key,
    required this.serviceList,
    required this.index,
    required this.discountAmount,
    required this.discountAmountType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _lowestPrice = 0.0;



    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor ,
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        boxShadow:Get.isDarkMode ?null: [BoxShadow(
          color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]!,
          blurRadius: 5, spreadRadius: .5,
        )],
      ),
      child: Row(children: [
        Stack(children: [
          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  child: CustomImage(
                    image: '${Get.find<SplashController>().configModel.imageBaseUrl!}/service/${serviceList[index].thumbnail}',
                    height: 90, width: 90, fit: BoxFit.cover,
                  ),
                ),

                if( discountAmount != null && discountAmount! > 0) Positioned.fill(
                  child: Align(alignment: Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.error,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(Dimensions.radiusDefault),
                          topRight: Radius.circular(Dimensions.radiusSmall),
                        ),
                      ),
                      child: Text(
                        PriceFormatter.percentageOrAmount('$discountAmount', discountAmountType!),
                        style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColorLight),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: 2),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                serviceList[index].title!,
                style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                maxLines: 1, overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),

              RatingBar(
                rating: double.parse(serviceList[index].totalRating.toString()), size: 15,
                ratingCount: int.parse(serviceList[index].totalRating!),
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),

              Text(serviceList[index].subTitle!,
                style: ubuntuLight.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
                maxLines: 2, overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if(discountAmount! > 0)
                    Text(PriceFormatter.formatPrice(_lowestPrice),
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                          decoration: TextDecoration.lineThrough,
                          color: Theme.of(context).colorScheme.error.withOpacity(.8)),
                    ),

                  discountAmount! > 0?
                  Text(PriceFormatter.formatPrice(_lowestPrice,
                      discount: discountAmount!.toDouble(),
                      discountType: discountAmountType
                  ),
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.paddingSizeDefault,
                        color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                  ): Text(PriceFormatter.formatPrice(_lowestPrice),
                    style: ubuntuRegular.copyWith(
                        fontSize: Dimensions.paddingSizeDefault,
                        color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                  ),

                  // InkWell(
                  //   onTap: ()=>  Get.bottomSheet(ServiceCenterDialog(service: serviceList[index])),
                  //   child: Icon(Icons.add, color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor,
                  //       size: Dimensions.paddingSizeLarge),
                  // ),
                ],
              ),
            ]),
          ),
        ),

      ]),
    );
  }
}


class WebCampaignShimmer extends StatelessWidget {
  final bool enabled;
  WebCampaignShimmer({super.key, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.webMaxWidth / 3.5,
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
            itemCount: 5,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                child: Container(
                  height: 120, width: 200,
                  margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
                  ),
                  child: Shimmer(
                    duration: const Duration(seconds: 1),
                    interval: const Duration(seconds: 1),
                    enabled: enabled,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start, children: [

                      Container(
                        height: 120, width: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                            color: Colors.grey[300]
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                          Container(height: 15, width: 100, color: Colors.grey[300]),
                          const SizedBox(height: 5),
                          RatingBar(rating: 0.0, size: 12, ratingCount: 0),
                          const SizedBox(height: 5),
                          Container(height: 10, width: 130, color: Colors.grey[300]),
                          const SizedBox(height: 20),
                          Container(height: 10, width: 30, color: Colors.grey[300]),
                        ]),
                      ),
                    ]),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


