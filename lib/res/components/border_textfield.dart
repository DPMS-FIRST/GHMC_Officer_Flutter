import 'package:flutter/material.dart';

class BorderTextfield extends StatelessWidget {
  const BorderTextfield(
      {super.key,
      this.hinttext,
      this.textalignpadding,
      this.focusNode,
      this.hinttextcolor,
      this.fontWeight,
      this.fontsize,
      this.horizantalpadding,
      this.verticalpadding,
      this.containerheight,
      this.containerwidth,
      this.controller,
       this.maxlines,
      this.tap,
      this.contentpadding, this.enabletext, required this.textAlign});
  final String? hinttext;
  final double? textalignpadding;
  final FocusNode? focusNode;
  final Color? hinttextcolor;
  final FontWeight? fontWeight;
  final double? fontsize;
  final double? horizantalpadding;
  final double? verticalpadding;
  final double? containerheight;
  final double? containerwidth;
  final TextEditingController? controller;
  final int? maxlines;
  final void Function()? tap;
  final double? contentpadding;
  final bool? enabletext;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizantalpadding ?? 0, vertical: verticalpadding ?? 0),
        child: Container(
          width: MediaQuery.of(context).size.width * containerwidth!,
          height: MediaQuery.of(context).size.height * containerheight!,
          color: Colors.white,
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: textalignpadding ?? 0),
              child: TextFormField(
                textAlign: textAlign ,
                enabled: enabletext,
                onTap: tap,
                focusNode: focusNode,
                controller: controller,
                maxLines: maxlines,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(contentpadding!),
                    hintText: hinttext,
                    hintStyle: TextStyle(
                        color: hinttextcolor,
                        fontSize: fontsize,
                        fontWeight: fontWeight)),
              ),
            ),
          ),
        ));
  }
}
