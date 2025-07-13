import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? backButton;

  const HomeScreenAppBar({super.key, this.backButton = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0, leadingWidth: backButton! ? 20 : 0,
      leading: backButton! ? IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        color: Theme.of(context).cardColor,
        onPressed: () => Navigator.pop(context),
      ) : const SizedBox(),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
        InkWell(
          onTap: (){
            Get.toNamed(RouteHelper.getSettingRoute());
          },
          child: Image.asset(Images.settings,scale: 5,),
        ),
        InkWell(
            onTap: () => Get.toNamed(RouteHelper.getNotificationRoute()),
            child: const Icon(Icons.notifications, size: 25, color: Colors.white)),
      ]),
    );
  }

  @override
  Size get preferredSize => Size(Dimensions.webMaxWidth, GetPlatform.isDesktop ? 70 : 50);
}