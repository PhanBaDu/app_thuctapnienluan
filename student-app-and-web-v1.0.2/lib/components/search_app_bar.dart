import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/search_widget.dart';
import 'package:get_lms_flutter/components/web_menu_bar.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? backButton;
  const SearchAppBar({super.key, this.backButton = true});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 5, leadingWidth: backButton! ? 20 : 0,
      leading: backButton! ? IconButton(
        icon: const Icon(Icons.arrow_back_ios,),
        color: Theme.of(context).primaryColorLight,
        onPressed: () => Navigator.pop(context),
      ) : const SizedBox(),
      title: const SearchWidget(),
    );
  }

  @override
  Size get preferredSize => Size(Dimensions.webMaxWidth, GetPlatform.isDesktop ? 110 : 60);
}