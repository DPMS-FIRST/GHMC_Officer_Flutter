import 'package:flutter/material.dart';

class Grievances extends StatelessWidget {
  const Grievances({
    super.key,
    required this.img,
    required this.text,
    this.textcolor,
    this.fontsize,
    this.height,
    this.width,
    this.onPressed,
  });
  final String img;
  final String text;
  final Color? textcolor;
  final double? fontsize;
  final double? height;
  final double? width;
  final GestureTapCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
          onPressed: onPressed,
          child: Column(
            children: [
              Image.asset(
                img,
                height: height,
                width: width,
              ),
              Center(
                  child: Text(
                text,
                style: TextStyle(
                  color: textcolor,
                  fontSize: 12.0
                  ),
              )),
            ],
          )),
    );
  }
}
