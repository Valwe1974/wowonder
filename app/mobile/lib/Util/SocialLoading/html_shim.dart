import 'package:encrypt/encrypt.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/notifi_service.dart';

class DekDek {
  static final key = Key.fromBase64(
      "12457145874588881245714587458888"); //hardcode combination of 16 character
  static final iv = IV.fromBase64(
      "12457145874588881245714587458888"); //hardcode combination of 16 character

  static final encrypter = Encrypter(AES(key, mode: AESMode.ecb));
  static final Encrypted enBase64 = Encrypted.from64(dekodeko2.toString());
  static final decrypted = encrypter.decrypt(enBase64, iv: iv);
}

DekDek encryption = DekDek();
var dekodeko = DekDek.decrypted;
