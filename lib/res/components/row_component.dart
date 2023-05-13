

import 'package:flutter/material.dart';
import 'package:ghmcofficerslogin/res/components/textwidget.dart';

class RowComponent extends StatelessWidget {
  const RowComponent({super.key, this.horizantalpadding, this.verticalpadding, this.data, this.value, this.width, this.dataflex, this.valueflex,this.color, this.fontsize, this.fontweight});
  final double? horizantalpadding;
  final double? verticalpadding;
  final String? data;
  final String? value;
  final double? width;
  final int? dataflex;
  final int? valueflex;
  final Color? color;
  final double? fontsize;
  final FontWeight? fontweight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizantalpadding ?? 0.0,vertical: verticalpadding ?? 0.0),
      child: Row(
        children: [
          Expanded(
            flex: dataflex ?? 0,
            child: Text(data ?? '',
            style: TextStyle(
              color: color,
              fontSize: fontsize,
              fontWeight: fontweight,
            ),
            )),
          SizedBox(width: width,),
          Expanded(
            flex: valueflex ?? 0,
            child: Text(value ?? '',
            style: TextStyle(
              color: color,
              fontSize: fontsize,
              fontWeight: fontweight,
            ),
            ))
        ],
      ),
    );
  }
}

checkStatusRowComponent(var data, var val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 1,
              child: TextWidget(
                text: "${data}",
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                textcolor: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          Expanded(
              flex: 2,
              child: TextWidget(
                text: "${val}",
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                textcolor: Colors.blueGrey,
              ))
        ],
      ),
    );
  }

  Line() {
    return Divider(
      thickness: 1.0,
      color: Colors.grey,
    );
  }