import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class datePickerComponent extends StatelessWidget {
  const datePickerComponent(
      {super.key,
     this.hintText,
      required this.nameController,
      required this.errorMessage,
      this.input_type,
      required this.obsecuretext,
       this.node,
      required this.action,
      this.onEditingComplete,
      this.globalKey,
      this.prefixIcon,
      // this.isSecured,
      // this.isVisible,
      this.onTap,
      this.suffixIcon});
  final String? hintText, errorMessage;
  final TextEditingController nameController;
  final TextInputType? input_type;
  final bool obsecuretext;
  final FocusScopeNode? node;
  final TextInputAction action;
  final VoidCallback? onEditingComplete;
  final GlobalKey? globalKey;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  // final IconData? suffixIcon;
  // final bool? isSecured;
  // final bool? isVisible;

  final void Function()? onTap;
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: TextFormField(
        obscureText: obsecuretext,
        textInputAction: action,
        
    
        onEditingComplete: onEditingComplete,
        style: const TextStyle(color: Colors.black),
        controller: nameController,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black),
          prefixIcon: prefixIcon,
          //suffixIcon: null == suffixIcon ? null : Icon(suffixIcon),
          suffixIcon: suffixIcon,
         /*  enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10),
               borderSide: BorderSide(color: Colors.black)), */
          labelStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          labelText: hintText,
        ),
        onTap: () async {
    await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2015),
    lastDate: DateTime(2025),
    ).then((selectedDate) {
    if (selectedDate != null) {
    nameController.text =
        DateFormat('dd/MM/yyyy').format(selectedDate);
    }
    });
  },
        validator: (value) {
          if (value!.isEmpty) {
            return "${errorMessage}";
          }
        },
        keyboardType: input_type,
      ),
    );
  }
}
