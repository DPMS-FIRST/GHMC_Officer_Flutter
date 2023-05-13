import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  flutterToast(String message, bool set) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: set ? ToastGravity.TOP : ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: set ? Colors.red : Colors.green,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor ?? ''; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }

  /*  Future<String> getDeviceId() async {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String deviceId = '';

  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      deviceId = androidDeviceInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor ?? '';
    }
  } catch (e) {
    print('Failed to get device ID: $e');
  }

  return deviceId;
} */

  /* Future<bool?> checkInternetConnection(BuildContext context) async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      return true;
    } else if (result == ConnectivityResult.none) {
      return false;
    }
  } */
}
