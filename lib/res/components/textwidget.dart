import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
    required this.left,
    required this.right,
    required this.top,
    required this.bottom,
    this.textcolor,
    this.fontsize, this.fontWeight,
  });
  final String text;
  final double left;
  final double right;
  final double top;
  final double bottom;
  final Color? textcolor;
  final double? fontsize;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding:
            EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        child: Text(
          text,
          style: TextStyle(
            color: textcolor,
            fontSize: fontsize,
            decoration: TextDecoration.none,
            fontWeight: fontWeight
          ),
        ),
      ),
    );
  }
}
