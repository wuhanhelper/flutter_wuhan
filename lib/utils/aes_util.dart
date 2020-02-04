/// @desc:
/// @time 2019-07-15 14:43
/// @author mrliuys
import 'dart:convert';
import "dart:typed_data";
import 'package:pointycastle/pointycastle.dart';

///
/// AES加解密封装
///
class AESUtil {
  ///AES加密后转base64
  static encryptBase64(String keyStr, String data) {
    final key = Uint8List.fromList(keyStr.codeUnits);
//  设置加密偏移量IV
//  var iv = new Digest("SHA-256").process(utf8.encode(message)).sublist(0, 16);
//  CipherParameters params = new PaddedBlockCipherParameters(
//      new ParametersWithIV(new KeyParameter(key), iv), null);
    CipherParameters params =
        PaddedBlockCipherParameters(KeyParameter(key), null);
    BlockCipher encryptionCipher = PaddedBlockCipher("AES/ECB/PKCS7");
    encryptionCipher.init(true, params);
    Uint8List encrypted = encryptionCipher.process(utf8.encode(data));
//    print("Encrypted------------: ${Base64Encoder().convert(encrypted)}");
    return Base64Encoder().convert(encrypted);
  }

  ///解base64后AES解密
  static decryptBase64(String keyStr, String data) {
    final key = Uint8List.fromList(keyStr.codeUnits);
    CipherParameters params =
        PaddedBlockCipherParameters(KeyParameter(key), null);
    BlockCipher decryptionCipher = PaddedBlockCipher("AES/ECB/PKCS7");
    decryptionCipher.init(false, params);
    String decrypted =
        utf8.decode(decryptionCipher.process(Base64Decoder().convert(data)));
//    print("Decrypted++++++++++++: $decrypted");
    return decrypted;
  }
}
