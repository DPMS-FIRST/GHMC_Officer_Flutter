import 'package:flutter/material.dart';


class ServiceText extends StatelessWidget {
  const ServiceText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10.0),
      child: Text(
      text,
        style: TextStyle(
        fontSize: 20.0, 
        color: Colors.white),
      ),
    );
  }
}

class ServiceTextLabel extends StatelessWidget {
  const ServiceTextLabel({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10.0),
      child: Text(
      text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        fontSize: 20.0, 
        color: Colors.white),
      ),
    );
  }
}