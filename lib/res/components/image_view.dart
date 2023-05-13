import 'package:flutter/material.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';

setImage(_backgroundImage, {void Function()? onTap}) {
  if (_backgroundImage.contains('.pdf')) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(top: 10.0),
        child: Image.asset(
          ImageConstants.viewpdf,
          width: 80,
          height: 50,
        ),
      ),
    );
  } else {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(top: 10.0),
        child: Image.asset(
          ImageConstants.viewimage,
          width: 90,
          height: 80,
        ),
      ),
    );
  }
}

showAlertImage(String? photo, BuildContext context) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          actions: [
            Center(
                child: Container(
                    child: Image.network(
              photo!,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(ImageConstants.no_uploaded);
              },
            ))),
          ],
        );
      });
}

 