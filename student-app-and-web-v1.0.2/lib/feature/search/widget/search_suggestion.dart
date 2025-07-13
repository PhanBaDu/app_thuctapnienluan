import 'package:get_lms_flutter/components/ripple_button.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/feature/search/controller/search_controller.dart' as search_controller;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class SearchSuggestion extends StatelessWidget {
  const SearchSuggestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<search_controller.SearchController>(
      builder: (searchController){
        printLog(searchController.historyList);
        return Padding(
          padding:  const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('suggestions'.tr,style: ubuntuMedium.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).colorScheme.primary),),
                  InkWell(
                    onTap: (){
                      searchController.clearSearchAddress();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      child: Text('clear_all'.tr,style: ubuntuMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).colorScheme.primary),),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault,),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveHelper.isDesktop(context) ? 8 : ResponsiveHelper.isTab(context) ? 6 : 4,
                  childAspectRatio: 3/1.6,
                  crossAxisSpacing: Dimensions.paddingSizeDefault,
                  mainAxisSpacing: Dimensions.paddingSizeDefault,
                ),
                itemCount:searchController.historyList!.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).hoverColor,
                            borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusDefault))
                          ),
                          child: Center(child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeExtraSmall,vertical: Dimensions.paddingSizeExtraSmall),
                            child: Text(searchController.historyList!.elementAt(index)),
                          ))),
                      Positioned.fill(child: RippleButton(onTap: () {
                        searchController.populatedSearchController(searchController.historyList!.elementAt(index));
                        searchController.searchData(searchController.historyList!.elementAt(index));
                      }))
                    ],
                  );
                },
              ),
            ],
          ),
        );
      }
    );
  }
}
