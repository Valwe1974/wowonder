// import 'package:flutter_aes_ecb_pkcs5/flutter_aes_ecb_pkcs5.dart';

// Future<void> initPlatformState() async {
//   String pkcs5Progress;

//   //string format
//   var data = "{\"username\":\"helloword\"}";

//   //create 16 byte random key
//   var key = await FlutterAesEcbPkcs5.generateDesKey(128);

//   print(key);

//   //encrypt
//   var encryptText = await FlutterAesEcbPkcs5.encryptString(data, key!);

//   print(encryptText);
//   //decrypt
//   var decryptText = await FlutterAesEcbPkcs5.decryptString(encryptText!, key);

//   print(decryptText);

//   pkcs5Progress = "data:" +
//       data +
//       "\n" +
//       "create key:" +
//       key +
//       "\n" +
//       "encryptText :" +
//       encryptText +
//       "\n" +
//       "decryptText :" +
//       decryptText! +
//       "\n";

//   print(pkcs5Progress);
//   // If the widget was removed from the tree while the asynchronous platform
//   // message was in flight, we want to discard the reply rather than calling
//   // setState to update our non-existent appearance.
 
// }
