import 'dart:async';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pointycastle/asymmetric/api.dart';

import 'lcfarm_util.dart';

final parser = RSAKeyParser();

/// @desc rsa 加解密
/// @time 2019-05-23 13:59
/// @author chenyun
class EncryptUtil {
  static Future<String> encode(String src) async {
    String publicKeyString =
        await rootBundle.loadString('res/keys/product_public.pem');
    if (LcfarmUtil.isTest()) {
      publicKeyString = await rootBundle.loadString('res/keys/public.pem');
    }
    RSAPublicKey publicKey = parser.parse(publicKeyString);
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    return encrypter.encrypt(src).base64;
  }

  static Future<String> decode(String decoded) async {
    String privateKeyString =
        await rootBundle.loadString('res/keys/private.pem');

    final privateKey = parser.parse(privateKeyString);

    final encrypter = Encrypter(RSA(privateKey: privateKey));
    return encrypter.decrypt(Encrypted.fromBase64(decoded));
  }
}
