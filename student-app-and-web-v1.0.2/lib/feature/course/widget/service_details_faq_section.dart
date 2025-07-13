import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/feature/course/controller/course_details_controller.dart';
import 'package:get_lms_flutter/feature/course/model/course_model.dart';
import 'package:get_lms_flutter/utils/custom_expansion_tile.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class ServiceDetailsFaqSection extends StatelessWidget {
  const ServiceDetailsFaqSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseDetailsController>(
      builder: (serviceDetailsController){
        if(!serviceDetailsController.isLoading){
          List<Faqs>? faqs = [];
          return SliverToBoxAdapter(
            child: Center(
              child:
              Container(
                width: Dimensions.webMaxWidth,
                constraints:  ResponsiveHelper.isDesktop(context) ? BoxConstraints(
                  minHeight: !ResponsiveHelper.isDesktop(context) && Get.size.height < 600 ? Get.size.height : Get.size.height - 550) : null,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: faqs!.length,
                  padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                  itemBuilder: (context, index){


                    return CustomExpansionTile(
                      expandedAlignment: Alignment.centerLeft,
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                        child: Text(
                          faqs.elementAt(index).question!,
                          style: ubuntuRegular.copyWith(color:Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6)),
                        ),
                      ),

                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                          faqs.elementAt(index).answer!,
                              style: ubuntuRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6))),
                        )
                      ],
                    );
                  },),
              )
            ),
          );
        }else{
         return const SliverToBoxAdapter(child: SizedBox());
        }
      }
    );
  }
}