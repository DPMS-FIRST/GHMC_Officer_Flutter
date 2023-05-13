
import 'package:flutter/material.dart';
import 'package:ghmcofficerslogin/model/shared_model.dart';
import 'package:ghmcofficerslogin/res/components/sharedpreference.dart';
import 'package:ghmcofficerslogin/res/components/textwidget.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';



class LogoAndDetails extends StatefulWidget {
  const LogoAndDetails({super.key});

  @override
  State<LogoAndDetails> createState() => _LogoAndDetailsState();
}

class _LogoAndDetailsState extends State<LogoAndDetails> {
  String name = '';
  String mNumber = '';
  String des = '';
  @override
  Widget build(BuildContext context) {
   

    return Container(
     height: MediaQuery.of(context).size.height*0.2,
      child: Column(children: [
        Image.asset(
          ImageConstants.ghmc_logo_new,
          height: 70,
          width: 140,
        ),
        TextWidget(
          text: name,
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          textcolor: Colors.white,
          fontsize: 15,
        ),
        TextWidget(
          text: des,
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          textcolor: Colors.white,
          fontsize: 15,
        ),
        TextWidget(
          text: mNumber,
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          textcolor: Colors.white,
          fontsize: 15,
        ),
      ]),
    );
  }

  @override
  void initState() {
  
    super.initState();
    readsharedprefData();
  }

  Future<void> readsharedprefData() async {
    final empName = await SharedPreferencesClass().readTheData(PreferenceConstants.name);
    var designation = await SharedPreferencesClass().readTheData(PreferenceConstants.designation);
    var mobileNumber =
        await SharedPreferencesClass().readTheData(PreferenceConstants.mobileno);
    // print("read value is $empName");
    // print("design  $designation");
    setState(() {
      name = empName;
    });
    setState(() {
      des = designation;
    });
    setState(() {
      mNumber = mobileNumber;
    });
  }
}