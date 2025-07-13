import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/feature/enrolmentHistory/controller/enrolment_controller.dart';
import 'package:get_lms_flutter/components/list_shimmer.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class EnrolmentDetailsScreen extends StatefulWidget {
  final String enrolmentId;

  const EnrolmentDetailsScreen({Key? key, required this.enrolmentId}) : super(key: key);

  @override
  State<EnrolmentDetailsScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<EnrolmentDetailsScreen> {
  @override

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(title: "enrolment_details".tr, isBackButtonExist: true,),
        body: GetBuilder<EnrolmentController>(
          initState: (state){
            Get.find<EnrolmentController>().getEnrolmentDetails(int.parse(widget.enrolmentId));
          },
          builder: (controller) {
            return FooterBaseWidget(child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: controller.isLoading? const ListShimmer(): Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Column(children: [
                  const SizedBox(height: Dimensions.paddingSizeDefault,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                    ),
                    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text( "${'date'.tr}: ${controller.enrolmentDetails!.updatedAt!}",
                          style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
                        Text( "${'order_id'.tr}: ${controller.enrolmentDetails!.id!}",style: ubuntuRegular,),
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault,),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      children: [
                        ListView.builder(
                          itemCount: controller.enrolmentDetails?.enrolmentItems!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(6))),
                              child: Padding(
                                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${controller.enrolmentDetails?.enrolmentItems!.elementAt(index).course!.title!}",
                                      style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                                    ),
                                    Text(
                                      "${'price'.tr}: ${controller.enrolmentDetails?.enrolmentItems!.elementAt(index).price!}",
                                      maxLines: 2,
                                      style: ubuntuMedium.copyWith(
                                          fontSize: Dimensions.fontSizeLarge),
                                    ),
                                    const SizedBox(
                                      height: Dimensions.paddingSizeExtraSmall,
                                    ),
                                    Text(
                                      "${'discount'.tr}: ${controller.enrolmentDetails?.enrolmentItems!.elementAt(index).discount}",
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
                                          "${'created_at'.tr}: 20 Jan 2023",
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
                            );
                          },
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          child: Column(
                            children: [
                              summeryWidget('coupon_discount'.tr, controller.enrolmentDetails!.couponDiscount!.toString()),
                              summeryWidget('promotional_discount'.tr, controller.enrolmentDetails!.promotionalDiscount!.toString()),
                              summeryWidget('amount'.tr, controller.enrolmentDetails!.amount!.toString()),
                              const Divider(),
                              summeryWidget('total_paid'.tr, controller.enrolmentDetails!.amount!.toString()),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  controller.isLoading? const CircularProgressIndicator():const SizedBox()
                ],),
              ),
            ));
          },
        ));
  }

  Widget summeryWidget(String title, String data){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(.5)),),
        Text(data,style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(.5)),),

      ],
    );
  }
}










