import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/core/helper/date_converter.dart';
import 'package:get_lms_flutter/core/helper/help_me.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/feature/messenger/model/conversation_model.dart';
import 'package:get_lms_flutter/feature/profile/controller/user_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/gaps.dart';


class ConversationWidget extends StatefulWidget {
  final ConversationData conversationData;
  final bool isRightMessage;
  final String oppositeName;
  final String receiverImage;

  const ConversationWidget({super.key, required this.conversationData, required this.isRightMessage, required this.oppositeName, required this.receiverImage});

  @override
  State<ConversationWidget> createState() => _ConversationBubbleState();
}

class _ConversationBubbleState extends State<ConversationWidget> {

  @override
  void initState() {
    super.initState();
    if(ResponsiveHelper.isMobile(Get.context)){
      ReceivePort _port = ReceivePort();
      IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
      _port.listen((dynamic data) {
        setState((){ });
      });

      // FlutterDownloader.registerCallback(downloadCallback);
    }

  }

  @override
  void dispose() {
    if(ResponsiveHelper.isMobile(Get.context)){
      IsolateNameServer.removePortNameMapping('downloader_send_port');
    }
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }


  @override
  Widget build(BuildContext context) {

    String? image = widget.isRightMessage ? Get.find<UserController>().userInfoModel.image : widget.receiverImage;

    printLog(Get.find<UserController>().userInfoModel.image);


    return Column(
      crossAxisAlignment: widget.isRightMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: widget.isRightMessage
              ? const EdgeInsets.fromLTRB(20, 5, 5, 5)
              : const EdgeInsets.fromLTRB(5, 5, 20, 5),
          child: Column(
            crossAxisAlignment:
            widget.isRightMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              //Name
              Row(
                mainAxisAlignment: widget.isRightMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Text(widget.isRightMessage ?'${Get.find<UserController>().userInfoModel.fName??''} ${Get.find<UserController>().userInfoModel.lName}' :widget.oppositeName ),
                ],
              ),
              Gaps.verticalGapOf(Dimensions.fontSizeExtraSmall),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: widget.isRightMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  //Avater for Right
                  widget.isRightMessage
                      ? const SizedBox()
                      : Column(children: [ ClipRRect(borderRadius: BorderRadius.circular(50),
                        child: CustomImage(height: 30, width: 30, image: image??'')),
                  ],
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall,),
                  //Message body
                  Flexible(
                    child: Column(
                      crossAxisAlignment: widget.isRightMessage?CrossAxisAlignment.end:CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if(widget.conversationData.content != null) Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).hoverColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(widget.conversationData.content != null?Dimensions.paddingSizeDefault:0),
                              child: Text(widget.conversationData.content??''),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10,),
                  widget.isRightMessage ?
                  ClipRRect(borderRadius: BorderRadius.circular(50),
                      child: CustomImage(height: 30, width: 30, image: image??''))

                      : const SizedBox(),
                ],
              ),
              Gaps.verticalGapOf(Dimensions.paddingSizeExtraSmall),

            ],
          ),
        ),
        Padding(
            padding: widget.isRightMessage ? const EdgeInsets.fromLTRB(5, 5, 50, 5) : const EdgeInsets.fromLTRB(50, 5, 5, 5),
            child: Text( DateConverter.dateMonthYearTimeTwentyFourFormat(DateConverter.dateTimeStringToDate(widget.conversationData.createdAt!)),style: const TextStyle(fontSize: 8.0),
                textDirection: TextDirection.ltr)
        ),

      ],
    );
  }
}
