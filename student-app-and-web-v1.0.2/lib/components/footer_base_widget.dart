import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'footer_widget.dart';

class FooterBaseWidget extends StatelessWidget {
  final Widget child;
  final bool isScrollView;
  final ScrollController? scrollController;
  final bool isCenter;
  const FooterBaseWidget({Key? key, required this.child,  this.isScrollView = true, this.isCenter = false, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(isCenter){
      return isScrollView ? Center(
        child: SingleChildScrollView(
          controller: scrollController,
          child: _widget(context),
        ),
      ) : _widget(context);
    }

    return isScrollView ? SingleChildScrollView(
      controller: scrollController,
      child: _widget(context),
    ) : _widget(context);
  }

  Widget _widget(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ? Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: !ResponsiveHelper.isDesktop(context) && Get.size.height < 600 ? Get.size.height : Get.size.height - 380,
          ),
          child: child,
        ),
         const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
         const FooterWidget(),
      ],
    ) : child;
  }
}