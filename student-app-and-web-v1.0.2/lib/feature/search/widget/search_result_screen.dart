import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/components/search_app_bar.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/feature/search/controller/search_controller.dart' as search_controller;
import 'search_result_widget.dart';

class SearchResultScreen extends StatefulWidget {
  final String? queryText;

  const SearchResultScreen({Key? key, required this.queryText})
      : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  void initState() {
    if (widget.queryText!.isNotEmpty) {
      Get.find<search_controller.SearchController>()
          .searchData(widget.queryText!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchAppBar(backButton: true),
      body: GetBuilder<search_controller.SearchController>(
        initState: (state) {
          // Get.find<SearchController>().removeService();
        },
        builder: (searchController) {
          return FooterBaseWidget(
            isCenter: (searchController.isSearchComplete ||
                    searchController.isLoading!)
                ? (searchController.searchServiceList == null ||
                    searchController.searchServiceList!.isEmpty)
                : false,
            child: searchController.isLoading!
                ? Center(child: CircularProgressIndicator(
                color: Get.isDarkMode
                    ? Theme.of(context).primaryColorLight
                    : Theme.of(context).colorScheme.primary),)
                : const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        SizedBox(height: Dimensions.paddingSizeDefault),
                        SearchResultWidget(),
                      ]),
          );
        },
      ),
    );
  }
}
