import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/controller/theme_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';


class ProfileCardItem extends StatelessWidget {
  final String leadingIcon;
  final bool? isDarkItem;
  final String title;
  final IconData? trailingIcon;
  final Function()? onTap;
  const ProfileCardItem({Key? key,this.trailingIcon=Icons.arrow_forward_ios,required this.title,required this.leadingIcon,this.onTap,this.isDarkItem=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
      child: Container(
        height: 70,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          color: Theme.of(context).cardColor,
          // boxShadow: Get.isDarkMode ?null: cardShadow,
        ),


        child: Center(
          child: ListTile(
            title: Row(
              children: [
                Image.asset(leadingIcon,width: Dimensions.profileItemSize,),
                const SizedBox(width: Dimensions.paddingSizeDefault,),
                Text(title),
              ],
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
