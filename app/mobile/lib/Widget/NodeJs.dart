// import 'package:web_socket_client/web_socket_client.dart';

// Soco() async {
//   // Create a WebSocket client.
//   final uri = Uri.parse(
//       'https://demo.ameenhost.com:4449/socket.io/?EIO=3&transport=polling');
//   const backoff = ConstantBackoff(Duration(seconds: 1));
//   final socket = WebSocket(uri, backoff: backoff);

//   // Listen for changes in the connection state.
//   socket.connection.listen((state) => print('state: "$state"'));
//   socket.connection.join();

//   socket.connection.join()
// //   socket.emit(accounts[0]['jo'], {
// //     accounts[0]['u']: n,
// //     accounts[0]['use']: tok,
// //   });
//   // Listen for incoming messages.
//   socket.messages.listen((message) {
//     print('ameen hamed: "$message"');

//     // Send a message to the server.
//     socket.send('ping');
//   });

//   await Future<void>.delayed(const Duration(seconds: 3));

//   // Close the connection.
//   socket.close();
// }
