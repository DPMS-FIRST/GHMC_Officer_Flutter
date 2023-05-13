import 'package:package_info_plus/package_info_plus.dart';

class appVersion{
   Future<dynamic> getAppVersion()async{
    PackageInfo packageInfo=await PackageInfo.fromPlatform();
    String versionValue=packageInfo.version;
    return versionValue;
  }
} 