import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/footer_base_widget.dart';
import 'package:get_lms_flutter/components/list_shimmer.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/feature/messenger/controller/messenger_controller.dart';
import 'package:get_lms_flutter/feature/messenger/widgets/channel_item.dart';
import 'package:get_lms_flutter/feature/messenger/widgets/inbox_shimmer.dart';
import 'package:get_lms_flutter/feature/profile/controller/user_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';

class ChatsScreen extends GetView<MessengerController> {
  const ChatsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: 'chats'.tr, isBackButtonExist: true,),
      body: GetBuilder<MessengerController>(
        initState:(state) {
          Get.find<MessengerController>().getChannelList(1);
          Get.find<UserController>().getUserInfo();
        },
        builder: (conversationController){
            return FooterBaseWidget(
              isCenter: (conversationController.channelList == null || conversationController.channelList!.isEmpty),
              child: SizedBox(
                width: Dimensions.webMaxWidth,
                child: conversationController.channelList == null ?
                const ListShimmer() :
                conversationController.channelList!.isNotEmpty ?
                Column(
                  children: [
                    if(ResponsiveHelper.isWeb())
                    const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge,),
                    const SizedBox(height: Dimensions.paddingSizeSmall,),
                    ListView.builder(
                        controller: conversationController.scrollController,
                        itemCount: controller.channelList!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          return ChannelItem(
                            channelData: controller.channelList!.elementAt(index),
                            channelupdatedAt: '10 January',
                          );
                        }
                    ),
                  ],
                ):
                Center(child: Text('no_message_available'.tr)),
              ),
            );
        },
      ),
    );
  }
}
