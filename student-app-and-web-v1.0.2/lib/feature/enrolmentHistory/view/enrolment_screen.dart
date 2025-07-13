import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/enrolmentHistory/controller/enrolment_controller.dart';
import 'package:get_lms_flutter/feature/enrolmentHistory/model/enrolment_model.dart';
import 'package:get_lms_flutter/components/list_shimmer.dart';
import 'package:get_lms_flutter/feature/root/view/no_data_screen.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class EnrolmentScreen extends StatefulWidget {

  const EnrolmentScreen({Key? key}) : super(key: key);

  @override
  State<EnrolmentScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<EnrolmentScreen> {
  @override

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(title: "enrolment_list".tr, isBackButtonExist: true,),
        body: GetBuilder<EnrolmentController>(
          initState: (state){
            Get.find<EnrolmentController>().getEnrolmentList(1);
          },
          builder: (controller) {
            printLog(controller.enrolmentList!.length);

            return FooterBaseWidget(child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: controller.isLoading? const ListShimmer(): controller.enrolmentList != null && controller.enrolmentList!.isEmpty?
              EmptyScreen(text: 'no_enrolment_found'.tr, type: EmptyScreenType.enrolment,):
              SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(children: [
                  const SizedBox(height: Dimensions.paddingSizeDefault,),
                  ListView.builder(
                    padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,),
                    itemBuilder: (context, index) {
                      Enrolment enrolment = controller.enrolmentList!.elementAt(index);
                      return InkWell(
                          onTap: (){
                            Get.toNamed(RouteHelper.getEnrolmentDetails(controller.enrolmentList!.elementAt(index).id.toString()));
                          },
                          child: Padding(
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
                                    Text(
                                      "${'enrolment_id'.tr}: ${enrolment.id!}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: ubuntuMedium.copyWith(
                                          fontSize: Dimensions.fontSizeLarge),
                                    ),
                                    const SizedBox(
                                      height: Dimensions.paddingSizeExtraSmall,
                                    ),
                                    Text(
                                      "${'payment_status'.tr}: ${enrolment.status}",
                                      style: ubuntuRegular.copyWith(
                                          fontSize: Dimensions.fontSizeExtraSmall,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color!
                                              .withOpacity(.5)),
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${'created_at'.tr}: ${enrolment.createdAt}",
                                          style: ubuntuRegular.copyWith(
                                              fontSize: Dimensions.fontSizeExtraSmall,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .color!
                                                  .withOpacity(.5)),
                                        ),

                                        Text(
                                          "${'status'.tr}: Pending",
                                          style: ubuntuRegular.copyWith(
                                              fontSize: Dimensions.fontSizeExtraSmall,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .color!
                                                  .withOpacity(.5)),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${'amount'.tr}: 150",
                                      style: ubuntuRegular.copyWith(
                                          fontSize: Dimensions.fontSizeExtraSmall,
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
                          )
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.enrolmentList!.length,
                  ),
                  controller.isLoading? const CircularProgressIndicator():const SizedBox()
                ],),
              ),
            ));
          },
        ));
  }
}










