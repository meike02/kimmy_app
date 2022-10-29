import 'dart:convert';

import 'package:encrypt/encrypt.dart';
String? _compute(String? text,bool encrypt){
  final key = Key.fromUtf8('2we1sdk876tyh3mnb8l099hgtredazcn');
  final iv = IV.fromLength(16);
  final encryptor = Encrypter(AES(key));
  if(text == null || text == ""){
    return null;
  } else {
    if (encrypt){
      final encryptedText = encryptor.encrypt(text, iv: iv);
      return encryptedText.base64;
    } else {
      final sshKeyDataBytes = base64Decode(text);
      final encryptedText = Encrypted(sshKeyDataBytes);
      return encryptor.decrypt(encryptedText,iv: iv);
    }
  }
}

String? encrypt(String? text){
  return _compute(text, true);
}

String? decrypt(String? encryptedText){
  return _compute(encryptedText, false);
}