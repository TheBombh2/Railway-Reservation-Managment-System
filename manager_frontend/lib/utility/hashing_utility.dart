

import 'dart:convert';

import 'package:crypto/crypto.dart';

class HashingUtility {

String hashWithSHA256(String content){
  var bytes = utf8.encode(content);
  var digest = sha256.convert(bytes);
  return digest.toString();
}
}