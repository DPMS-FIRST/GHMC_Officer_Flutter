import 'dart:convert';
import 'dart:io';

convertToBase64(String path) {
    final bytes2 = File(path).readAsBytesSync();
    String img = base64Encode(bytes2);
    return img;
  }