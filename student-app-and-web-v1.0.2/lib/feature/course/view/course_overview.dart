import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_lms_flutter/components/rating_bar.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/images.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class CourseOverView extends StatelessWidget {
  final String title;
  final String description;
  final String instructor;
  final String lastUpdate;
  const CourseOverView({
    Key? key,
    required this.title,
    required this.description,
    required this.instructor,
    required this.lastUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          Text(description, style: ubuntuRegular,),
          const SizedBox(height: Dimensions.paddingSizeSmall,),
          Row(
            children: [
              Image.asset(Images.lastUpdate,scale: 2,),
              const SizedBox(width: Dimensions.paddingSizeSmall,),
              Text("${'last_update'.tr} $lastUpdate",style: ubuntuRegular.copyWith(
                  color: Theme.of(context).textTheme.bodySmall!.color
              ),),
            ],
          ),



        ],
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.text, {
    Key? key,
    this.trimLines = 2,
  }) : super(key: key);

  final String text;
  final int trimLines;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;
  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    TextSpan link = TextSpan(
        text: _readMore ? 'see_more'.tr : 'read_less'.tr,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.4),
        ),
        recognizer: TapGestureRecognizer()..onTap = _onTapLink);
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        final text = TextSpan(
          text: widget.text,
        );

        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection
              .rtl, //better to pass this from master widget if ltr and rtl both supported
          maxLines: widget.trimLines,
          ellipsis: '...',
        );

        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        int endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));

        endIndex = textPainter.getOffsetBefore(pos.offset)!;
        TextSpan textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: _readMore ? widget.text.substring(0, endIndex) : widget.text,
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.6),
            ),
            children: <TextSpan>[link],
          );
        } else {
          textSpan = TextSpan(
            text: widget.text,
          );
        }

        return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text: textSpan,
        );
      },
    );
    return result;
  }
}
