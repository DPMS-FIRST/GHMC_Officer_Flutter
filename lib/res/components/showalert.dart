
import 'package:flutter/material.dart';

class Alerts {
  static showAlertDialog(BuildContext context, var message,
      {required var Title,
      required Function() onpressed,
      Color? buttoncolor,
      Color? buttontextcolor,
      required String buttontext}) {
    Widget okButton = Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
              width: double.infinity,
              // height: MediaQuery.of(context).size.height * 0.05,
              margin: EdgeInsets.only(left: 12.0, right: 12.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: buttoncolor ?? Colors.green),
              child: TextButton(
                onPressed: onpressed,
                child: Text(
                  buttontext,
                  style: TextStyle(
                      color: buttontextcolor ?? Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ),
      ],
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        Title.toString(),
        textAlign: TextAlign.center,
      ),
      content: Text(
        "${message.toString()}",
        textAlign: TextAlign.center,
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: <Widget>[
          alert
        ],);
      },
    );
  }
}
