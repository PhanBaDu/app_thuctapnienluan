import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/checkout/widget/payment_failed_dialog.dart';
import 'package:get_lms_flutter/utils/app_constants.dart';

class PaymentScreen extends StatefulWidget {
  final String url;
  const PaymentScreen({super.key, required this.url,});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedUrl;
  double value = 0.0;
  bool _isLoading = true;
  PullToRefreshController pullToRefreshController = PullToRefreshController();
  MyInAppBrowser? browser;

  @override
  void initState() {
    super.initState();

    selectedUrl = widget.url;

    _initData();
  }

  void _initData() async {
    browser = MyInAppBrowser();
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

      bool swAvailable = await AndroidWebViewFeature.isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
      bool swInterceptAvailable = await AndroidWebViewFeature
          .isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

      if (swAvailable && swInterceptAvailable) {
        AndroidServiceWorkerController serviceWorkerController = AndroidServiceWorkerController
            .instance();
        await serviceWorkerController.setServiceWorkerClient(
            AndroidServiceWorkerClient(
              shouldInterceptRequest: (request) async {
                printLog(request);
                return null;
              },
            ));
      }
    }

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.black,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          browser?.webViewController!.reload();
        } else if (Platform.isIOS) {
          browser?.webViewController!.loadUrl(urlRequest: URLRequest(
              url: await browser?.webViewController!.getUrl()));
        }
      },
    );
    // browser?.pullToRefreshController = pullToRefreshController;

    await browser?.openUrlRequest(

      urlRequest: URLRequest(url: WebUri(selectedUrl!)),
      options: InAppBrowserClassOptions(
        inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true, useOnLoadResource: true),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(),
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              _isLoading ? Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme
                        .of(context)
                        .primaryColor)),
              ) : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _exitApp() async {
   return Future(() => true);
  }
}

class MyInAppBrowser extends InAppBrowser {

  bool _canRedirect = true;

  @override
  Future onBrowserCreated() async {
    printLog("\n\nBrowser Created!\n\n");
  }

  @override
  Future onLoadStart(url) async {
    printLog("\n\nStarted: $url\n\n");
    _pageRedirect(url.toString());
  }

  @override
  Future onLoadStop(url) async {
    pullToRefreshController?.endRefreshing();
    printLog("\n\nStopped: $url\n\n");
    _pageRedirect(url.toString());
  }

  @override
  void onLoadError(url, code, message) {
    pullToRefreshController?.endRefreshing();
    printLog("Can't load [$url] Error: $message");
  }

  @override
  void onProgressChanged(progress) {
    if (progress == 100) {
      pullToRefreshController?.endRefreshing();
    }
    printLog("Progress: $progress");
  }

  @override
  void onExit() {
    if(_canRedirect) {
      Get.dialog(PaymentFailedDialog(orderID: '0'));
    }

    printLog("\n\nBrowser closed!\n\n");
  }

  @override
  Future<NavigationActionPolicy> shouldOverrideUrlLoading(navigationAction) async {
    printLog("\n\nOverride ${navigationAction.request.url}\n\n");
    return NavigationActionPolicy.ALLOW;
  }

  @override
  void onLoadResource(response) {
   // printLog("Started at: " + response.startTime.toString() + "ms ---> duration: " + response.duration.toString() + "ms " + (response.url ?? '').toString());
  }

  @override
  void onConsoleMessage(consoleMessage) {
    printLog("""
    console output:
      message: ${consoleMessage.message}
      messageLevel: ${consoleMessage.messageLevel.toValue()}
   """);
  }

  void _pageRedirect(String url) {
    printLog("url:$url");
    if(_canRedirect) {
      bool isSuccess = url.contains('success') && url.contains(AppConstants.baseUrl) && url.contains(RouteHelper.orderSuccess);
      bool isFailed = url.contains('fail') && url.contains(AppConstants.baseUrl);
      bool isCancel = url.contains('cancel') && url.contains(AppConstants.baseUrl);
      if (isSuccess || isFailed || isCancel) {
        _canRedirect = false;
        close();
      }

      printLog(isSuccess);

      if (isSuccess) {
        Get.offNamed(RouteHelper.getOrderSuccessRoute('success'));
      } else if (isFailed || isCancel) {
        Get.offNamed(RouteHelper.getOrderSuccessRoute('fail'));
      }
    }

  }


}




