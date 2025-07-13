import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';


class ServiceOverview extends StatelessWidget {
  final String description;
  const ServiceOverview({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          width: Dimensions.webMaxWidth,
          constraints:  ResponsiveHelper.isDesktop(context) ? BoxConstraints(
            minHeight: !ResponsiveHelper.isDesktop(context) && Get.size.height < 600 ? Get.size.height : Get.size.height - 550,
          ) : null,
          child: Card(
            color: Theme.of(context).cardColor,
            ///description will be placed here
            child: Html(data: description,)
          ),
        ),
      ),
    );
  }
}