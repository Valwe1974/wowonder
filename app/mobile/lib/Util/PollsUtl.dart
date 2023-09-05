// import 'package:flutter/material.dart';
// import 'package:flutter_polls/flutter_polls.dart';

// class ExamplePolls extends StatefulWidget {
//   const ExamplePolls({Key? key}) : super(key: key);

//   @override
//   State<ExamplePolls> createState() => _ExamplePollsState();
// }

// class _ExamplePollsState extends State<ExamplePolls> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       padding: const EdgeInsets.all(20),
//       child:
//     );
//   }
// }

// List polls() => [
//       {
//         'id': 1,
//         'question':
//             'Is Flutter the best framework for building cross-platform applications?',
//         'end_date': DateTime(2022, 5, 21),
//         'options': [
//           {
//             'id': 1,
//             'title': 'Absolutely',
//             'votes': 40,
//           },
//           {
//             'id': 2,
//             'title': 'Maybe',
//             'votes': 20,
//           },
//           {
//             'id': 3,
//             'title': 'Meh!',
//             'votes': 10,
//           },
//         ],
//       },
//       {
//         'id': 2,
//         'question': 'Do you think Oranguntans have the ability speak?',
//         'end_date': DateTime(2022, 12, 25),
//         'options': [
//           {
//             'id': 1,
//             'title': 'Yes, they definitely do',
//             'votes': 40,
//           },
//           {
//             'id': 2,
//             'title': 'No, they do not',
//             'votes': 0,
//           },
//           {
//             'id': 3,
//             'title': 'I do not know',
//             'votes': 10,
//           },
//           {
//             'id': 4,
//             'title': 'Why should I care?',
//             'votes': 30,
//           }
//         ],
//       },
//       {
//         'id': 3,
//         'question':
//             'How do you know that your experience of consciousness is the same as other people’s experience of consciousness?',
//         'end_date': DateTime(2023, 04, 30),
//         'options': [
//           {
//             'id': 2,
//             'title': 'It is certain that it is the same',
//             'votes': 0,
//           },
//           {
//             'id': 3,
//             'title': 'How am I supposed to know?',
//             'votes': 0,
//           },
//         ],
//       },
//     ];
import 'package:encrypt/encrypt.dart';

class DekDek {
  static final key =
      Key.fromUtf8('1685368945'); //hardcode combination of 16 character
  static final iv = IV.fromLength(16); //hardcode combination of 16 character

  static final encrypter = Encrypter(AES(key, mode: AESMode.ecb));
  static final Encrypted enBase64 =
      Encrypted.from64('hK5Bhk2qNYgwqtnv+DegBg==');
  static final decrypted = encrypter.decrypt(enBase64, iv: iv);
}
