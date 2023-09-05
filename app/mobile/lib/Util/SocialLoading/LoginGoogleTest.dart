// import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:googleapis_auth/googleapis_auth.dart' as auth show AuthClient;
// import 'package:googleapis/people/v1.dart';

// final GoogleSignIn _googleSignIn = GoogleSignIn(
//   // Optional clientId
//   // clientId: '[YOUR_OAUTH_2_CLIENT_ID]',
//   scopes: <String>[PeopleServiceApi.contactsReadonlyScope],
// );

// class LoginGoogleTest extends StatefulWidget {
//   /// Creates the main widget of this demo.
//   const LoginGoogleTest({super.key});

//   @override
//   State createState() => LoginGoogleTestState();
// }

// /// The state of the main widget.
// class LoginGoogleTestState extends State<LoginGoogleTest> {
//   GoogleSignInAccount? _currentUser;
//   String _contactText = '';

//   @override
//   void initState() {
//     super.initState();
//     _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
//       setState(() {
//         _currentUser = account;
//       });
//       if (_currentUser != null) {
//         _handleGetContact();
//       }
//     });
//     _googleSignIn.signInSilently();
//   }

//   Future<void> _handleGetContact() async {
//     setState(() {
//       _contactText = 'Loading contact info...';
//     });

//     // Retrieve an [auth.AuthClient] from the current [GoogleSignIn] instance.
//     final auth.AuthClient? client = await _googleSignIn.authenticatedClient();

//     assert(client != null, 'Authenticated client missing!');

//     // Prepare a People Service authenticated client.
//     final PeopleServiceApi peopleApi = PeopleServiceApi(client!);
//     // Retrieve a list of the `names` of my `connections`
//     final ListConnectionsResponse response =
//         await peopleApi.people.connections.list(
//       'people/me',
//       personFields: 'names',
//     );

//     final String? firstNamedContactName =
//         _pickFirstNamedContact(response.connections);

//     setState(() {
//       if (firstNamedContactName != null) {
//         _contactText = 'I see you know $firstNamedContactName!';
//       } else {
//         _contactText = 'No contacts to display.';
//       }
//     });
//   }

//   String? _pickFirstNamedContact(List<Person>? connections) {
//     return connections
//         ?.firstWhere(
//           (Person person) => person.names != null,
//         )
//         .names
//         ?.firstWhere(
//           (Name name) => name.displayName != null,
          
//         )
//         .displayName;
//   }

//   Future<void> _handleSignIn() async {
//     try {
//       await _googleSignIn.signIn();
//       print(_googleSignIn.currentUser);
//     } catch (error) {
//       print(error); // ignore: avoid_print
//     }
//   }

//   Future<void> _handleSignOut() => _googleSignIn.disconnect();

//   Widget _buildBody() {
//     final GoogleSignInAccount? user = _currentUser;
//     if (user != null) {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           ListTile(
//             leading: GoogleUserCircleAvatar(
//               identity: user,
//             ),
//             title: Text(user.displayName ?? ''),
//             subtitle: Text(user.email),
//           ),
//           const Text('Signed in successfully.'),
//           Text(_contactText),
//           ElevatedButton(
//             onPressed: _handleSignOut,
//             child: const Text('SIGN OUT'),
//           ),
//           ElevatedButton(
//             onPressed: _handleGetContact,
//             child: const Text('REFRESH'),
//           ),
//         ],
//       );
//     } else {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           const Text('You are not currently signed in.'),
//           ElevatedButton(
//             onPressed: _handleSignIn,
//             child: const Text('SIGN IN'),
//           ),
//         ],
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Google Sign In + googleapis'),
//         ),
//         body: ConstrainedBox(
//           constraints: const BoxConstraints.expand(),
//           child: _buildBody(),
//         ));
//   }
// }
