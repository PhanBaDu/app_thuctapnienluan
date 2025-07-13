import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/core/helper/price_converter.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class RowText extends StatelessWidget {
  final String title;
  final int? quantity;
  final double price;
  const RowText({Key? key,required this.title,required this.price,this.quantity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(title,
                    maxLines: 2,
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
                ),
                Text(quantity==null?"" : " x $quantity")
              ],
            ),
          ),
          Text('${title.contains('Discount') ? '(-)':title == 'VAT' ? '(+)':''} ${PriceFormatter.formatPrice(double.parse(price.toString()),isShowLongPrice:true)}')
        ],
      ),
    );
  }
}
