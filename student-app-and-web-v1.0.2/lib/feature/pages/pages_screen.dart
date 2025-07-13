import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/html_type.dart';

import 'controller/webview_controller.dart';

class PagesScreen extends StatelessWidget {
  final HtmlType? htmlType;
  const PagesScreen({super.key, @required this.htmlType});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: htmlType == HtmlType.TERMS_AND_CONDITION ? 'terms_and_conditions'.tr
          : htmlType == HtmlType.ABOUT_US ? 'about_us'.tr :
      htmlType == HtmlType.PRIVACY_POLICY ? 'privacy_policy'.tr :
      htmlType == HtmlType.CANCELLATION_POLICY ? 'cancellation_policy'.tr :
      htmlType == HtmlType.REFUND_POLICY ? 'refund_policy'.tr :
      'no_data_found'.tr),


      body: GetBuilder<HtmlViewController>(
        initState: (state){
          Get.find<HtmlViewController>().getPagesContent();
        },
        builder: (htmlViewController){
          String? _data;
          if(htmlViewController.pagesContent != null){
             _data = htmlType == HtmlType.TERMS_AND_CONDITION ? htmlViewController.pagesContent!.termsAndConditions!
                : htmlType == HtmlType.ABOUT_US ? htmlViewController.pagesContent!.aboutUs!
                : htmlType == HtmlType.PRIVACY_POLICY ? htmlViewController.pagesContent!.privacyPolicy!
                : null;

             if(_data != null) {
               _data = _data.replaceAll('href=', 'target="_blank" href=');

               return Center(
                 child: FooterBaseWidget(
                   child: Container(
                     width: Dimensions.webMaxWidth,
                     height: MediaQuery.of(context).size.height,
                     color: GetPlatform.isWeb ? Colors.white : Theme.of(context).cardColor,
                     child:SingleChildScrollView(
                       padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                       physics: const BouncingScrollPhysics(),
                       child: Html(
                         data: _data,
                       ),
                     ),
                   ),
                 ),
               );
             }else{
               return SizedBox();
             }
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
