import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ChattingShimmer extends StatelessWidget {
  const ChattingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SizedBox(
          width: Dimensions.webMaxWidth,
          child: Shimmer(
              duration: const Duration(seconds: 3),
              interval: const Duration(seconds: 5),
              color: Theme.of(context).primaryColor,
              colorOpacity: 0,
              enabled: true,
              direction: const ShimmerDirection.fromLTRB(),
              child: SizedBox(
                height:Get.height*0.80,
                child: SingleChildScrollView(
                    child: Column(children:[
                      Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                          height: 65,
                          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                            Container(height: 50, width: 50,
                                decoration: BoxDecoration(gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                                ), borderRadius: const BorderRadius.all(Radius.circular(100)))
                            ),
                            const SizedBox(width: Dimensions.paddingSizeDefault),
                            Container(height: 40, width: 200,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                                    ),
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.radiusDefault),topLeft: Radius.circular(Dimensions.radiusDefault), bottomRight: Radius.circular(Dimensions.radiusDefault))
                                )),
                          ])
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                          height: 50,
                          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                            Container(height: 40, width: 200,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                                    ),
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.radiusDefault),topLeft: Radius.circular(Dimensions.radiusDefault), bottomLeft: Radius.circular(Dimensions.radiusDefault))
                                )),
                            const SizedBox(width: Dimensions.paddingSizeDefault),
                            Container(
                                height: 50, width: 50,
                                decoration: BoxDecoration(gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                                ), borderRadius: const BorderRadius.all(Radius.circular(100)))
                            ),
                          ])
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                          child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Container(
                                height: 50, width: 50,
                                decoration: BoxDecoration(gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                                ),
                                    borderRadius: const BorderRadius.all(Radius.circular(100)))
                            ),
                            const SizedBox(width: Dimensions.paddingSizeDefault),
                            Container(
                                height: 80,
                                width: 250,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                                ),
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.radiusDefault),topLeft: Radius.circular(Dimensions.radiusDefault), bottomRight: Radius.circular(Dimensions.radiusDefault))
                                )),
                          ])
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                          height: 65,
                          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                            Container(
                                height: 40,
                                width: 200,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                                ),
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.radiusDefault),topLeft: Radius.circular(Dimensions.radiusDefault), bottomLeft: Radius.circular(Dimensions.radiusDefault))
                                )),
                            const SizedBox(width: Dimensions.paddingSizeDefault),
                            Container(
                                height: 50, width: 50,
                                decoration: BoxDecoration(gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                                ),
                                    borderRadius: const BorderRadius.all(Radius.circular(100)))
                            ),
                          ])
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                          child: Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Container(height: 80, width: 250,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                                ),
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.radiusDefault),topLeft: Radius.circular(Dimensions.radiusDefault), bottomLeft: Radius.circular(Dimensions.radiusDefault))
                                )),
                            const SizedBox(width: Dimensions.paddingSizeDefault),
                            Container(
                                height: 50, width: 50,
                                decoration: BoxDecoration(gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                                ),  borderRadius: const BorderRadius.all(Radius.circular(100)))
                            ),
                          ])
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                          height: 50,
                          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                            Container(
                                height: 50, width: 50,
                                decoration: BoxDecoration(gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                                ),  borderRadius: const BorderRadius.all(Radius.circular(100)))
                            ),
                            const SizedBox(width: Dimensions.paddingSizeDefault),
                            Container(
                                height: 40,
                                width: 200,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                                    ),
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.radiusDefault),topLeft: Radius.circular(Dimensions.radiusDefault), bottomRight: Radius.circular(Dimensions.radiusDefault))
                                )),
                          ])
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                          height: 50,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    height: 50, width: 50,
                                    decoration: BoxDecoration(gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                                ),  borderRadius: const BorderRadius.all(Radius.circular(100)))
                                ),
                                const SizedBox(width: Dimensions.paddingSizeDefault),
                                Container(
                                    height: 40,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                                ),
                                        borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.radiusDefault),topLeft: Radius.circular(Dimensions.radiusDefault), bottomRight: Radius.circular(Dimensions.radiusDefault))
                                    )),
                              ])
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                          height: 65,
                          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                            Container(
                                height: 40,
                                width: 200,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                                    ),
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.radiusDefault),topLeft: Radius.circular(Dimensions.radiusDefault), bottomLeft: Radius.circular(Dimensions.radiusDefault))
                                )),
                            const SizedBox(width: Dimensions.paddingSizeDefault),
                            Container(
                                height: 50, width: 50,
                                decoration: BoxDecoration(gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                                ),
                                    borderRadius: const BorderRadius.all(Radius.circular(100)))
                            ),
                          ])
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                          child: Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Container(height: 80, width: 250,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                                    ),
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.radiusDefault),topLeft: Radius.circular(Dimensions.radiusDefault), bottomLeft: Radius.circular(Dimensions.radiusDefault))
                                )),
                            const SizedBox(width: Dimensions.paddingSizeDefault),
                            Container(
                                height: 50, width: 50,
                                decoration: BoxDecoration(gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[Theme.of(context).primaryColor.withOpacity(0.10), Theme.of(context).primaryColor.withOpacity(0.2), Theme.of(context).primaryColor.withOpacity(0.10),]
                                ),  borderRadius: const BorderRadius.all(Radius.circular(100)))
                            ),
                          ])
                      ),
                    ]
                    )),
              )
          ),
        ),
      ),
    );
  }
}