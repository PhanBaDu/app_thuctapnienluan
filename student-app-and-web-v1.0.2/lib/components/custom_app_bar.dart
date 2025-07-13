import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/web_menu_bar.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'cart_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? isBackButtonExist;
  final Function()? onBackPressed;
  final bool? showCart;
  final bool? centerTitle;
  final Color? bgColor;
  final Color? titleColor;
  final List<Widget>? actions;
  const CustomAppBar(
      {super.key,
      this.title = '',
      this.isBackButtonExist = true,
      this.onBackPressed,
      this.showCart = false,
      this.centerTitle = true,
      this.bgColor,
      this.titleColor,
      this.actions = const [SizedBox()]});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : AppBar(
      title: Text(
        title!,
        style: ubuntuMedium.copyWith(
            fontSize: Dimensions.fontSizeLarge,
            color: titleColor ?? Theme.of(context).primaryColorLight),
      ),
      centerTitle: centerTitle,
      automaticallyImplyLeading: true,
      leading: isBackButtonExist!
          ? IconButton(
        splashRadius: Dimensions.paddingSizeLarge,
        hoverColor: Colors.transparent,
        icon: Icon(Icons.arrow_back, color: titleColor ?? Theme.of(context).primaryColorLight),
        color: Theme.of(context).textTheme.bodyLarge!.color,
        onPressed: () => onBackPressed != null
            ? onBackPressed!()
            : Navigator.pop(context),
      )
          : const SizedBox(),
      backgroundColor: bgColor ?? Theme.of(context).primaryColor,
      elevation: 0,
      actions: showCart!
          ? [
        IconButton(
          onPressed: () {
            Get.toNamed(RouteHelper.getCartRoute());
          },
          icon: CartWidget(
              color: Get.isDarkMode ? Theme.of(context).primaryColorLight : Colors.white,
              size: Dimensions.cartWidgetSize),
        )
      ]
          : actions,
    );
  }

  @override
  Size get preferredSize => Size(Dimensions.webMaxWidth, GetPlatform.isDesktop ? 110 : 50);
}
