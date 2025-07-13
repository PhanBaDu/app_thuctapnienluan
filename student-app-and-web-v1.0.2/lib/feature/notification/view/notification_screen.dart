import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/feature/notification/controller/notification_controller.dart';
import 'package:get_lms_flutter/components/list_shimmer.dart';
import 'package:get_lms_flutter/feature/root/view/no_data_screen.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(title: "notifications".tr, isBackButtonExist: true,),
        body: GetBuilder<NotificationController>(
          initState: (state){
            Get.find<NotificationController>().getNotifications(1);
          },
          builder: (controller) {
            return controller.isLoading? const ListShimmer(): controller.notificationList!.isEmpty ?
            EmptyScreen(text: 'no_notification_found'.tr):
            CustomScrollView(
                controller: controller.scrollController,
                slivers: [
                  SliverToBoxAdapter(child: Column(children: [
                    ListView.builder(
                      padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      itemBuilder: (context, index) {
                        return Container(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical: Dimensions.paddingSizeSmall),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CustomImage(
                                        image: controller.notificationList!.elementAt(index).coverImage,
                                        height: 30,
                                        width: 30,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: Dimensions.paddingSizeDefault,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(controller.notificationList!.elementAt(index).title.toString().trim(),
                                              style: ubuntuMedium.copyWith(color: Theme.of(context).
                                              textTheme.bodyMedium!.color!.withOpacity(0.7) ,
                                                  fontSize: Dimensions.fontSizeDefault
                                              )),
                                          const SizedBox(height: Dimensions.paddingSizeSmall,),
                                          Text("${controller.notificationList!.elementAt(index).description}",
                                              maxLines: 2,
                                              style: ubuntuRegular.copyWith(color: Theme.of(context).
                                              textTheme.bodyMedium!.color!.withOpacity(0.5) ,
                                                  fontSize: Dimensions.fontSizeDefault
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                        );
                      },
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.notificationList!.length,
                    ),
                    controller.isLoading? const CircularProgressIndicator():const SizedBox()
                  ],),)
                ]);
          },
        ));
  }
}










