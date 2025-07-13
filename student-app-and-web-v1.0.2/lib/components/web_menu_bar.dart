import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/web_search_widget.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/cart/controller/cart_controller.dart';
import 'package:get_lms_flutter/feature/splash/controller/splash_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class WebMenuBar extends StatelessWidget implements PreferredSizeWidget {
  const WebMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          color: Theme.of(context).primaryColor.withOpacity(0.10),
          alignment: Alignment.center,
          child: SizedBox(
            width: Dimensions.webMaxWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    callOrMessage(Images.telephone,Get.find<SplashController>().configModel.businessPhone??'',context),
                    const SizedBox(width: Dimensions.paddingSizeLarge,),
                    callOrMessage(Images.mail,Get.find<SplashController>().configModel.businessEmail??'',context),
                  ],
                ),
                MenuIconButton( icon: Icons.shopping_cart_outlined, isCart: true, onTap: () => Get.toNamed(RouteHelper.getCartRoute())),
              ],
            ),
          ),
        ),
        Container(
          width: Dimensions.webMaxWidth,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(Dimensions.radiusLarge),bottomLeft: Radius.circular(Dimensions.radiusLarge))
          ),
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Get.toNamed(RouteHelper.getInitialRoute()),
                  child: Image.asset(Images.logo, height: 50, width: 50),
                ),
                MenuButtonWeb( title: 'home'.tr, onTap: () => Get.toNamed(RouteHelper.getInitialRoute())),
                const SizedBox(width: 20),
                MenuButtonWeb( title: 'categories'.tr, onTap: () => Get.toNamed(RouteHelper.getCategoryRoute('homePage','123'))),
                const SizedBox(width: 20),
                MenuButtonWeb( title: 'courses'.tr, onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute('allCourses'))),
                const SizedBox(width: 20),
                ///search widget
                const SearchWidgetWeb(),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 20),

                InkWell(
                  onTap: (){
                    Get.toNamed(RouteHelper.getSettingRoute());
                  },
                  child: Image.asset(Images.settings,scale: 7,color: Theme.of(context).textTheme.bodySmall!.color,),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault),
                MenuIconButton(icon: Icons.person_outline_sharp, onTap: () {
                  Get.toNamed(RouteHelper.getProfileRoute(''));
                }),
                const SizedBox(width: 20),
                GetBuilder<AuthController>(
                    builder: (authController){
                      return InkWell(
                        onTap: () {
                          authController.isLoggedIn() ? Get.toNamed(RouteHelper.getMyCourseScreen()) : Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          ),
                          child: Text(authController.isLoggedIn() ? 'my_courses'.tr : 'sign_in'.tr, style: ubuntuRegular.copyWith(color: Colors.white)),
                        ),
                      );
                    }
                ),
              ],
            )

          ]),
        ),
      ],
    ));
  }
  @override
  Size get preferredSize => const Size(Dimensions.webMaxWidth, 110);

  Widget callOrMessage(String imagePath, String text,context){
    return  Row(
      children: [
        Image.asset(imagePath,color: Theme.of(context).textTheme.bodySmall!.color,
          scale: 3,),
        const SizedBox(width: Dimensions.paddingSizeMint,),
        Text(text,style: ubuntuRegular,)
      ],
    );
  }
}

class MenuIconButton extends StatelessWidget {
  final IconData? icon;
  final bool isCart;
  final Function() onTap;
  const MenuIconButton({super.key, @required this.icon, this.isCart = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(children: [
        Stack(clipBehavior: Clip.none, children: [

          Icon(icon, size: 20),

          isCart ? GetBuilder<CartController>(builder: (cartController) {
            return cartController.cartList.isNotEmpty ? Positioned(
              top: -5, right: -5,
              child: Container(
                height: 15, width: 15, alignment: Alignment.center,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                child: Text(
                  cartController.cartList.length.toString(),
                  style: ubuntuRegular.copyWith(fontSize: 12, color: Theme.of(context).cardColor),
                ),
              ),
            ) : const SizedBox();
          }) : const SizedBox(),
        ]),
        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
      ]),
    );
  }
}

class MenuButtonWeb extends StatelessWidget {
  final String? title;
  final bool isCart;
  final Function() onTap;
  const MenuButtonWeb({super.key, @required this.title, this.isCart = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(children: [
        Stack(clipBehavior: Clip.none, children: [
          isCart ? GetBuilder<CartController>(builder: (cartController) {
            return cartController.cartList.isNotEmpty ? Positioned(
              top: -5, right: -5,
              child: Container(
                height: 15, width: 15, alignment: Alignment.center,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                child: Text(
                  cartController.cartList.length.toString(),
                  style: ubuntuRegular.copyWith(fontSize: 12, color: Theme.of(context).cardColor),
                ),
              ),
            ) : const SizedBox();
          }) : const SizedBox(),
        ]),
        const SizedBox(width: Dimensions.paddingSizeExtraSmall),

        Text(title!, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
      ]),
    );
  }
}

