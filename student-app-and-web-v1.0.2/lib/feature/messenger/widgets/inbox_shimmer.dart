import 'package:flutter/material.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class InboxShimmer extends StatelessWidget {
  const InboxShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      itemBuilder: (context, index) {
        return Shimmer(
          duration: const Duration(seconds: 3),
          interval: const Duration(seconds: 5),
          color: Theme.of(context).colorScheme.background,
          colorOpacity: 0,
          enabled: true,
          child: Padding(
            padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
            child: Row(children: [
              CircleAvatar(backgroundColor: Theme.of(context).shadowColor, radius: 20, child: const Icon(Icons.person)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Column(children: [
                    Container(height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                        ),),
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}