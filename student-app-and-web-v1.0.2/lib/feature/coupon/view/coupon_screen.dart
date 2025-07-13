import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/coupon/controller/coupon_controller.dart';
import 'package:get_lms_flutter/feature/coupon/model/coupon_model.dart';
import 'package:get_lms_flutter/components/list_shimmer.dart';
import 'package:get_lms_flutter/feature/root/view/no_data_screen.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class CouponScreen extends StatefulWidget {

  const CouponScreen({Key? key}) : super(key: key);

  @override
  State<CouponScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<CouponScreen> {
  @override

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(title: "coupon_list".tr, isBackButtonExist: true,),
        body: GetBuilder<CouponController>(
          initState: (state){
            Get.find<CouponController>().getCouponList(1);
          },
          builder: (controller) {
            return FooterBaseWidget(
                child: SizedBox(
                  width: Dimensions.webMaxWidth,
                  child: controller.isLoading? const ListShimmer(): controller.couponList != null && controller.couponList!.isEmpty?
                  EmptyScreen(text: 'no_coupon_available'.tr, type: EmptyScreenType.coupon,):
                  Column(children: [
                    const SizedBox(height: Dimensions.paddingSizeDefault,),
                    ListView.builder(
                      padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,),
                      itemBuilder: (context, index) {
                        Coupon coupon = controller.couponList!.elementAt(index);
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
                                        controller.couponList!.elementAt(index).title!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: ubuntuMedium.copyWith(
                                            fontSize: Dimensions.fontSizeLarge),
                                      ),

                                      CustomButton(
                                        width: 100,
                                        height: 30,
                                        onPressed: (){

                                        },
                                        buttonText: 'copy_coupon'.tr,)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: Dimensions.paddingSizeExtraSmall,
                                  ),
                                  Text(
                                    "${'terms_of_coupon'.tr}: ${'when_paying_more_than'} ${coupon.minPurchase}",
                                    style: ubuntuRegular.copyWith(
                                        fontSize: Dimensions.fontSizeExtraSmall,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color!
                                            .withOpacity(.5)),
                                  ),

                                  Text(
                                    "${'validity'.tr}: until ${controller.couponList!.elementAt(index).endAt}",
                                    style: ubuntuRegular.copyWith(
                                        fontSize: Dimensions.fontSizeExtraSmall,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color!
                                            .withOpacity(.5)),
                                  ),
                                  Text(
                                    "${'type'.tr}: ${controller.couponList!.elementAt(index).discountOn}",
                                    style: ubuntuRegular.copyWith(
                                        fontSize: Dimensions.fontSizeExtraSmall,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color!
                                            .withOpacity(.5)),
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
                        );
                      },
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.couponList!.length,
                    ),
                    controller.isLoading? const CircularProgressIndicator():const SizedBox()
                  ],),
                )
            );
          },
        ));
  }
}










