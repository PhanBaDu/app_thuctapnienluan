import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/category/view/category_screen.dart';
import 'package:get_lms_flutter/feature/home/home_screen.dart';
import 'package:get_lms_flutter/feature/home/widget/bottom_nav_bar.dart';
import 'package:get_lms_flutter/feature/myCourse/view/my_course_screen.dart';
import 'package:get_lms_flutter/feature/profile/view/profile_screen.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'controller/bottom_nav_controller.dart';


class BottomNavScreen extends StatefulWidget {
  final int pageIndex;
    const BottomNavScreen({super.key, required this.pageIndex});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final int _pageIndex = 0;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          Get.find<BottomNavController>().changePage(0);
          return false;
        } else {
          if (_canExit) {
            return true;
          } else {
            Fluttertoast.showToast(
                msg: 'back_press_again_to_exit'.tr,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            _canExit = true;
            Timer(const Duration(seconds: 2), () {
              _canExit = false;
            });
            return false;
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: ResponsiveHelper.isDesktop(context) ? const SizedBox() :
        Container(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),

          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusDefault)),
            child: Obx(() => BottomNavyBar(
              selectedIndex: Get.find<BottomNavController>().currentPage.value.index,
              showElevation: true,
              itemCornerRadius: 24,
              curve: Curves.easeIn,
              backgroundColor: Theme.of(context).primaryColor,
              containerHeight: 65,
              onItemSelected: (index) => Get.find<BottomNavController>().changePage(index),

              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                  activeIconColor: Colors.white,
                  inactiveColor: Theme.of(context).bottomAppBarTheme.color,
                  icon: Images.homeBottomNav,
                  title: Text('home'.tr,style: ubuntuMedium.copyWith(color: Colors.white),),
                  activeColor: Theme.of(context).primaryColor,
                  textAlign: TextAlign.center,

                ),

                BottomNavyBarItem(
                  activeIconColor: Colors.white,
                  inactiveColor: Theme.of(context).bottomAppBarTheme.color,
                  icon: Images.categoryBottomNav,
                  title: Text('category'.tr,style: ubuntuMedium.copyWith(color: Colors.white),),
                  activeColor: Theme.of(context).primaryColor,
                  textAlign: TextAlign.center,
                ),

                BottomNavyBarItem(
                  activeIconColor: Colors.white,
                  inactiveColor: Theme.of(context).bottomAppBarTheme.color,
                  icon: Images.myCourseBottomNav,
                  title: Text('my_course'.tr,style: ubuntuMedium.copyWith(color: Colors.white),),
                  activeColor: Theme.of(context).primaryColor,
                  textAlign: TextAlign.center,
                ),

                BottomNavyBarItem(
                  icon: Images.profileBottomNav,
                  isProfile: true,
                  title: Text('profile'.tr,style: ubuntuMedium.copyWith(color: Colors.white),),
                  activeColor: Theme.of(context).primaryColor,
                  textAlign: TextAlign.center,
                ),
              ],
            ),)
          ),
        ),
        body: Obx(() => _bottomNavigationView()),
      ),
    );
  }

  _bottomNavigationView() {
    switch (Get.find<BottomNavController>().currentPage.value) {
      case BnbItem.home:
        return const HomeScreen();
      case BnbItem.categories:
        if (!Get.find<AuthController>().isLoggedIn()) {
          break;
        } else {
      return const CategoryScreen(fromPage: 'bottom_nav',campaignID: '0',);
        }
      case BnbItem.myCourse:
        if (!Get.find<AuthController>().isLoggedIn()) {
          break;
        } else {
      return const MyCourseScreen();
        }
      case BnbItem.profile:
        return const ProfileScreen(fromPage: 'bottomNav',);
    }
  }

}

