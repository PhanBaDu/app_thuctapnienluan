import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/feature/home/controller/banner_controller.dart';
import 'package:get_lms_flutter/feature/splash/controller/splash_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class WebBannerView extends GetView<BannerController> {
  const WebBannerView({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return GetBuilder<BannerController>(
      initState: (state){
        Get.find<BannerController>().getBannerList(true);
      },
      builder: (bannerController){
        return Container(
          alignment: Alignment.center,
          child: SizedBox(width: Dimensions.webMaxWidth, height: 220, child: bannerController.banners != null ? Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [

              PageView.builder(
                controller: pageController,
                itemCount: (bannerController.banners!.length/2).ceil(),
                itemBuilder: (context, index) {
                  int index1 = index * 2;
                  int index2 = (index * 2) + 1;
                  bool hasSecond = index2 < bannerController.banners!.length;
                  return Row(children: [
                    Expanded(child: InkWell(
                      // onTap: () => _onTap(index1, context),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                        child: CustomImage(
                          image: "${bannerController.banners![index1].bannerImage}", fit: BoxFit.cover, height: 220,
                        ),
                      ),
                    )),

                    const SizedBox(width: Dimensions.paddingSizeLarge),

                    Expanded(child: hasSecond ? InkWell(
                      // onTap: () => _onTap(index2, context),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                        child: CustomImage(
                          image: '${bannerController.banners![index2].bannerImage}', fit: BoxFit.cover, height: 220,
                        ),
                      ),
                    ) : const SizedBox()),

                  ]);
                },
                onPageChanged: (int index) => bannerController.setCurrentIndex(index, true),
              ),

              bannerController.currentIndex != 0 ? Positioned(
                top: 0, bottom: 0, left: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                  child: InkWell(
                    onTap: () => pageController.previousPage(duration: const Duration(seconds: 1), curve: Curves.easeInOut),
                    child: Container(
                      height: 40, width: 40, alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Theme.of(context).cardColor,
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              ) : const SizedBox(),

              bannerController.currentIndex != ((bannerController.banners!.length/2).ceil()-1) ? Positioned(
                top: 0, bottom: 0, right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
                  child: InkWell(
                    onTap: () => pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeInOut),
                    child: Container(
                      height: 40, width: 40, alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Theme.of(context).cardColor,
                      ),
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              ) : const SizedBox(),

            ],
          )
              : const WebBannerShimmer()),
        );
      },
    );
  }

}

class WebBannerShimmer extends StatelessWidget {
  const WebBannerShimmer({super.key});


  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(seconds: 2),
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
        child: Row(children: [

          Expanded(child: Container(
            height: 220,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusSmall), color: Colors.grey[300]),
          )),

          const SizedBox(width: Dimensions.paddingSizeLarge),

          Expanded(child: Container(
            height: 220,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusSmall), color: Colors.grey[300]),
          )),
        ]),
      ),
    );
  }
}

