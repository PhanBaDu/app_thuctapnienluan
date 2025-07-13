import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/text_hover.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/data/model/response/config_model.dart';
import 'package:get_lms_flutter/feature/splash/controller/splash_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});


  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).textTheme.bodySmall!.color!;
    return GetBuilder<SplashController>(
        builder: (controller){
          ConfigContent configContent = controller.configModel;
          return configContent.businessName != null ?  Container(
            color: Theme.of(context).primaryColor.withOpacity(0.10),
            width: double.maxFinite,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: Dimensions.webMaxWidth,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: Dimensions.paddingSizeLarge ),
                                FittedBox(
                                  child: Text(configContent.businessName!, maxLines: 1,
                                    style: TextStyle(fontWeight: FontWeight.w800,fontSize: 30,color: Theme.of(context).primaryColor),),
                                ),
                                Text(configContent.businessAddress??'', style: ubuntuRegular.copyWith(fontWeight: FontWeight.w600, color: color)),
                                const SizedBox(height: Dimensions.paddingSizeSmall),

                                GetBuilder<SplashController>(
                                    builder: (splashController){
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Connect with our social media pages and helps us provide you the best services near you'.tr, style: ubuntuRegular.copyWith(color: color,fontSize: Dimensions.fontSizeDefault)),
                                          const SizedBox(height: Dimensions.paddingSizeSmall,),
                                          contactInfo(Images.telephone,configContent.businessPhone??'',context),
                                          const SizedBox(height: Dimensions.paddingSizeSmall,),
                                          contactInfo(Images.mail,configContent.businessEmail??'',context),
                                        ],
                                      );
                                    })

                              ],
                            )),
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: Dimensions.paddingSizeLarge * 2),
                              Text( 'download_our_apps'.tr, style: ubuntuRegular.copyWith(color: color,fontSize: Dimensions.fontSizeExtraLarge)),
                              const SizedBox(height: Dimensions.paddingSizeSmall),
                              Text( 'download_our_apps_from_google_play_store'.tr, style: ubuntuBold.copyWith(color: color,fontSize: Dimensions.fontSizeExtraSmall)),
                              const SizedBox(height: Dimensions.paddingSizeLarge),

                              Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(onTap:(){
                                    _launchURL(Get.find<SplashController>().configModel.appUrlAndroid!);
                                  },child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Image.asset(Images.playStoreIcon,height: 50,fit: BoxFit.contain),
                                  )),
                                  InkWell(onTap:(){
                                    _launchURL(Get.find<SplashController>().configModel.appUrlIos!);
                                  },child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Image.asset(Images.appStoreIcon,height: 50,fit: BoxFit.contain),
                                  )),
                                ],)
                            ],
                          ),
                        ),
                        Expanded(flex: 2,child: Padding(
                          padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: Dimensions.paddingSizeLarge * 2),
                              GetLearnTextButton(title: 'privacy_policy'.tr, route: RouteHelper.getProfileRoute('')),
                              const SizedBox(height: Dimensions.paddingSizeSmall),
                              GetLearnTextButton(title: 'terms_and_conditions'.tr, route:RouteHelper.getProfileRoute('')),
                              const SizedBox(height: Dimensions.paddingSizeSmall),
                              GetLearnTextButton(title: 'about_us'.tr, route: RouteHelper.getProfileRoute('')),
                              const SizedBox(height: Dimensions.paddingSizeSmall),
                              GetLearnTextButton(title: 'contact_us'.tr, route:RouteHelper.getSupportRoute()),
                              const SizedBox(height: Dimensions.paddingSizeSmall),


                            ],),
                        )),
                        Expanded(flex:2,child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: Dimensions.paddingSizeLarge * 2),
                            GetLearnTextButton(title: 'current_offers'.tr, route: RouteHelper.getSupportRoute()),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            GetLearnTextButton(title: 'popular_courses'.tr, route: RouteHelper.allServiceScreenRoute("fromPopularCourseView")),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            GetLearnTextButton(title: 'categories'.tr, route: RouteHelper.getCategoryRoute('homePage','123')),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            GetLearnTextButton(title: 'become_a_instructor'.tr, route: RouteHelper.getProfileRoute('')),
                            const SizedBox(height: Dimensions.paddingSizeSmall),

                          ],)),
                      ],
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  Container(
                      width: double.maxFinite,
                      color: const Color(0xff253036),
                      child: Padding(
                        padding:  const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraLarge),
                        child: Center(child: Text('All rights reserved By@Get learn'.tr,style: ubuntuRegular.copyWith(color: Colors.white,fontSize: Dimensions.fontSizeDefault),)),
                      )),
                ],
              ),
            ),
          ):Container();
    });
  }

  Widget contactInfo(String imagePath, String text,context){
    return  Row(
      children: [
        Image.asset(imagePath,scale: 3,color: Theme.of(context).textTheme.bodySmall!.color,),
        const SizedBox(width: Dimensions.paddingSizeMint,),
        Text(text,style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodySmall!.color),)
      ],
    );
  }
}
_launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}



class GetLearnTextButton extends StatelessWidget {
  final String title;
  final String route;
  final bool url;
  const GetLearnTextButton({super.key, required this.title, required this.route, this.url = false});

  @override
  Widget build(BuildContext context) {
    return TextHover(builder: (hovered) {
      return InkWell(
        hoverColor: Colors.transparent,
        onTap: route.isNotEmpty ? () async {
          if(url) {
            if(await canLaunchUrlString(route)) {
              launchUrlString(route, mode: LaunchMode.externalApplication);
            }
          }else {
            Get.toNamed(route);
          }
        } : null,
        child: Text(title, style: hovered ? ubuntuMedium.copyWith(color: Theme.of(context).colorScheme.error, fontSize: Dimensions.fontSizeSmall)
            : ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodySmall!.color, fontSize: Dimensions.fontSizeExtraSmall)),
      );
    });
  }
}