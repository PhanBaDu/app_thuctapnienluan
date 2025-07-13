import 'package:flutter/material.dart';
import 'package:get_lms_flutter/feature/myLearning/model/quiz_details_model.dart';
import 'package:get_lms_flutter/utils/dimensions.dart';
import 'package:get_lms_flutter/utils/styles.dart';

class LabeledRadioButton extends StatefulWidget {
  const LabeledRadioButton(
      {super.key,
      required this.question,
      this.selectedIndex,
      this.isClickable = true,
      this.ans = false,
      this.resultIndex,

      required this.isCorrectAnsSelected});
  final Questions question;
  final ValueChanged<bool> isCorrectAnsSelected;
  final ValueChanged<int?>? selectedIndex;
  final bool? isClickable;
  final bool? ans;
  final int? resultIndex;

  @override
  State<LabeledRadioButton> createState() => _LabeledRadioButtonState();
}

class _LabeledRadioButtonState extends State<LabeledRadioButton> {
  int groupValue = -1;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: Theme.of(context)
                .textTheme
                .bodyLarge!
                .color!
                .withOpacity(0.06)),
        color: Theme.of(context).cardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.question.question!,
              style: ubuntuRegular.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: Dimensions.fontSizeDefault,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: questionList(),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> questionList() => List.generate(
      widget.question.answers?.length ?? 0,
      (index) => optionItem(
          widget.question.answers?.elementAt(index) ?? "", index,));

  Widget optionItem(String option, int value) {
    return InkWell(
      onTap: () => widget.isClickable! ? _handleRadioValueChange(value) : null,
      child: Container(
        decoration: BoxDecoration(
          color:groupValue == value ? Theme.of(context).primaryColor.withOpacity(.2) : widget.resultIndex == value ? widget.ans!? Theme.of(context).primaryColor.withOpacity(.2)  : Theme.of(context).colorScheme.error.withOpacity(.2)  :Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 30,
              child: Radio(
                materialTapTargetSize: MaterialTapTargetSize.padded,
                fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.selected)) {
                    return Theme.of(context).primaryColor;
                  }
                  return Theme.of(context).textTheme.bodyMedium!.color!;
                }),
                value: value,
                groupValue: widget.resultIndex ?? groupValue,
                onChanged: widget.isClickable! ? _handleRadioValueChange : null,
              ),
            ),
            Expanded(
                child: Text(option,
                    style: ubuntuRegular.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.6),
                      fontSize: Dimensions.fontSizeSmall,
                    ))),
          ],
        ),
      )
    );
  }

  void _handleRadioValueChange(int? value) {
    setState(() {
      groupValue = value!;
      //check ans is correct or not
      int correctAnsIndex = int.parse(widget.question.correctAnswer!);
      int givenAnsIndex = value;
      if (correctAnsIndex == givenAnsIndex) {
        widget.isCorrectAnsSelected(true);
      } else {
        widget.isCorrectAnsSelected(false);
      }
      if (widget.selectedIndex != null) {
        widget.selectedIndex!(value);
      }
    });
  }
}
