import 'package:flutter/material.dart';

class ReusableAppbar extends StatelessWidget {
  const ReusableAppbar({
    super.key,
    required this.topPadding,
    required this.screenWidth,
    required this.screenHeight,
    required this.bgColor,
    required this.appIcon,
    required this.title,
    this.TextColor,
    this.fontSize,
    required this.onPressed,
    this.homeIcon, this.homeTapped,
  });
  final double topPadding;
  final double screenWidth;
  final double screenHeight;
  final Color bgColor;
  final Color? TextColor;
  final double? fontSize;
  final Icon appIcon;
  final Icon? homeIcon;
  final String title;
  final GestureTapCallback onPressed;
  final GestureTapCallback? homeTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * screenWidth,
            height: MediaQuery.of(context).size.height * screenHeight,
            child: Card(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    IconButton(onPressed: onPressed, icon: appIcon),
                    Expanded(
                        child: Center(
                      child: Text(
                        title,
                        style: TextStyle(color: TextColor),
                      ),
                    )),
                    GestureDetector(
                      onTap: homeTapped ,
                        child: Container(
                      child: homeIcon,
                    ))
                  ],
                )),
          ),
        ],
      ),
    );
  }
}