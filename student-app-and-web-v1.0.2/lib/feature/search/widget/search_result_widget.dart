import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/course_view_verticle.dart';
import 'package:get_lms_flutter/feature/root/view/no_data_screen.dart';
import 'package:get_lms_flutter/feature/search/controller/search_controller.dart' as search_controller;
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'search_suggestion.dart';

class SearchResultWidget extends GetView<SearchController> {
  const SearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<search_controller.SearchController>(
        builder: (searchController) {
          if(searchController.isSearchComplete){
            return Center(
                child: SizedBox(
                    width: Dimensions.webMaxWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CourseViewVertical(course: searchController.searchServiceList!,noDataType: EmptyScreenType.search,),
                      ],
                    )));
          }else{
            return searchController.historyList!.isNotEmpty ?  const SearchSuggestion():const SizedBox();
          }

    });
  }
}
