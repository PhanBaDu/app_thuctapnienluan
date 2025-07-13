import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/core/helper/price_converter.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/cart/controller/cart_controller.dart';
import 'package:get_lms_flutter/feature/root/view/no_internet_screen.dart';
import 'package:get_lms_flutter/feature/splash/controller/splash_controller.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class SplashScreen extends StatefulWidget {
  final String? orderID;
  const SplashScreen({super.key, @required this.orderID});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool _firstTime = true;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        isNotConnected
            ? const SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection'.tr : 'connected'.tr,
            textAlign: TextAlign.center,
          ),
        ));
        if (!isNotConnected) {
          _route();
        }
      }
      _firstTime = false;
    });

    Get.find<SplashController>().initSharedData();
    Get.find<CartController>().getCartData();
    _route();
  }

  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged.cancel();
  }

  void _route() {
    Get.find<SplashController>().getConfigData().then((isSuccess) {
      if (isSuccess) {
        Timer(const Duration(seconds: 1), () async {
          int minimumVersion = 0;
          if (GetPlatform.isAndroid) {
            minimumVersion = int.tryParse(Get.find<SplashController>()
                        .configModel
                        .appMinimumVersionAndroid ??
                    '0') ??
                0;
          } else if (GetPlatform.isIOS) {
            minimumVersion = int.tryParse(Get.find<SplashController>()
                        .configModel
                        .appMinimumVersionIos ??
                    '0') ??
                0;
          }
          if (AppConstants.appVersion < minimumVersion ||
              (Get.find<SplashController>().configModel.maintenanceMode ??
                  false)) {
            Get.offNamed(RouteHelper.getUpdateRoute(
                AppConstants.appVersion < minimumVersion));
          } else {
            if (widget.orderID != null) {
            } else {
              if (Get.find<AuthController>().isLoggedIn()) {
                Get.find<AuthController>().updateToken();
                Get.offNamed(RouteHelper.getInitialRoute());
              } else {
                if (!Get.find<SplashController>().isSplashSeen()) {
                  Get.offNamed(RouteHelper.getLanguageScreen('fromOthers'));
                } else {
                  Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
                }
              }
            }
          }
        });
      } else {
        printLog("outside_success");
        // Nếu lấy config thất bại, chuyển sang màn hình đăng nhập
        Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: GetBuilder<SplashController>(builder: (splashController) {
        if (splashController.configModel.currencySymbol != null) {
          PriceFormatter.getCurrency(context);
        }
        return Center(
          child: splashController.hasConnection
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      Images.logo,
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeLarge),
                    Text(
                      AppConstants.appName,
                      style: ubuntuBold.copyWith(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                  ],
                )
              : NoInternetScreen(child: SplashScreen(orderID: widget.orderID)),
        );
      }),
    );
  }
}
