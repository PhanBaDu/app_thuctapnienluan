import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';


class WhatYouWillLearn extends StatelessWidget {
  final List<String> whatWillLearn;

  const WhatYouWillLearn({Key? key, required this.whatWillLearn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('what_you_will_learn'.tr,
            style: ubuntuBold.copyWith(
                fontSize: Dimensions.fontSizeDefault),
          ),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          //curriculumItem(context),
          SizedBox(
            //height: 400,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: whatWillLearn.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom:Dimensions.paddingSizeSmall),
                  child: Row(
                    children: [
                      Container(
                        width: Dimensions.paddingSizeExtraSmall,
                        height: Dimensions.paddingSizeExtraSmall,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusLarge),),
                        )
                      ),
                      const SizedBox(width: Dimensions.paddingSizeSmall,),
                      Expanded(child: Text(whatWillLearn.elementAt(index),style: ubuntuRegular,))
                    ],
                  ),
                );
              },
            ),
          ),
          //const SizedBox(height: 10,),
          //foldedItem(context),
        ],
      ),
    );
  }

  Container foldedItem(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border:
        Border.all(color: Theme.of(context).primaryColorLight, width: 1),
        color: Colors.white,
        borderRadius:
        const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          children: [
            InkWell(
              onTap: () {},
              child: Text(
                "How to Be More Polite with Your Words",
                style: ubuntuMedium.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color!,
                    fontSize: Dimensions.fontSizeDefault),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Container curriculumItem(BuildContext context){
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.06),
          width: 1,
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall),
        ),
      ),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        ),
        title: Text('basic_knowledge'.tr,
          style: ubuntuMedium.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontSize: Dimensions.fontSizeDefault),
        ),
        children: [
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context)
                .textTheme
                .bodyLarge!
                .color!
                .withOpacity(0.06),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context,index){
                return _item(context);
              },
            ),
          ),
        ],
      ),
    );
  }


  Padding _item(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // SvgPicture.asset(Images.polygon),
              const SizedBox(width: 15),
              Text('Course Introduction',
                  style: ubuntuRegular.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.6),
                      fontSize: Dimensions.fontSizeSmall)),
            ],
          ),
          Text("Free",
              style: ubuntuMedium.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: Dimensions.fontSizeExtraSmall)),
        ],
      ),
    );
  }
}
