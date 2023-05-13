import 'package:flutter/material.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/constants/text_constants/text_constants.dart';

class SingleButtonDialogBox extends StatefulWidget {
  final String descriptions;
  final Image img;
  final Color? bgColor;
  final void Function()? onPressed;

  const SingleButtonDialogBox({
    Key? key,
    required this.descriptions,
    required this.img,
    required this.onPressed,
    this.bgColor,
  }) : super(key: key);

  @override
  _SingleButtonDialogBox createState() => _SingleButtonDialogBox();
}

class _SingleButtonDialogBox extends State<SingleButtonDialogBox> {
  var versionNumber;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, top: 50, right: 10, bottom: 10),
          margin: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Version : ${versionNumber ?? ''}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
               'GHMC OFFICER APP',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(250, 40)),
                      backgroundColor: MaterialStateProperty.all(
                          widget.bgColor ?? Color.fromARGB(255, 236, 179, 7)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    onPressed: widget.onPressed,
                    child: Text(
                      TextConstants.ok,
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: 10,
          right: 10,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: widget.img,
                )),
          ),
        ),
      ],
    );
  }

   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      versionNumber = await SharedPreferencesClass()
          .readTheData(PreferenceConstants.versionNumber);
      
    });
  }
}
