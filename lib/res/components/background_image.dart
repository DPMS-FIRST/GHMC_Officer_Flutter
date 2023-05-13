import 'package:flutter/material.dart';

class BgImage extends StatelessWidget {
  const BgImage({
    super.key,
    required this.imgPath, 
  });
  final String imgPath;
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(imgPath), fit: BoxFit.fill),
          ),
          // child: AspectRatio(aspectRatio:16/9),
        )
      ],
    ); /* Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/bg.png"), fit: BoxFit.cover),
      ),
    ); */
  }
}
