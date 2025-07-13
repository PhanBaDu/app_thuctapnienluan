import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/messenger/controller/messenger_controller.dart';
import 'package:get_lms_flutter/feature/messenger/model/channel_model.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/gaps.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class ChannelItem extends StatelessWidget {
  final String channelupdatedAt;
  final ChannelData channelData;
  const ChannelItem({Key? key, required this.channelData, required this.channelupdatedAt,}) : super(key: key);
  @override
  Widget build(BuildContext context) {


    return InkWell(
      onTap:(){
        Get.find<MessengerController>().setChannelId(channelData.id.toString());
        Get.toNamed(RouteHelper.getChatScreenRoute(channelData.id!.toString(),channelData.userName!,channelData.userImage!,channelupdatedAt,channelData.userId!.toString()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // color: isRead == 0? Theme.of(context).colorScheme.primary.withOpacity(.5) : Theme.of(context).hoverColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const SizedBox(width: Dimensions.paddingSizeSmall,),
            ClipRRect(borderRadius: BorderRadius.circular(50),
              child: CustomImage(height: 50, width: 50,
                  image: channelData.userImage!),
            ),
            Gaps.horizontalGapOf(Dimensions.paddingSizeSmall),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        channelData.userName!,
                      style: ubuntuMedium.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color:Get.isDarkMode ? Theme.of(context).primaryColorLight:Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8)
                      )
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall,),
                    Text(
                      channelData.userName!,
                      style: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color:Get.isDarkMode ? Theme.of(context).primaryColorLight : Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.6) ),),
                  ],
                )
            ),
            // Text( DateConverter.dateMonthYearTimeTwentyFourFormat(DateConverter.isoUtcStringToLocalDate(channelupdatedAt)),
            Text('10 January',
                textDirection: TextDirection.ltr,
                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,

              color:Get.isDarkMode ? Theme.of(context).primaryColorLight : Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.6),)),

            const SizedBox(width: Dimensions.paddingSizeSmall,),
          ],
        ),
      ),
    );
  }
}

