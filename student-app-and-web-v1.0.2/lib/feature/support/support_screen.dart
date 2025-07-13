import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/feature/splash/controller/splash_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/gaps.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {

  ContactUsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'contact_us'.tr,),
      body: Center(
        child: FooterBaseWidget(
          child: SizedBox(
            width: Dimensions.webMaxWidth,
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(text: 'normally_the_support_team_send_you'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
                        TextSpan(
                          text: 'customer_support_executive'.tr,
                          style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge,),

                  contactWithEmailOrPhone(
                      'contact_us_through_email'.tr,"${'mail_us'.tr}\n ${Get.find<SplashController>().configModel.businessPhone.toString()}",
                      "typically_the_support_team_send_you_any_feedback".tr,context, true),
                  const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                  contactWithEmailOrPhone('contact_us_through_phone'.tr,'call_us'.tr,"talk_with_our_customer".tr,context,false),


                  Gaps.verticalGapOf(Dimensions.paddingSizeExtraLarge),
                  Gaps.verticalGapOf(Dimensions.paddingSizeSmall),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }

  Widget contactWithEmailOrPhone(String title,String subTitle,String message,context, bool isEmail){
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
              if(isEmail)
              _emailCallButton(
                  context,
                  'email'.tr,
                  Icons.email,
                  email
              ),
              if(!isEmail)
              _emailCallButton(
                  context,
                  'call'.tr,
                  Icons.call,
                  launchUri
              ),
            ],
          ),
          Text(subTitle),
          const SizedBox(height: Dimensions.paddingSizeSmall,),
        ],
      ),
    );
  }

  _emailCallButton(context,String title,IconData iconData,Uri uri){
    return InkWell(
        onTap: () async{
           await launchUrl(uri);
        },
        child: Row(
          children: [
            Icon(iconData,color: Theme.of(context).primaryColor,),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
            Text(title,style: ubuntuRegular.copyWith(color: Theme.of(context).primaryColor),)
          ],
        ));
  }

  //dummy data willl be removed soon
  final Uri launchUri =  Uri(
    scheme: 'tel',
    path: Get.find<SplashController>().configModel.businessPhone.toString(),
  );
  final Uri email =  Uri(
    scheme: 'mailto',
    path: Get.find<SplashController>().configModel.businessEmail,
  );
}