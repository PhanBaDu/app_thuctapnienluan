import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/route_helper.dart';
import 'package:get_lms_flutter/feature/auth/controller/auth_controller.dart';
import 'package:get_lms_flutter/feature/instructor/model/instructor_model.dart';
import 'package:get_lms_flutter/feature/instructor/widgets/create_meeting_dialog.dart';
import 'package:get_lms_flutter/feature/messenger/controller/messenger_controller.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class InstructorSocialWidget extends StatelessWidget {
  const InstructorSocialWidget({super.key, required this.socialLinks, required this.instructorUserId, required this.instructorId});
  final SocialLinks socialLinks;
  final String instructorUserId;
  final String instructorId;


  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = Get.find<AuthController>().isLoggedIn();

    final List<SocialItem> socialItems = [
      if(isLoggedIn) SocialItem(icon: Images.message, name: "Message",link:  'conversation',),
      SocialItem(icon: Images.twitterSmall, name: 'Twitter', link:  socialLinks.twitterUrl,),
      SocialItem(icon: Images.facebookSmall, name: "Facebook", link:  socialLinks.facebookUrl,),
      SocialItem(icon: Images.youTubeSmall, name: "Youtube", link:  socialLinks.twitterUrl,),
      SocialItem(icon: Images.linkedInSmall, name: "Linkedin", link:  socialLinks.linkedinUrl,),
      SocialItem(icon: Images.linkSmall, name: "Website", link:  socialLinks.twitterUrl,),
      SocialItem(icon: Images.linkSmall, name: "Meetings", link:  "meetings",),
    ];

    return Wrap(
        children: socialItems.map((item) => Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          child: InkWell(
            onTap: () async {

              if(item.link == 'conversation'){
                Get.find<MessengerController>().sendInitialMessage(instructorUserId);
              }else if(item.link == 'meetings'){
                // Get.toNamed(RouteHelper.getCreateMeetingScreen('1'));
                Get.dialog(CreateMeetingDialog(instructorId: instructorId,));
              }

              else{
                final uri = Uri.parse(item.link!);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(Uri.parse(item.link!));}
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width/3.5,
              height: 40,
              decoration: BoxDecoration(
                  color: Theme.of(context).disabledColor.withOpacity(.2),
                  borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
                  border: Border.all(
                      color:socialItems.indexOf(item) == 0 ? Theme.of(context).primaryColor.withOpacity(.5):
                      Theme.of(context).disabledColor.withOpacity(.2))
              ),
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Row(
                  children: [
                    Image.asset(item.icon!,scale: 3,),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                    Text(item.name!,style: ubuntuRegular.copyWith(
                      color:Theme.of(context).textTheme.bodySmall!.color,
                    ),),
                  ],
                ),
              ),
            ),
          ),
        )).toList()
    );
  }
}

class SocialItem {
  String? icon;
  String? name;
  String? link;

  SocialItem({required this.icon, required this.name, required this.link});
}
