import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ListShimmer extends StatelessWidget {
  const ListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(seconds: 3),
      interval: const Duration(seconds: 4),
      color: Theme.of(context).primaryColor,
      colorOpacity: 0,
      enabled: true,
      direction: const ShimmerDirection.fromLTRB(),
      child: SizedBox(
        height: context.height,
        width: context.width,
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeDefault),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                          ),
                        ),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeDefault,),
                      Expanded(
                          child: Container(
                              width: 200,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                                ),
                              )))
                    ],
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault,),
                  Container(
                      height: 25,
                      width: context.width*.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color:Theme.of(context).primaryColor.withOpacity(0.10),
                      )
                  )
                ],
              ),
            );
          },
        ),
      ),

    );
  }
}