import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:wowondertimelineflutterapp/Util/SocialLoading/html_shim.dart';

class AESEncryption {
  static final key = encrypt.Key.fromLength(32);
  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  decryptMsg(encrypt.Encrypted text) => encrypter.decrypt(text, iv: iv);

  getCode(String encoded) => encrypt.Encrypted.fromBase16(encoded);
}

AESEncryption encryption = AESEncryption();
var decrypted = encryption.decryptMsg(encryption.getCode(dekodeko));
