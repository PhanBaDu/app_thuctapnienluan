import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class DottedBorderBox extends StatelessWidget {
  final double? height;
  final double? width;
  final Function() onTap;
  const DottedBorderBox({Key? key, required this.onTap, this.height=100, this.width=100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: const [8, 4],
      strokeWidth: 1,
      borderType: BorderType.RRect,
      color: Colors.grey,
      radius: const Radius.circular(10),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(height: height, width: width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).disabledColor,
                    borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                  ),
                  child: Icon(Icons.upload,
                    color: Theme.of(context).cardColor,
                    size: 25,
                  ),
                ),
                const SizedBox(height: 5,),
                Text("upload_assignment".tr,
                  style: ubuntuMedium.copyWith(fontSize: 12,
                    color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
