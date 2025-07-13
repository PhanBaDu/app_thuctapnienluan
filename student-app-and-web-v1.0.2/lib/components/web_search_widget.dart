import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/feature/search/controller/search_controller.dart' as search_controller;
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class SearchWidgetWeb extends GetView<search_controller.SearchController> {
  const SearchWidgetWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(
        padding: const EdgeInsets.only(top:5.0,left: Dimensions.paddingSizeDefault,right: Dimensions.paddingSizeDefault),
        child: Container(
            height: Dimensions.SEARCH_BER_SIZE,
            width: 450,
            decoration: BoxDecoration(
              borderRadius:const BorderRadius.horizontal(right: Radius.circular(25,),left: Radius.circular(25)),
              boxShadow:Get.isDarkMode? null: searchBoxShadow,
            ),
            child:
            TypeAheadField(
              getImmediateSuggestions: true,
              textFieldConfiguration: TextFieldConfiguration(
                controller: controller.searchController,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color, fontSize: Dimensions.fontSizeLarge,
                ),

                cursorColor: Theme.of(context).hintColor,
                autofocus: false,
                textAlignVertical: TextAlignVertical.center,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(5,),left: Radius.circular(5)),
                    borderSide: BorderSide(style: BorderStyle.none, width: 0),
                  ),
                  fillColor: Get.isDarkMode? Theme.of(context).primaryColorDark:const Color(0xffFEFEFE),
                  isDense: true,
                  hintText: 'search_courses'.tr,
                  hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
                  filled: true,
                  prefixIconConstraints: const BoxConstraints(minWidth: 23, maxHeight: 20),
                  suffixIcon:  IconButton(
                    onPressed: () {
                      if(controller.searchController.text.trim().isNotEmpty) {
                        controller.navigateToSearchResultScreen();
                      }
                      FocusScope.of(context).unfocus();
                    },
                    icon: const Icon(Icons.search),
                  ),
                ),
              ),
              hideSuggestionsOnKeyboardHide: true,
              suggestionsCallback: (pattern) async {
                Completer<List<String>> completer = Completer();
                completer.complete(controller.filterHistory(pattern, controller.historyList));
                return completer.future;
              },

              itemBuilder: (context,String suggestion){
                return ListTile(
                  title: Text(suggestion),
                );
              },

              onSuggestionSelected: (String suggestion){
                controller.navigateToSearchResultScreen();
                controller.searchData(suggestion);
              },
              noItemsFoundBuilder: (value) {
                return const SizedBox();
              },
            )
        )));
  }
}
