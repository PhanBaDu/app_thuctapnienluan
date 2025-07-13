
import 'package:flutter/material.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/feature/category/view/subcategory_view.dart';

class SubCategoryScreen extends StatelessWidget {
  final String categoryTitle;
  const SubCategoryScreen({Key? key, required this.categoryTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(title: categoryTitle,),
      body: const CustomScrollView(
        slivers: [
          SubCategoryView(isScrollable: true,),
        ],
      )
    );
  }
}
