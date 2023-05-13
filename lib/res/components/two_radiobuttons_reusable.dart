import 'package:flutter/material.dart';

class TwoRadioButtonsRow extends StatelessWidget {
  final String option1Text;
  final String option2Text;
  final ValueNotifier<bool> groupValue;
  final ValueChanged<bool>? onOption1Selected;
  final ValueChanged<bool>? onOption2Selected;

  const TwoRadioButtonsRow({
    Key? key,
    required this.option1Text,
    required this.option2Text,
    required this.groupValue,
    this.onOption1Selected,
    this.onOption2Selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<bool>(
          value: true,
          groupValue: groupValue.value,
          onChanged: (selected) {
            groupValue.value = selected ?? false;
            if (onOption1Selected != null) {
              onOption1Selected!(groupValue.value);
            }
          },
        ),
        Text(option1Text),
        Radio<bool>(
          value: false,
          groupValue: groupValue.value,
          onChanged: (selected) {
            groupValue.value = selected ?? false;
            if (onOption2Selected != null) {
              onOption2Selected!(groupValue.value);
            }
          },
        ),
        Text(option2Text),
      ],
    );
  }
}
