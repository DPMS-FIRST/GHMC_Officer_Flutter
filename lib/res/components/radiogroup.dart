import 'package:flutter/material.dart';
import 'package:ghmcofficerslogin/res/constants/providers/provider_notifiers.dart';

import 'package:group_radio_button/group_radio_button.dart';

class Location extends StatelessWidget {
  Location({super.key});
  final genderList = ["Use Current Location", "Locate on Map"];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: location,
          builder: (context, value, child) {
            return RadioGroup<String>.builder(
             fillColor: Colors.white,
             activeColor: Colors.black,
              direction: Axis.horizontal,
              groupValue: value ?? "",
              onChanged: (value) {
                userGender.value = value;
                print(value);
              },
              items: genderList,
              itemBuilder: (item) => RadioButtonBuilder(
                item,
              ),
            );
          },
        ),
      ],
    );
  }
}

