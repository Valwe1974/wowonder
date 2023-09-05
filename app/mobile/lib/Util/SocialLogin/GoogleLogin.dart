import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/people/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/String.dart';

class SignInDemo2 extends StatefulWidget {
  const SignInDemo2({super.key});

  @override
  State<SignInDemo2> createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo2> {
  Future<AccessCredentials> obtainCredentials() async {
    await GoogleSignIn().signOut();

    final client = http.Client();

    try {
      return await obtainAccessCredentialsViaUserConsent(
        ClientId(
          '241740928288-lqmjv1ssj6eih5kd08fkk649nvb6eoni.apps.googleusercontent.com',
        ),
        [
          PeopleServiceApi.contactsScope,
        ],
        client,
        _prompt,
      );
    } finally {
      client.close();
    }
  }

  void _prompt(String url) {
    print('Please go to the following URL and grant access:');
    print('  => $url');
    print('');
  }

  _signinWithGoogle() async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? gUser = await GoogleSignIn(
        clientId: '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',
        serverClientId:
            '954615029850-ugbu621fklpkjk35njd3h7d4vqnqg1hn.apps.googleusercontent.com',
        scopes: [
          'email',
        ]
        // forceCodeForRefreshToken: true,
        ).signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    print('authHeaders ${gUser.email.toString()}');
    print('idToken  ${gAuth.idToken}');
    print('ameenjawadhamed  ${gAuth.accessToken}');
    Login_With_Google;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _signinWithGoogle,
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: Get.height * 0.07,
          width: Get.width * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Get.isDarkMode ? Colors.black : Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/google.png',
                height: 30,
                width: 30,
              ),
              // Text(
              //   'Facebook'.tr,
              //   style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class Authentication {
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }
}
