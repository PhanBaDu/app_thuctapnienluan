import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/controller/theme_controller.dart';
import 'package:get_lms_flutter/feature/home/controller/banner_controller.dart';
import 'package:get_lms_flutter/feature/home/model/banner_model.dart';
import 'package:get_lms_flutter/feature/splash/controller/splash_controller.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PromotionalBannerView extends StatelessWidget {
  const PromotionalBannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(
      builder: (bannerController) {
        return (bannerController.banners != null && bannerController.banners!.isEmpty)
            ? const SizedBox()
            : Container(
                width: MediaQuery.of(context).size.width,
                height: GetPlatform.isDesktop ? 500 : MediaQuery.of(context).size.width * 0.45,
                padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                child: bannerController.banners != null ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: CarouselSlider.builder(
                              options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: false,
                                viewportFraction: .92,
                                disableCenter: true,
                                autoPlayInterval: const Duration(seconds: 7),
                                onPageChanged: (index, reason) {
                                  bannerController.setCurrentIndex(index, true);
                                },
                              ),
                              itemCount: bannerController.banners!.isEmpty ? 1 : bannerController.banners!.length,
                              itemBuilder: (context, index, _) {
                                BannerModel bannerModel = bannerController.banners![index];
                                return InkWell(
                                  onTap: () {
                                    String link = bannerModel.redirectLink != null ? bannerModel.redirectLink! : '';
                                    String id = bannerModel.category != null ? bannerModel.category!.id! : '';
                                    String name = bannerModel.category != null ? bannerModel.category!.name! : "";
                                    bannerController.navigateFromBanner(bannerModel.resourceType!, id, link, bannerModel.resourceId != null ? bannerModel.resourceId! : '', categoryName: name);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions.paddingSizeExtraSmall),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                        boxShadow: shadow,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                        child: GetBuilder<SplashController>(
                                          builder: (splashController) {
                                            return CustomImage(
                                              image: '${bannerController.banners![index].bannerImage}',
                                              fit: BoxFit.cover,
                                              placeholder: Images.dummyBanner,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                          Align(
                            alignment: Alignment.center,
                            child: AnimatedSmoothIndicator(
                              activeIndex: bannerController.currentIndex!,
                              count: bannerController.banners!.length,
                              effect: ExpandingDotsEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                activeDotColor: Theme.of(context).primaryColor,
                                dotColor: Theme.of(context).disabledColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Shimmer(
                        duration: const Duration(seconds: 2),
                        enabled: true,
                        child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                              color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
                            ))));
      },
    );
  }
}
