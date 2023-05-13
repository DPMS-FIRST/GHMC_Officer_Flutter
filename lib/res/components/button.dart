import 'package:flutter/material.dart';

class textButton extends StatelessWidget {
  const textButton(
      {super.key,
      required this.text,
      this.backgroundcolor,
      this.height,
      this.width, this.textcolor, this.onPressed});
  final String text;
  final Color? backgroundcolor;
  final double? height;
  final double? width;
  final Color? textcolor;
  final GestureTapCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundcolor,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 14.0,
              fontFamily: "Poppins"),
        ),
      ),
    );
  }
}
//button
                  /*  GestureDetector(
                    onTap: (() {
                      if (_formKey.currentState!.validate()) {
                       // fetchLoginDetailsFromApi();
                      }
                    }),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        width: 80,
                        height: 40,
                        color: Color.fromARGB(255, 9, 16, 20),
                        child: const Center(
                            child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ), */