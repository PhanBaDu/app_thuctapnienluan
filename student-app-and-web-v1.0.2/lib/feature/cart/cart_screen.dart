import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/course_view_verticle.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_button.dart';
import 'package:get_lms_flutter/components/custom_loader.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/components/paginated_list_view.dart';
import 'package:get_lms_flutter/core/helper/price_converter.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/cart/controller/cart_controller.dart';
import 'package:get_lms_flutter/feature/cart/widget/cart_product_widget.dart';
import 'package:get_lms_flutter/feature/course/controller/course_controller.dart';
import 'package:get_lms_flutter/feature/root/view/no_data_screen.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class CartScreen extends StatelessWidget {
  final fromNav;
  const CartScreen({super.key, @required this.fromNav});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: CustomAppBar(
          title: 'cart'.tr,
          isBackButtonExist: (ResponsiveHelper.isDesktop(context) || !fromNav)),
      body: SafeArea(
        child: GetBuilder<CartController>(
          initState: (state) {
            Get.find<CartController>().cartList.forEach((cart) async {
              if (cart.course == null) {
                await Get.find<CartController>().removeCartFromServer(cart.id);
              }
            });
          },
          builder: (cartController) {
            return Column(
              children: [
                Expanded(
                  child: FooterBaseWidget(
                    isCenter: (cartController.cartList.isEmpty),
                    child: SizedBox(
                      width: Dimensions.webMaxWidth,
                      child: GetBuilder<CartController>(
                        builder: (cartController) {
                          if (cartController.isLoading) {
                            return const CustomLoader();
                          } else {
                            if (cartController.cartList.isNotEmpty) {
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                            height:
                                                Dimensions.paddingSizeDefault),
                                        GridView.builder(
                                          key: UniqueKey(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisSpacing:
                                                Dimensions.paddingSizeLarge,
                                            mainAxisSpacing: ResponsiveHelper
                                                    .isDesktop(context)
                                                ? Dimensions.paddingSizeLarge
                                                : Dimensions.paddingSizeMint,
                                            childAspectRatio:
                                                ResponsiveHelper.isMobile(
                                                        context)
                                                    ? 5
                                                    : 6,
                                            crossAxisCount:
                                                ResponsiveHelper.isMobile(
                                                        context)
                                                    ? 1
                                                    : 2,
                                            mainAxisExtent:
                                                ResponsiveHelper.isMobile(
                                                        context)
                                                    ? 115
                                                    : 125,
                                          ),
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              cartController.cartList.length,
                                          itemBuilder: (context, index) {
                                            return cartController
                                                        .cartList[index]
                                                        .course !=
                                                    null
                                                ? CartServiceWidget(
                                                    cart: cartController
                                                        .cartList[index],
                                                    cartIndex: index)
                                                : const SizedBox();
                                          },
                                        ),
                                        const SizedBox(
                                            height:
                                                Dimensions.paddingSizeSmall),
                                      ]),
                                  if (ResponsiveHelper.isWeb())
                                    cartController.cartList.isNotEmpty
                                        ? Column(
                                            children: [
                                              Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                ),
                                                child: Center(
                                                  child: RichText(
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    text: TextSpan(
                                                      text: 'total_price'.tr,
                                                      style: ubuntuRegular
                                                          .copyWith(
                                                        fontSize: Dimensions
                                                            .fontSizeLarge,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .color,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              ' ${PriceFormatter.formatPrice(cartController.totalPrice)}',
                                                          style: ubuntuBold
                                                              .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .error,
                                                            fontSize: Dimensions
                                                                .fontSizeLarge,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: Dimensions
                                                      .paddingSizeDefault,
                                                  vertical: Dimensions
                                                      .paddingSizeSmall,
                                                ),
                                                child: CustomButton(
                                                  width: Get.width,
                                                  radius:
                                                      Dimensions.radiusDefault,
                                                  buttonText:
                                                      'proceed_to_checkout'.tr,
                                                  onPressed: () {
                                                    if (Get.find<
                                                            AuthController>()
                                                        .isLoggedIn()) {
                                                      Get.toNamed(RouteHelper
                                                          .getCheckoutRoute(
                                                              'cart'));
                                                    } else {
                                                      Get.toNamed(RouteHelper
                                                          .getSignInRoute(
                                                              RouteHelper
                                                                  .main));
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(
                                            height: Dimensions
                                                .paddingSizeExtraMoreLarge,
                                          ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: Dimensions
                                            .paddingSizeExtraMoreLarge,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:
                                                Dimensions.paddingSizeDefault),
                                        child: Row(
                                          children: [
                                            Text(
                                              'you_might_also_like'.tr,
                                              style: ubuntuMedium.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeDefault),
                                              textAlign: TextAlign.start,
                                            ),
                                            const SizedBox(),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: Dimensions.paddingSizeDefault,
                                      ),
                                      GetBuilder<CourseController>(
                                          builder: (serviceController) {
                                        if (serviceController.serviceContent !=
                                            null) {
                                          return PaginatedListView(
                                            scrollController: scrollController,
                                            totalSize: serviceController
                                                .serviceContent!.total,
                                            offset: serviceController
                                                .serviceContent!.to,
                                            onPaginate: (int offset) async =>
                                                await serviceController
                                                    .getAllCourseList(
                                                        offset, false),
                                            itemView: CourseViewVertical(
                                              course: serviceController
                                                          .serviceContent !=
                                                      null
                                                  ? serviceController
                                                      .serviceContent!
                                                      .serviceList
                                                  : null,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: ResponsiveHelper
                                                        .isDesktop(context)
                                                    ? Dimensions
                                                        .paddingSizeExtraSmall
                                                    : Dimensions
                                                        .paddingSizeSmall,
                                                vertical: ResponsiveHelper
                                                        .isDesktop(context)
                                                    ? Dimensions
                                                        .paddingSizeExtraSmall
                                                    : 0,
                                              ),
                                              type: 'others',
                                            ),
                                          );
                                        }
                                        return const SizedBox();
                                      }),
                                    ],
                                  )
                                ],
                              );
                            } else {
                              return EmptyScreen(
                                text: "cart_is_empty".tr,
                                type: EmptyScreenType.cart,
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
                if (!ResponsiveHelper.isWeb() &&
                    cartController.cartList.isNotEmpty)
                  Column(
                    children: [
                      Divider(
                        height: 2,
                        color: Theme.of(context).shadowColor,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: Center(
                          child: RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: 'total_price'.tr,
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeLarge,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      ' ${PriceFormatter.formatPrice(cartController.totalPrice, isShowLongPrice: true)} ',
                                  style: ubuntuBold.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                    fontSize: Dimensions.fontSizeLarge,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: Dimensions.paddingSizeDefault,
                          right: Dimensions.paddingSizeDefault,
                          bottom: Dimensions.paddingSizeSmall,
                        ),
                        child: CustomButton(
                          width: Get.width,
                          radius: Dimensions.radiusDefault,
                          buttonText: 'proceed_to_checkout'.tr,
                          onPressed: () {
                            if (Get.find<AuthController>().isLoggedIn()) {
                              Get.toNamed(RouteHelper.getCheckoutRoute('cart'));
                            } else {
                              Get.toNamed(
                                  RouteHelper.getSignInRoute(RouteHelper.main));
                            }
                          },
                        ),
                      ),
                    ],
                  )
              ],
            );
          },
        ),
      ),
      // bottomSheet: FooterWidget(),
    );
  }
}
