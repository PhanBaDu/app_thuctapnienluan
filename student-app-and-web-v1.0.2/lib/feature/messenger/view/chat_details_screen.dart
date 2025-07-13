import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/custom_app_bar.dart';
import 'package:get_lms_flutter/components/custom_image.dart';
import 'package:get_lms_flutter/components/custom_snackbar.dart';
import 'package:get_lms_flutter/core/helper/responsive_helper.dart';
import 'package:get_lms_flutter/feature/messenger/controller/messenger_controller.dart';
import 'package:get_lms_flutter/feature/messenger/model/conversation_model.dart';
import 'package:get_lms_flutter/feature/messenger/widgets/chatting_shimmer.dart';
import 'package:get_lms_flutter/feature/messenger/widgets/message_widget.dart';
import 'package:get_lms_flutter/feature/profile/controller/user_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class ChatDetailsScreen extends StatefulWidget {
  final String chatID;
  final String name;
  final String image;
  final String date;
  final String userId;

  const ChatDetailsScreen({super.key,  required this.name, required this.image, required this.chatID,required this.date,required this.userId});
  @override
  State<ChatDetailsScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ChatDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:ResponsiveHelper.isWeb() ? CustomAppBar(title:widget.name,): AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).primaryColorLight),

          color: Theme.of(context).textTheme.bodyMedium!.color,
          onPressed: () => Navigator.pop(context),
        ) ,
        title: Text(widget.name, style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CustomImage(image: widget.image),
              ),
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall,)
        ],
      ),

      body: SafeArea(
        child: GetBuilder<MessengerController>(
            initState: (state) {
              Get.find<MessengerController>().getConversation(widget.chatID, 1,isInitial:true);
              },
            builder: (conversationController) {
              if(conversationController.conversationList != null){
                List<ConversationData>? conversationList = conversationController.conversationList!.reversed.toList();
                String customerID = Get.find<UserController>().userInfoModel.id?? '';
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    width: Dimensions.webMaxWidth,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: CustomScrollView(
                            controller: conversationController.messageScrollController,
                            slivers: [
                              const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeDefault,),),
                              conversationList.isNotEmpty ?
                              SliverList(
                                delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                                  bool isRightMessage = conversationList.elementAt(index).senderId == customerID;
                                  return  ConversationWidget(
                                    conversationData:conversationList.elementAt(index),
                                    oppositeName: widget.name,
                                    isRightMessage: isRightMessage,
                                    receiverImage: widget.image,
                                  );
                                },
                                  childCount:  conversationList.length,
                                ),
                              ):
                              const SliverToBoxAdapter(child: SizedBox()),

                            ],
                          ),
                        ),
                        Column(
                          children: [
                            conversationController.pickedImageFile != null && conversationController.pickedImageFile!.isNotEmpty ?
                            SizedBox(
                              height: 90,
                              width: Get.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context,index){
                                  return  Stack(children: [
                                    Padding(padding: const EdgeInsets.only(left: 8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: SizedBox(
                                          height: 80,
                                          width: 80,
                                          child:ResponsiveHelper.isWeb() ? Image.network(
                                            conversationController.pickedImageFile![0].path,
                                            fit: BoxFit.cover,
                                          ) : Image.file(
                                            File(conversationController.pickedImageFile![0].path),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: InkWell(
                                        child: const Icon(Icons.cancel_outlined, color: Colors.red),
                                        onTap: () {
                                          conversationController.pickMultipleImage(true,index: index);
                                        },
                                      ),
                                    )
                                  ],
                                  );
                                },
                                itemCount: conversationController.pickedImageFile!.length,
                              ),
                            ) :
                            const SizedBox(),
                            conversationController.otherFile != null ?
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 25),
                                      child: Center(child: Text(conversationController.otherFile!.names.elementAt(0).toString()))),
                                  InkWell(
                                    child: const Icon(Icons.cancel_outlined, color: Colors.red),
                                    onTap: () {
                                      conversationController.pickOtherFile(true);
                                    },
                                  )
                                ],
                              ),
                            ) : const SizedBox(),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: Dimensions.paddingSizeSmall,
                                  right: Dimensions.paddingSizeSmall,
                                  bottom: Dimensions.paddingSizeSmall),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.5)),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(2.0, 2.0), // shadow direction: bottom right
                                    )
                                  ],
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall))),
                              child: Form(
                                key: conversationController.conversationKey,
                                child: Row(children: [
                                  const SizedBox(width: Dimensions.paddingSizeDefault),
                                  Expanded(
                                    child: TextField(
                                      controller: conversationController.conversationController,
                                      textCapitalization: TextCapitalization.sentences,
                                      cursorColor: Theme.of(context).hintColor,
                                      style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color:Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8)),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "type_a_message".tr,
                                        hintStyle: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.8), fontSize: 16),),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      conversationController.isLoading! ?
                                      Container(padding: const EdgeInsets.symmetric(horizontal: 10),
                                          height: 20, width: 40,
                                          child: const Center(child: CircularProgressIndicator())) :
                                      InkWell(
                                        onTap: (){
                                          if(conversationController.conversationController.text.isEmpty
                                              && conversationController.pickedImageFile!.isEmpty
                                              && conversationController.otherFile==null){
                                            customSnackBar("write_something".tr);
                                          }
                                          else if(conversationController.conversationKey.currentState!.validate()){
                                            conversationController.sendMessage(widget.chatID, widget.userId);
                                          }
                                          conversationController.conversationController.clear();
                                        },
                                        child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                            child:Image.asset(Images.sendMessage, width: 25, height: 25, color: Colors.lightBlueAccent)
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }else{
                return const ChattingShimmer();
              }
            }),
      ),
    );
  }
}
