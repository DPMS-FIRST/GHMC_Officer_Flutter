import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

import 'package:uuid/uuid.dart';

getDeviceId() async {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      return androidDeviceInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      return iosDeviceInfo.identifierForVendor ?? '';
    }
  } catch (e) {
    print('Failed to get device ID: $e');
  }

  return null;
}

String generateDeviceId() {
  var uuid = Uuid();
  var deviceId = uuid.v4();
  var shortDeviceId = deviceId.replaceAll('-', '').substring(0, 16);
  return shortDeviceId;
}
