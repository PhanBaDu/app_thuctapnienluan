import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/components/custom_snackbar.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/core/helper/date_converter.dart';
import 'package:get_lms_flutter/feature/coupon/controller/coupon_controller.dart';
import 'package:get_lms_flutter/feature/coupon/model/coupon_model.dart';
import 'package:get_lms_flutter/components/list_shimmer.dart';
import 'package:get_lms_flutter/feature/meetings/controller/meeting_controller.dart';
import 'package:get_lms_flutter/feature/meetings/model/meeting_model.dart';
import 'package:get_lms_flutter/feature/root/view/no_data_screen.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class MeetingScreen extends StatefulWidget {

  const MeetingScreen({Key? key}) : super(key: key);

  @override
  State<MeetingScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<MeetingScreen> {
  @override

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(title: "meeting_list".tr, isBackButtonExist: true,),
        body: GetBuilder<MeetingController>(
          initState: (state){
            Get.find<MeetingController>().getMeetingList(1);
          },
          builder: (controller) {
            return FooterBaseWidget(
                child: SizedBox(
                  width: Dimensions.webMaxWidth,
                  child: controller.isLoading? const ListShimmer(): controller.meetingList != null && controller.meetingList!.isEmpty?
                  EmptyScreen(text: 'no_meeting_available'.tr, type: EmptyScreenType.meetings,):
                  Column(children: [
                    const SizedBox(height: Dimensions.paddingSizeDefault,),
                    ListView.builder(
                      padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,),
                      itemBuilder: (context, index) {
                        Meeting coupon = controller.meetingList!.elementAt(index);
                        return Padding(
                          padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall,),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: const BorderRadius.all(Radius.circular(6))),
                            child: Padding(
                              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Meetings",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                                      ),

                                      CustomButton(
                                        width: 100,
                                        height: 30,
                                        onPressed: () async {

                                          if(controller.meetingList!.elementAt(index).status != '1'){
                                            customSnackBar("meeting_is_not_ready_join".tr);
                                          }else{
                                            final uri = Uri.parse(controller.meetingList!.elementAt(index).meetingLink!);
                                            if (await canLaunchUrl(uri)) {
                                              await launchUrl(uri);
                                            }
                                          }
                                        },
                                        buttonText: 'join_meeting'.tr,)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: Dimensions.paddingSizeExtraSmall,
                                  ),


                                  Text(
                                    "${'meeting_date_time'.tr}: ${DateConverter.convertStringTimeToDateOnly(controller.meetingList!.elementAt(index).meetingDate!)}",
                                    style: ubuntuRegular.copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color!
                                            .withOpacity(.5)),
                                  ),
                                  Text(
                                    "${'status'.tr}: ${controller.meetingList!.elementAt(index).status}",
                                    style: ubuntuRegular.copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color!
                                            .withOpacity(.5)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.meetingList!.length,
                    ),
                    controller.isLoading? const CircularProgressIndicator():const SizedBox()
                  ],),
                )
            );
          },
        ));
  }
}










